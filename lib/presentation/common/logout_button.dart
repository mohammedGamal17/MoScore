import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/components/components.dart';
import '../resources/string/string_manager.dart';
import '../view_model/cubit/auth_cubit/auth_cubit.dart';
import '../view_model/cubit/auth_cubit/auth_state.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return state is SignOutLoading
            ? AdaptiveCircleIndicator()
            : MaterialButton(
                onPressed: () {
                  cubit.signOut(context);
                },
                child: const Text(StringManager.logOut),
              );
      },
    );
  }
}
