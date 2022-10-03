import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moscore/presentation/resources/colors/color_manager.dart';
import 'package:moscore/presentation/resources/fonts/fonts_manager.dart';
import 'package:moscore/presentation/resources/string/string_manager.dart';
import 'package:moscore/presentation/resources/values/values_manager.dart';

import '../../resources/components/components.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailTextEditController = TextEditingController();
  final _passwordTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      StringManager.login,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: FontsSize.s28),
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
                        labelText: StringManager.email,
                        hintText: StringManager.email,
                      ),
                    ),
                    const SizedBox(height: AppSize.s20),
                    TextFormField(
                      controller: _passwordTextEditController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: StringManager.password,
                        hintText: StringManager.password,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: (value) {},
                    ),
                    const SizedBox(height: AppSize.s20),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         begin: AlignmentDirectional.topStart,
                    //         end: AlignmentDirectional.bottomEnd,
                    //         colors: [
                    //           ColorManager.primary,
                    //           ColorManager.selectedItem,
                    //         ],
                    //       ),
                    //     ),
                    //     child: Text(
                    //       StringManager.login,
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .labelLarge?
                    //           .copyWith(fontSize: FontsSize.s16),
                    //     ),
                    //   ),
                    // ),
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
                              onPressed: () {},
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
                        const SizedBox(width: AppSize.s20),
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
                        const SizedBox(width: AppSize.s20),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
