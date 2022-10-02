import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:moscore/presentation/resources/colors/color_manager.dart';
import 'package:moscore/presentation/resources/string/string_manager.dart';
import 'package:moscore/presentation/resources/values/values_manager.dart';

import '../../domain/entities/entities.dart';
import '../resources/assets/assets.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});

  // final List<OnBoardModel> _list = [
  //   OnBoardModel(StringManager.onBoardModelTitle1,
  //       StringManager.onBoardModelSubTitle1, Lottie.asset(JsonResources.goal)),
  //   OnBoardModel(
  //       StringManager.onBoardModelTitle2,
  //       StringManager.onBoardModelSubTitle1,
  //       Lottie.asset(JsonResources.lineUp)),
  //   OnBoardModel(
  //       StringManager.onBoardModelTitle3,
  //       StringManager.onBoardModelSubTitle1,
  //       Lottie.asset(JsonResources.player)),
  // ];

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
      title: StringManager.onBoardModelSubTitle1,
      image: Lottie.asset(JsonResources.player),
      reverse: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s20),
          child: IntroductionScreen(
            pages: _list,
            curve: Curves.bounceInOut,
            
          ),
        ),
      ),
    );
  }
}
