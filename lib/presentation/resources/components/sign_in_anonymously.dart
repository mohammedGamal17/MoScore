import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../assets/assets.dart';
import '../routes/routes_manager.dart';
import '../string/string_manager.dart';
import '../values/values_manager.dart';
import 'components.dart';

class SignInAnonymously extends StatelessWidget {
  const SignInAnonymously({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                JsonResources.signIn,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: AppSize.s24),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: decorationButton(
                  context,
                  widget: Text(
                    StringManager.login,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  function: () {
                    Navigator.pushReplacementNamed(context, Routes.login);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
