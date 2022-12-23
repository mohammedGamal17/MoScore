import 'package:flutter/material.dart';

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
            const Icon(Icons.error),
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
