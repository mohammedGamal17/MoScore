import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../colors/color_manager.dart';
import 'components.dart';
import '../fonts/fonts_manager.dart';
import '../values/values_manager.dart';
import '../../view_model/cubit/auth_cubit/auth_cubit.dart';

class SocialMediaSection extends StatelessWidget {
  const SocialMediaSection({
    super.key,
    required this.text,
    required this.authCubit,
  });

  final String text;
  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: FontsSize.s14),
        ),
        const SizedBox(height: AppSize.s16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            decorationButton(
              context,
              function: () {},
              width: AppSize.s40,
              radius: AppSize.s20,
              widget: IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.twitter,
                  color: ColorManager.white,
                ),
              ),
            ),
            const SizedBox(width: AppSize.s40),
            decorationButton(
              context,
              function: () {},
              width: AppSize.s40,
              radius: AppSize.s20,
              widget: IconButton(
                onPressed: () {
                  authCubit.signInWithGoogle(context);
                },
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: ColorManager.white,
                ),
              ),
            ),
            const SizedBox(width: AppSize.s40),
            decorationButton(
              context,
              function: () {},
              width: AppSize.s40,
              radius: AppSize.s20,
              widget: IconButton(
                onPressed: () {
                  authCubit.signInWithFacebook(context);
                },
                icon: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: ColorManager.white,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
