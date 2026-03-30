import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:towh/core/ads/ad_unit_ids.dart';
import 'package:towh/core/storage/app_preferences.dart';

class AdService {
  AdService._();

  static final AdService instance = AdService._();
  static const Duration _interstitialCooldown = Duration(minutes: 2);

  bool _initialized = false;
  InterstitialAd? _interstitialAd;
  DateTime? _lastInterstitialShownAt;

  bool get canRequestAds => AppPreferences.instance.hasAcceptedCookieConsent;

  Future<void> initializeIfAllowed() async {
    if (!canRequestAds || _initialized) return;

    await MobileAds.instance.initialize();
    _initialized = true;
    preloadInterstitial();
  }

  Future<void> updateConsentAndInitializeIfNeeded() async {
    if (canRequestAds) {
      await initializeIfAllowed();
      return;
    }

    _disposeInterstitial();
  }

  void preloadInterstitial() {
    if (!_initialized || !canRequestAds || _interstitialAd != null) {
      return;
    }

    InterstitialAd.load(
      adUnitId: AdUnitIds.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial ad failed to load: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  void showInterstitialThen({required VoidCallback onComplete}) {
    if (!_initialized ||
        !canRequestAds ||
        _interstitialAd == null ||
        _isCooldownActive) {
      onComplete();
      preloadInterstitial();
      return;
    }

    final ad = _interstitialAd;
    _interstitialAd = null;
    var completed = false;

    void finish() {
      if (completed) return;
      completed = true;
      onComplete();
    }

    ad!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        _lastInterstitialShownAt = DateTime.now();
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        preloadInterstitial();
        finish();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('Interstitial ad failed to show: $error');
        ad.dispose();
        preloadInterstitial();
        finish();
      },
    );

    ad.show();
  }

  bool get _isCooldownActive {
    final lastShownAt = _lastInterstitialShownAt;
    if (lastShownAt == null) {
      return false;
    }

    return DateTime.now().difference(lastShownAt) < _interstitialCooldown;
  }

  void _disposeInterstitial() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _initialized = false;
  }
}
