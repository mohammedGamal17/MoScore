import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/presentation/resources/components/league_logo.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/entities.dart';
import '../../view/matches/matches_details_view.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';
import '../colors/color_manager.dart';
import '../fonts/fonts_manager.dart';
import '../string/string_manager.dart';
import '../values/values_manager.dart';
import 'components.dart';
import 'match_summary_component.dart';
import 'no_live_matches_component.dart';

class LiveMatches extends StatelessWidget {
  const LiveMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FixtureCubit>()..getLiveFixture(context),
      child: BlocConsumer<FixtureCubit, FixtureState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: AppPadding.p10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state is GetLiveFixtureSuccess
                    ? LiveMatch()
                    : SizedBox(
                        height: 260.0,
                        child: AdaptiveCircleIndicator(),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LiveMatch extends StatelessWidget {
  LiveMatch({super.key});

  final ScrollController _horizontal = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FixtureCubit, FixtureState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is GetLiveFixtureSuccess
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringManager.liveMatch,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: ColorManager.primary,
                      fontSize: FontsSize.s20
                        ),
                  ),
                  const SizedBox(height: AppSize.s20),
                  state.liveFixture.isNotEmpty
                      ? SizedBox(
                          height: AppSize.s250,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: state.liveFixture.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            controller: _horizontal,
                            itemBuilder: (context, index) {
                              FixtureLiveResponse liveMatch =
                                  state.liveFixture[index];
                              return MatchBody(
                                  liveMatch: liveMatch, index: index);
                            },
                          ),
                        )
                      : const NoLiveMatches()
                ],
              )
            : SizedBox(
                height: 260.0,
                child: AdaptiveCircleIndicator(),
              );
      },
    );
  }
}

class MatchBody extends StatelessWidget {
  const MatchBody({super.key, required this.liveMatch, required this.index});

  final FixtureLiveResponse liveMatch;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MatchesDetailsView(id: liveMatch.fixture.id),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s10),
          child: Container(
            width: AppSize.s320,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorManager.darkPrimary,
                  ColorManager.primary,
                  ColorManager.lightPrimary,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // League Logo
                  LeagueLogoHome(liveMatch: liveMatch),
                  // Content class
                  MatchSummaryComponents(index: index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
