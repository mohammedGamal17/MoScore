import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:moscore/app/shared_preferences/shared_preferences.dart';
import 'package:moscore/presentation/resources/colors/color_manager.dart';
import 'package:moscore/presentation/resources/fonts/fonts_manager.dart';
import 'package:moscore/presentation/resources/string/string_manager.dart';
import 'package:moscore/presentation/resources/values/values_manager.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../resources/assets/assets.dart';
import '../../resources/routes/routes_manager.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});

  final List<PageViewModel> _list = [
    PageViewModel(
      body: StringManager.onBoardModelTitle1,
      title: StringManager.onBoardModelSubTitle1,
      image: Lottie.asset(JsonResources.goal),
    ),
    PageViewModel(
      body: StringManager.onBoardModelTitle2,
      title: StringManager.onBoardModelSubTitle2,
      image: Lottie.asset(JsonResources.lineUp),
    ),
    PageViewModel(
      body: StringManager.onBoardModelTitle3,
      title: StringManager.onBoardModelSubTitle3,
      image: Lottie.asset(JsonResources.player),
    ),
  ];

  final AppPreferences _appPreferences = getIt<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backGround,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.backGround,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: ColorManager.backGround,
        elevation: AppSize.s0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s20),
        child: IntroductionScreen(
          pages: _list,
          curve: Curves.bounceInOut,
          onDone: () {
            _appPreferences.setIsOnBoarding();
            Navigator.pushReplacementNamed(context, Routes.login);
          },
          onSkip: () {
            _appPreferences.setIsOnBoarding();
            Navigator.pushReplacementNamed(context, Routes.login);
          },
          showSkipButton: true,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: false,
          back: Icon(Icons.arrow_back, color: ColorManager.primary),
          skip: Text(
            StringManager.skip,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          next: Icon(Icons.arrow_forward, color: ColorManager.primary),
          done: Text(
            StringManager.done,
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontSize: FontsSize.s17),
          ),
          dotsDecorator: DotsDecorator(
            size: const Size.square(AppSize.s10),
            activeSize: const Size(AppSize.s24, AppSize.s10),
            activeColor: ColorManager.primary,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s24),
            ),
          ),
        ),
      ),
    );
  }
}
