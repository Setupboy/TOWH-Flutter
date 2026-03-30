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

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  Future<void> _loadBanner() async {
    if (!AdService.instance.canRequestAds) {
      return;
    }

    await AdService.instance.initializeIfAllowed();
    if (!mounted) return;

    final banner = BannerAd(
      adUnitId: AdUnitIds.banner,
      request: const AdRequest(),
      size: AdSize.banner,
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
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
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
