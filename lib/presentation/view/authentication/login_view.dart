import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/presentation/resources/fonts/fonts_manager.dart';
import 'package:moscore/presentation/resources/string/string_manager.dart';
import 'package:moscore/presentation/resources/values/values_manager.dart';
import 'package:moscore/presentation/view_model/cubit/auth_cubit/auth_cubit.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../app/shared_preferences/shared_preferences.dart';
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
  final AppPreferences _appPreferences = getIt<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserLoginSuccess || state is SignInWithGoogleSuccess) {
          Navigator.pushReplacementNamed(context, Routes.home);
          _appPreferences.setIsSignIn();
        }
      },
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
                          formKey: _formKey,
                          state: state,
                        ),
                        SocialMediaSection(
                          text: StringManager.orLoginWith,
                          cubit: cubit,
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
    required this.formKey,
    required this.state,
  });

  final TextEditingController emailTextEditController;
  final TextEditingController passwordTextEditController;
  final AuthCubit cubit;
  final GlobalKey<FormState> formKey;
  final AuthState state;

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
          validator: (value) {
            /// regular expression to check if string
            RegExp emailValid = RegExp(
              r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
            );

            /// A function that validate user entered email
            bool validateUsername(String user) {
              String email = user.trim();
              if (emailValid.hasMatch(email)) {
                return true;
              } else {
                return false;
              }
            }

            if (value!.isEmpty || value.length < 4) {
              return StringManager.pleaseEnterYourEmail;
            } else {
              bool result = validateUsername(value);
              if (result) {
                return null;
              } else {
                return StringManager.pleaseWriteValidEmail;
              }
            }
          },
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
          validator: (value) {
            // regular expression to check if string
            RegExp passValid = RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
            //A function that validate user entered password
            bool validatePassword(String pass) {
              String password = pass.trim();
              if (passValid.hasMatch(password)) {
                return true;
              } else {
                return false;
              }
            }

            if (value!.isEmpty) {
              return StringManager.pleaseEnterYourPassword;
            } else {
              bool result = validatePassword(value);
              if (result) {
                return null;
              } else {
                return StringManager.passwordValidate;
              }
            }
          },
        ),
        const SizedBox(height: AppSize.s20),
        state is UserLoginLoading
            ? AdaptiveCircleIndicator()
            : decorationButton(
                context,
                function: () {
                  if (formKey.currentState!.validate()) {
                    cubit.signInWithEmailAndPassword(
                        context: context,
                        emailAddress: emailTextEditController.text,
                        password: passwordTextEditController.text);
                  }
                },
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
