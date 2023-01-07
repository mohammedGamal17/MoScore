import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/entities.dart';
import '../../view/matches/matches_details_view.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';
import '../colors/color_manager.dart';
import '../fonts/fonts_manager.dart';
import '../string/string_manager.dart';
import '../values/values_manager.dart';
import 'components.dart';

class TodayMatches extends StatelessWidget {
  const TodayMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FixtureCubit, FixtureState>(
      listener: (context, state) {},
      builder: (context, state) {
        FixtureCubit fixtureCubit = FixtureCubit.get(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  StringManager.todayMatches,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: ColorManager.primary,
                        fontSize: FontsSize.s20,
                      ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    // TODO NAVIGATE TO PAGE OF TODAY MATCHES
                  },
                  child: Text(
                    StringManager.seeAll,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: FontsSize.s16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s14),
            state is GetTodayMatchesSuccess
                ? ListView.builder(
                    shrinkWrap: true,
                    controller: ScrollController(),
                    itemBuilder: (context, index) {
                      FixtureTodayResponse matches =
                          fixtureCubit.fixtureToday[index];
                      return MatchBuilder(
                        fixtureCubit: fixtureCubit,
                        matches: matches,
                      );
                    },
                    itemCount: fixtureCubit.fixtureToday.length,
                  )
                : AdaptiveCircleIndicator(),
          ],
        );
      },
    );
  }
}

class MatchBuilder extends StatelessWidget {
  const MatchBuilder({
    super.key,
    required this.fixtureCubit,
    required this.matches,
  });

  final FixtureCubit fixtureCubit;
  final FixtureTodayResponse matches;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MatchesDetailsView(id: matches.fixture.id),
        ),
      ),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppSize.s12),
          ),
        ),
        color: ColorManager.primary,
        elevation: AppSize.s6,
        shadowColor: ColorManager.lightPrimary,
        child: SizedBox(
          width: double.infinity,
          height: AppSize.s100,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TeamHome(matches: matches),
                const SizedBox(width: AppSize.s6),
                MatchTimeOrScore(
                  fixtureCubit: fixtureCubit,
                  matches: matches,
                ),
                const SizedBox(width: AppSize.s6),
                TeamAway(matches: matches),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TeamHome extends StatelessWidget {
  const TeamHome({super.key, required this.matches});

  final FixtureTodayResponse matches;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Text(
              matches.teams.home.name,
              style: TextStyle(
                color: ColorManager.white,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: AppSize.s10),
          CachedNetworkImage(
            imageUrl: matches.teams.home.logo,
            height: AppSize.s60,
            width: AppSize.s60,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Shimmer(
                gradient: LinearGradient(
                  colors: [
                    ColorManager.darkPrimary,
                    ColorManager.primary,
                    ColorManager.lightPrimary,
                  ],
                ),
                child: const SizedBox(
                  height: AppSize.s60,
                  width: AppSize.s60,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TeamAway extends StatelessWidget {
  const TeamAway({super.key, required this.matches});

  final FixtureTodayResponse matches;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: matches.teams.away.logo,
            height: AppSize.s60,
            width: AppSize.s60,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer(
              gradient: LinearGradient(
                colors: [
                  ColorManager.headLine,
                  ColorManager.listTitle,
                  ColorManager.backGround,
                ],
              ),
              child: Container(),
            ),
          ),
          const SizedBox(width: AppSize.s10),
          Expanded(
            child: Text(
              matches.teams.away.name,
              style: TextStyle(color: ColorManager.white),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class MatchTimeOrScore extends StatelessWidget {
  const MatchTimeOrScore({
    super.key,
    required this.fixtureCubit,
    required this.matches,
  });

  final FixtureCubit fixtureCubit;
  final FixtureTodayResponse matches;

  @override
  Widget build(BuildContext context) {
    int now = DateTime.now().millisecondsSinceEpoch;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // check time if less than now so match didn't start else but result of match
        matches.fixture.timestamp * 1000 > now
            ? Text(
                fixtureCubit.convertTimeStamp(
                  timeStamp: matches.fixture.timestamp,
                ),
                style: TextStyle(
                  color: ColorManager.white,
                ),
              )
            : Text(
                '${matches.goals.home} : ${matches.goals.away}',
                style: TextStyle(
                  color: ColorManager.white,
                ),
              ),
        Text(
          fixtureCubit.convertData(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
