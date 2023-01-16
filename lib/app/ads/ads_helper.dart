import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../presentation/resources/colors/color_manager.dart';
import '../../presentation/resources/values/values_manager.dart';

class AdsHelper {
  static const bool _isTestMode = true;

  static String get appId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3641364574605890~4538952172';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3641364574605890~5931176469';
    } else {
      throw UnsupportedError('*** Unsupported Error OS ***');
    }
  }

  static String get bannerUnitId {
    if (_isTestMode) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3641364574605890/8557339800';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3641364574605890/8365768115';
    } else {
      throw UnsupportedError('*** Unsupported Error OS ***');
    }
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => log('Banner Loaded'),
    onAdClicked: (ad) => log('Banner Clicked'),
    onAdOpened: (ad) => log('Banner Opened'),
    onAdClosed: (ad) => log('Banner Closed'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      log('Failed to Load: $error');
    },
  );
}

class BannerAdComponent extends StatefulWidget {
  const BannerAdComponent({super.key});

  @override
  State<BannerAdComponent> createState() => _BannerAdComponentState();
}

class _BannerAdComponentState extends State<BannerAdComponent> {
  BannerAd? bannerAd;
  final AdSize adSize = AdSize(
    width: AppSize.s300.toInt(),
    height: AppSize.s50.toInt(),
  );

  @override
  void initState() {
    super.initState();
    _bannerAdCreate();
  }

  void _bannerAdCreate() {
    bannerAd = BannerAd(
      size: adSize,
      adUnitId: AdsHelper.bannerUnitId,
      listener: AdsHelper.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return bannerAd != null
        ? Center(
          child: Container(
              color: ColorManager.primary,
              width: adSize.width.toDouble(),
              height: adSize.height.toDouble(),
              child: AdWidget(ad: bannerAd!),
            ),
        )
        : Container();
  }
}
