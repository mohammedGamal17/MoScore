import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/entities.dart';
import '../../resources/colors/color_manager.dart';
import '../../resources/components/components.dart';
import '../../resources/components/league_logo.dart';
import '../../resources/fonts/fonts_manager.dart';
import '../../resources/string/string_manager.dart';
import '../../resources/values/values_manager.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';

class MatchesDetailsView extends StatelessWidget {
  const MatchesDetailsView({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<FixtureCubit>()..getFixtureById(context, id: id),
      child: BlocConsumer<FixtureCubit, FixtureState>(
        listener: (context, state) {},
        builder: (context, state) {
          FixtureCubit fixtureCubit = FixtureCubit.get(context);
          return Scaffold(
            body: state is GetFixtureByIdSuccess
                ? Builder(builder: (context) {
                    FixtureResponse liveMatch = state.liveFixture.elementAt(0);
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
                                LeagueLogoMatchDetails(liveMatch: liveMatch),
                                // Content class
                                MatchHeaderSummery(liveMatch: liveMatch),
                              ],
                            ),
                          ),
                        ),
                      ),
                      body: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context, index) {
                            Events event = liveMatch.events[index];
                            return Text('${event.type}: ${event.time.elapsed}\' ${event.player.name}');
                          },
                          itemCount: liveMatch.events.length,
                        ),
                      ],
                      floatingActionButton: FloatingActionButton(
                        elevation: 20.0,
                        onPressed: () =>
                            fixtureCubit.reloadFixture(context, id: id),
                        child: const Icon(Icons.refresh),
                      ),
                    );
                  })
                : AdaptiveCircleIndicator(),
          );
        },
      ),
    );
  }
}

class MatchHeaderSummery extends StatelessWidget {
  const MatchHeaderSummery({super.key, required this.liveMatch});

  final FixtureResponse liveMatch;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          liveMatch.league.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSize.s4),
        Text(
          '${StringManager.stadium}: ${liveMatch.fixture.venue.name}',
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: ColorManager.content),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: AppSize.s4),
        Text(
          liveMatch.league.round,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: ColorManager.content),
        ),
        const SizedBox(height: AppSize.s4),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Home
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: liveMatch.teams.home.logo,
                        fit: BoxFit.cover,
                        height: AppSize.s100,
                      ),
                      const SizedBox(height: AppSize.s4),
                      Text(
                        liveMatch.teams.home.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSize.s4),
                      Text(
                        StringManager.home,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: ColorManager.content),
                      ),
                    ],
                  ),
                ),
                // Time and Score
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            liveMatch.goals.home.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: FontsSize.s24),
                          ),
                          Text(
                            ':',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            liveMatch.goals.away.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: FontsSize.s24),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: AppSize.s26,
                              width: AppSize.s40,
                              color: ColorManager.selectedItem,
                            ),
                            Container(
                              height: AppSize.s24,
                              width: AppSize.s38,
                              decoration: BoxDecoration(
                                color: ColorManager.darkPrimary,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${liveMatch.fixture.status.elapsed.toString()}\'',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Away
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: liveMatch.teams.away.logo,
                        fit: BoxFit.cover,
                        height: AppSize.s100,
                      ),
                      const SizedBox(height: AppSize.s4),
                      Text(
                        liveMatch.teams.away.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSize.s4),
                      Text(
                        StringManager.away,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: ColorManager.content),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
