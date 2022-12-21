import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/entities.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';
import '../string/string_manager.dart';
import '../values/values_manager.dart';
import 'components.dart';

class LiveMatches extends StatelessWidget {
  LiveMatches({super.key});

  final ScrollController _horizontal = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FixtureCubit>()..getLiveFixture(context),
      child: BlocConsumer<FixtureCubit, FixtureState>(
        listener: (context, state) {},
        builder: (context, state) {
          FixtureCubit fixtureCubit = FixtureCubit.get(context);
          return Padding(
            padding: const EdgeInsets.only(top: AppPadding.p10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringManager.liveMatch,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSize.s20),
                fixtureCubit.liveFixture.isNotEmpty
                    ? SizedBox(
                        height: AppSize.s100,
                        width: double.infinity,
                        child: Scrollbar(
                          controller: _horizontal,
                          child: ListView.builder(
                            itemCount: fixtureCubit.liveFixture.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            controller: _horizontal,
                            itemBuilder: (context, index) {
                              FixtureResponse liveMatch =
                                  fixtureCubit.liveFixture[index];
                              return Text('${liveMatch.teams.home.name}    ');
                            },
                          ),
                        ),
                      )
                    : AdaptiveCircleIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}
