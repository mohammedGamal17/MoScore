class AdsHelper {
  static const bool _isTestMode = true;

  static String get appOpenAdsUnitId {
    if (_isTestMode) {
      return 'ca-app-pub-3940256099942544/3419835294';
    }
    return 'REAL ADS UNIT';
  }

  static String get bannerAdsUnitId {
    if (_isTestMode) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return 'REAL ADS UNIT';
  }

  static String get interstitialAdsUnits {
    if (_isTestMode) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return 'REAL ADS UNIT';
  }

  static String get interstitialVideoAdsUnits {
    if (_isTestMode) {
      return 'ca-app-pub-3940256099942544/8691691433';
    }
    return 'REAL ADS UNIT';
  }
}
