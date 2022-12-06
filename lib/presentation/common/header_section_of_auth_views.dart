import 'package:flutter/material.dart';

import '../resources/colors/color_manager.dart';
import '../resources/fonts/fonts_manager.dart';
import '../resources/values/values_manager.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.headLine});

  final String headLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          headLine,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: FontsSize.s36),
        ),
        const SizedBox(height: AppSize.s10),
        Container(
          height: AppSize.s1_5,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [
                ColorManager.primary,
                ColorManager.selectedItem,
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSize.s40),
      ],
    );
  }
}
