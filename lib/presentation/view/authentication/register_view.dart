import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/header_section_of_auth_views.dart';
import '../../common/social_media_buttons_components.dart';
import '../../resources/components/components.dart';
import '../../resources/fonts/fonts_manager.dart';
import '../../resources/string/string_manager.dart';
import '../../resources/values/values_manager.dart';
import '../../view_model/cubit/auth_cubit/auth_cubit.dart';
import '../../view_model/cubit/auth_cubit/auth_state.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameTextEditController = TextEditingController();
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
                        const HeaderSection(headLine: StringManager.register),
                        RegisterFormSection(
                          nameTextEditController: _nameTextEditController,
                          emailTextEditController: _emailTextEditController,
                          passwordTextEditController:
                          _passwordTextEditController,
                          cubit: cubit,
                        ),
                        const SocialMediaSection(
                            text: StringManager.orRegisterWith),
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

class RegisterFormSection extends StatelessWidget {
  const RegisterFormSection({
    super.key,
    required this.nameTextEditController,
    required this.emailTextEditController,
    required this.passwordTextEditController,
    required this.cubit,
  });

  final TextEditingController nameTextEditController;
  final TextEditingController emailTextEditController;
  final TextEditingController passwordTextEditController;
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameTextEditController,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: StringManager.name,
            hintText: StringManager.name,
          ),
        ),
        const SizedBox(height: AppSize.s20),
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
            StringManager.register,
            style: Theme
                .of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontSize: FontsSize.s16),
          ),
        ),
        const SizedBox(height: AppSize.s24),
      ],
    );
  }
}
