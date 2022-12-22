import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/entities.dart';
import '../../resources/components/components.dart';
import '../../resources/components/league_logo.dart';
import '../../resources/components/match_summary.dart';
import '../../resources/values/values_manager.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';

class MatchesDetailsView extends StatelessWidget {
  const MatchesDetailsView({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FixtureCubit>()..getLiveFixture(context),
      child: BlocConsumer<FixtureCubit, FixtureState>(
        listener: (context, state) {},
        builder: (context, state) {
          FixtureCubit fixtureCubit = FixtureCubit.get(context);
          return Scaffold(
            body: state is GetLiveFixtureSuccess
                ? Builder(
                  builder: (context) {
                    FixtureResponse liveMatch = state.liveFixture.elementAt(index);
                    return DraggableHome(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        title: Text(
                          liveMatch.league.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        headerWidget: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: AppPadding.p6,
                              left: AppPadding.p4,
                              right: AppPadding.p4,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // League Logo
                                  LeagueLogo(liveMatch: liveMatch),
                                  // Content class
                                  MatchSummaryComponents(index: index),
                                ],
                              ),
                            ),
                          ),
                        ),
                        body: [],
                        floatingActionButton: FloatingActionButton(
                          elevation: 20.0,
                          onPressed: () => fixtureCubit.reload(context),
                          child: const Icon(Icons.refresh),
                        ),
                      );
                  }
                )
                : AdaptiveCircleIndicator(),
          );
        },
      ),
    );
  }
}
