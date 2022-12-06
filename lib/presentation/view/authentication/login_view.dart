import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/presentation/resources/fonts/fonts_manager.dart';
import 'package:moscore/presentation/resources/string/string_manager.dart';
import 'package:moscore/presentation/resources/values/values_manager.dart';
import 'package:moscore/presentation/view_model/cubit/auth_cubit/auth_cubit.dart';

import '../../common/header_section_of_auth_views.dart';
import '../../common/social_media_buttons_components.dart';
import '../../resources/components/components.dart';
import '../../resources/routes/routes_manager.dart';
import '../../view_model/cubit/auth_cubit/auth_state.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailTextEditController = TextEditingController();
  final _passwordTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p2,
                  horizontal: AppPadding.p20,
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const HeaderSection(headLine: StringManager.login),
                        LoginFormSection(
                          emailTextEditController: _emailTextEditController,
                          passwordTextEditController:
                          _passwordTextEditController,
                          cubit: cubit,
                        ),
                        const SocialMediaSection(
                          text: StringManager.orLoginWith,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoginFormSection extends StatelessWidget {
  const LoginFormSection({
    super.key,
    required this.emailTextEditController,
    required this.passwordTextEditController,
    required this.cubit,
  });

  final TextEditingController emailTextEditController;
  final TextEditingController passwordTextEditController;
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: emailTextEditController,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: StringManager.email,
            hintText: StringManager.email,
          ),
        ),
        const SizedBox(height: AppSize.s20),
        TextFormField(
          controller: passwordTextEditController,
          obscureText: !cubit.isShow,
          decoration: InputDecoration(
            labelText: StringManager.password,
            hintText: StringManager.password,
            suffixIcon: IconButton(
              onPressed: () {
                cubit.changePasswordVisibility();
              },
              icon: cubit.isShow != false
                  ? const Icon(
                      Icons.visibility_outlined,
                    )
                  : const Icon(
                      Icons.visibility_off_outlined,
                    ),
            ),
          ),
        ),
        const SizedBox(height: AppSize.s20),
        decorationButton(
          context,
          function: () {},
          widget: Text(
            StringManager.login,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontSize: FontsSize.s16),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    StringManager.forgetPassword,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SelectableText(
                  StringManager.notMember,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.register,
                    );
                  },
                  child: Text(
                    StringManager.register,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: FontsSize.s14),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSize.s24),
      ],
    );
  }
}
