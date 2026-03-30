import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:towh/core/ads/ad_service.dart';
import 'package:towh/core/ads/ad_unit_ids.dart';

class ConsentAwareBannerAd extends StatefulWidget {
  const ConsentAwareBannerAd({super.key});

  @override
  State<ConsentAwareBannerAd> createState() => _ConsentAwareBannerAdState();
}

class _ConsentAwareBannerAdState extends State<ConsentAwareBannerAd> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _loadBanner();
    });
  }

  Future<void> _loadBanner() async {
    if (_isLoading || !AdService.instance.canRequestAds) {
      return;
    }

    _isLoading = true;
    await AdService.instance.initializeIfAllowed();
    if (!mounted) {
      _isLoading = false;
      return;
    }

    final screenWidth = MediaQuery.sizeOf(context).width.truncate();
    final adSize =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
          screenWidth,
        );

    if (!mounted) {
      _isLoading = false;
      return;
    }
    if (adSize == null) {
      debugPrint('Banner ad size could not be calculated.');
      _isLoading = false;
      return;
    }

    final banner = BannerAd(
      adUnitId: AdUnitIds.banner,
      request: const AdRequest(),
      size: adSize,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }

          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
          _isLoading = false;
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner ad failed to load: $error');
          ad.dispose();
          _isLoading = false;
        },
      ),
    );

    await banner.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      color: Colors.transparent,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
