import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/presentation/resources/string/string_manager.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';
import '../colors/color_manager.dart';
import '../fonts/fonts_manager.dart';

class TodayMatchesComponents extends StatelessWidget {
  const TodayMatchesComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FixtureCubit>(),
      child: BlocConsumer<FixtureCubit, FixtureState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                StringManager.todayMatches,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorManager.primary,
                      fontSize: FontsSize.s20,
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}
