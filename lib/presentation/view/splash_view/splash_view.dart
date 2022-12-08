import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:moscore/presentation/resources/assets/assets.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../app/shared_preferences/shared_preferences.dart';
import '../../resources/colors/color_manager.dart';
import '../../resources/constants/constants.dart';
import '../../resources/routes/routes_manager.dart';
import '../../resources/values/values_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = getIt<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConst.splashDelay), _goNext);
  }

  _goNext() {
    _appPreferences.getIsSignIn().then(
      (isSignIn) {
        if (isSignIn) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else {
          _appPreferences.getIsOnBoarding().then(
            (isOnBoardingShow) {
              if (isOnBoardingShow) {
                Navigator.pushReplacementNamed(context, Routes.login);
              } else {
                Navigator.pushReplacementNamed(context, Routes.onBoarding);
              }
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.primary,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: ColorManager.primary,
        elevation: AppSize.s0,
      ),
      body: Center(child: Lottie.asset(JsonResources.player)),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
