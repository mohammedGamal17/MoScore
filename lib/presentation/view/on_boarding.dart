import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:moscore/presentation/resources/colors/color_manager.dart';
import 'package:moscore/presentation/resources/string/string_manager.dart';
import 'package:moscore/presentation/resources/values/values_manager.dart';


import '../resources/assets/assets.dart';

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
      body: StringManager.onBoardModelTitle2,
      title: StringManager.onBoardModelSubTitle2,
      image: Lottie.asset(JsonResources.player),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s20),
        child: IntroductionScreen(
          pages: _list,
          curve: Curves.bounceInOut,
          onDone: () => null,
          onSkip: () => null,
          // You can override onSkip callback
          showSkipButton: true,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: false,
          //rtl: true, // Display as right-to-left
          back: const Icon(Icons.arrow_back),
          skip: const Text(StringManager.skip,
              style: TextStyle(fontWeight: FontWeight.w600)),
          next: const Icon(Icons.arrow_forward),
          done: const Text(StringManager.done,
              style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
