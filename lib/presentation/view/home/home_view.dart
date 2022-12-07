import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/presentation/resources/components/components.dart';
import 'package:quickalert/quickalert.dart';

import '../../view_model/cubit/app_cubit/app_cubit.dart';
import '../../view_model/cubit/app_cubit/app_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(context),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: cubit.usersModel != null
                ? Center(
                    child: Text(cubit.usersModel!.name),
                  )
                : AdaptiveCircleIndicator(),
          );
        },
      ),
    );
  }
}
