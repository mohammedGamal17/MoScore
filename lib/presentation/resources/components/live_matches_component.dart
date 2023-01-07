import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/entities.dart';
import '../../view/matches/matches_details_view.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';
import '../colors/color_manager.dart';
import '../fonts/fonts_manager.dart';
import '../string/string_manager.dart';
import '../values/values_manager.dart';
import 'league_logo.dart';
import 'match_summary_component.dart';
import 'no_live_matches_component.dart';

class LiveMatches extends StatelessWidget {
  LiveMatches({super.key});

  final ScrollController _horizontal = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FixtureCubit, FixtureState>(
      listener: (context, state) {},
      builder: (context, state) {
        FixtureCubit fixtureCubit = FixtureCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringManager.liveMatch,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: ColorManager.primary, fontSize: FontsSize.s20),
            ),
            const SizedBox(height: AppSize.s20),
            fixtureCubit.liveFixture.isNotEmpty
                ? SizedBox(
                    height: AppSize.s250,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: fixtureCubit.liveFixture.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: _horizontal,
                      itemBuilder: (context, index) {
                        FixtureLiveResponse liveMatch =
                            fixtureCubit.liveFixture[index];
                        return MatchBody(
                          liveMatch: liveMatch,
                          index: index,
                        );
                      },
                    ),
                  )
                : const NoLiveMatches()
          ],
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
