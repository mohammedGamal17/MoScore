import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../assets/assets.dart';
import '../colors/color_manager.dart';
import '../fonts/fonts_manager.dart';
import '../string/string_manager.dart';
import '../values/values_manager.dart';

class NoLiveMatches extends StatelessWidget {
  const NoLiveMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s100,
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            Lottie.asset(
              JsonResources.ball,
              fit: BoxFit.fill,
              height: AppSize.s50,
              width: AppSize.s50,
            ),
            const SizedBox(height: AppSize.s6),
            Text(
              StringManager.noLive,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: FontsSize.s16),
            ),
            const SizedBox(height: AppSize.s4),
            Text(
              StringManager.checkAgainLater,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class NoAvailableData extends StatelessWidget {
  const NoAvailableData({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s230,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              JsonResources.ball,
              fit: BoxFit.cover,
              width: AppSize.s200,
              height: AppSize.s200,
            ),
            const SizedBox(height: AppSize.s6),
            Text(
              StringManager.noAvailableData,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: FontsSize.s18,
                    color: ColorManager.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
