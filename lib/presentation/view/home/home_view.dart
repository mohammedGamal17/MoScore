import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/app/dependency_injection/dependency_injection.dart';
import 'package:moscore/presentation/resources/components/components.dart';

import '../../common/logout_button.dart';
import '../../view_model/cubit/app_cubit/app_cubit.dart';
import '../../view_model/cubit/app_cubit/app_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppCubit>()..getUserData(context),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: cubit.usersModel != null
                ? Body(appCubit: cubit)
                : AdaptiveCircleIndicator(),
          );
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key, required this.appCubit});

  final AppCubit appCubit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Center(
            child: Text(appCubit.usersModel!.name),
          ),
          const LogOutButton(),
        ],
      ),
    );
  }
}
