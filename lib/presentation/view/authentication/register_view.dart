import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../resources/colors/color_manager.dart';
import '../../resources/components/components.dart';
import '../../resources/fonts/fonts_manager.dart';
import '../../resources/string/string_manager.dart';
import '../../resources/values/values_manager.dart';
import '../../view_model/cubit/auth_cubit/auth_cubit.dart';
import '../../view_model/cubit/auth_cubit/auth_state.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

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
                        Text(
                          StringManager.register,
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
                        TextFormField(
                          controller: _emailTextEditController,
                          autofocus: true,
                          decoration: const InputDecoration(
                            labelText: StringManager.name,
                            hintText: StringManager.name,
                          ),
                        ),
                        const SizedBox(height: AppSize.s20),
                        TextFormField(
                          controller: _emailTextEditController,
                          autofocus: true,
                          decoration: const InputDecoration(
                            labelText: StringManager.email,
                            hintText: StringManager.email,
                          ),
                        ),
                        const SizedBox(height: AppSize.s20),
                        TextFormField(
                          controller: _passwordTextEditController,
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
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontSize: FontsSize.s16),
                          ),
                        ),
                        const SizedBox(height: AppSize.s24),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              StringManager.orRegisterWith,
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
                                    onPressed: () {},
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
                                    onPressed: () {},
                                    icon: FaIcon(
                                      FontAwesomeIcons.facebook,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
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
