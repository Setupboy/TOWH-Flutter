import 'dart:io';

class AdUnitIds {
  AdUnitIds._();

  // Google-provided test ad unit IDs. Replace these with your own AdMob
  // production IDs before publishing the app.
  static String get banner {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5517983106452773/7833248431';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2435281174';
    }
    throw UnsupportedError('Banner ads are not supported on this platform.');
  }

  static String get interstitial {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5517983106452773/9368955294';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    }
    throw UnsupportedError(
      'Interstitial ads are not supported on this platform.',
    );
  }
}
