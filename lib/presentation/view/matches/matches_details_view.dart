import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/entities.dart';
import '../../resources/colors/color_manager.dart';
import '../../resources/components/components.dart';
import '../../resources/components/no_live_matches_component.dart';
import '../../resources/fonts/fonts_manager.dart';
import '../../resources/string/string_manager.dart';
import '../../resources/values/values_manager.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';
import '../player/player_view.dart';
import '../team/team_over_view.dart';

class MatchesDetailsView extends StatelessWidget {
  const MatchesDetailsView({super.key, required this.id});

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
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              body: state is GetFixtureByIdSuccess
                  ? Body(state: state, fixtureCubit: fixtureCubit)
                  : AdaptiveCircleIndicator(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  fixtureCubit.reloadFixture(context, id: id);
                },
                child: const Icon(Icons.refresh),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.state,
    required this.fixtureCubit,
  });

  final GetFixtureByIdSuccess state;
  final FixtureCubit fixtureCubit;

  @override
  Widget build(BuildContext context) {
    FixtureResponse liveMatch = state.liveFixture.elementAt(0);
    return NestedScrollView(
      headerSliverBuilder: (
        BuildContext context,
        bool innerBoxIsScrolled,
      ) {
        return [
          SliverAppBar(
            pinned: false,
            floating: true,
            snap: false,
            scrolledUnderElevation: AppSize.s20,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        liveMatch.league.name,
                        style: Theme.of(context).textTheme.headlineMedium,
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
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TeamOverView(
                                          id: liveMatch.teams.home.id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
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
                                            .copyWith(
                                                color: ColorManager.content),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Time and Score
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          liveMatch.goals.home.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .copyWith(
                                                  fontSize: FontsSize.s24),
                                        ),
                                        Text(
                                          ':',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge,
                                        ),
                                        Text(
                                          liveMatch.goals.away.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .copyWith(
                                                  fontSize: FontsSize.s24),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSize.s4),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s10),
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
                                                  BorderRadius.circular(
                                                      AppSize.s10),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${liveMatch.fixture.status.elapsed.toString()}\'',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
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
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TeamOverView(
                                          id: liveMatch.teams.away.id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
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
                                            .copyWith(
                                                color: ColorManager.content),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              labelColor: ColorManager.primary,
              unselectedLabelColor: ColorManager.content,
              isScrollable: true,
              indicator: BoxDecoration(
                color: ColorManager.backGround,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppSize.s20),
                ),
              ),
              tabs: const [
                Tab(child: Text(StringManager.summary)),
                Tab(child: Text(StringManager.lineUp)),
                Tab(child: Text(StringManager.statistics)),
              ],
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(AppSize.s50),
                bottomLeft: Radius.circular(AppSize.s50),
              ),
            ),
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.only(
          right: AppPadding.p20,
          left: AppPadding.p20,
          bottom: AppPadding.p70,
        ),
        child: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            MatchSummary(liveMatch: liveMatch, fixtureCubit: fixtureCubit),
            MatchLineUp(liveMatch: liveMatch, fixtureCubit: fixtureCubit),
            MatchStatistics(liveMatch: liveMatch, fixtureCubit: fixtureCubit),
          ],
        ),
      ),
    );
  }
}

class MatchHeader extends StatelessWidget {
  const MatchHeader({super.key, required this.liveMatch});

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

class MatchSummary extends StatelessWidget {
  const MatchSummary({
    super.key,
    required this.liveMatch,
    required this.fixtureCubit,
  });

  final FixtureResponse liveMatch;
  final FixtureCubit fixtureCubit;

  @override
  Widget build(BuildContext context) {
    return fixtureCubit.event.isNotEmpty && fixtureCubit.homeEvents.isNotEmpty
        ? ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Events events = liveMatch.events[index];
              return fixtureCubit.homeEvents[0].team.id ==
                      events.team.id // Check Home Or Away
                  ? Padding(
                      padding: const EdgeInsets.all(6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(events.detail),
                          const SizedBox(width: AppSize.s4),
                          Text('${events.time.elapsed.toString()}\''),
                          const SizedBox(width: AppSize.s6),
                          separatorHorizontal(width: AppSize.s2),
                          const SizedBox(width: AppSize.s6),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PlayerView(
                                          id: events.player.id!,
                                          season: liveMatch.league.season,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(events.player.name),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PlayerView(
                                          id: events.player.id!,
                                          season: liveMatch.league.season,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  events.assist.name ?? '',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: FontsSize.s14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PlayerView(
                                          id: events.player.id!,
                                          season: liveMatch.league.season,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(events.player.name),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PlayerView(
                                          id: events.player.id!,
                                          season: liveMatch.league.season,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  events.assist.name ?? '',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: FontsSize.s14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: AppSize.s6),
                          separatorHorizontal(width: AppSize.s2),
                          const SizedBox(width: AppSize.s6),
                          Text('${events.time.elapsed.toString()}\''),
                          const SizedBox(width: AppSize.s4),
                          Text(events.detail),
                        ],
                      ),
                    );
            },
            itemCount: liveMatch.events.length,
            separatorBuilder: (BuildContext context, int index) {
              return separator(
                verticalPadding: AppPadding.p6,
                horizontalPadding: AppPadding.p60,
              );
            },
          )
        : const NoAvailableData();
  }
}

class MatchLineUp extends StatelessWidget {
  const MatchLineUp({
    super.key,
    required this.fixtureCubit,
    required this.liveMatch,
  });

  final FixtureCubit fixtureCubit;
  final FixtureResponse liveMatch;

  @override
  Widget build(BuildContext context) {
    return fixtureCubit.lineups.isNotEmpty
        ? Builder(builder: (context) {
            Lineups homeTeam = fixtureCubit.lineups[0];
            Lineups awayTeam = fixtureCubit.lineups[1];
            return Padding(
              padding: const EdgeInsets.only(top: AppPadding.p6),
              child: Row(
                children: [
                  // HOME LINES-UP
                  Expanded(
                    child: Column(
                      children: [
                        TeamLinesUpHeader(team: homeTeam),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              StartXI lineup = homeTeam.startXI[index];
                              return PlayerBuilder(
                                teamLogo: homeTeam.team.logo,
                                player: lineup.player,
                                season: liveMatch.league.season,
                              );
                            },
                            itemCount: fixtureCubit.lineups[0].startXI.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: AppSize.s6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  separatorHorizontal(height: double.infinity),
                  // AWAY LINES-UP
                  Expanded(
                    child: Column(
                      children: [
                        TeamLinesUpHeader(team: awayTeam),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              StartXI lineup = awayTeam.startXI[index];
                              return PlayerBuilder(
                                teamLogo: awayTeam.team.logo,
                                player: lineup.player,
                                season: liveMatch.league.season,
                              );
                            },
                            itemCount: fixtureCubit.lineups[0].startXI.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: AppSize.s6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          })
        : const NoAvailableData();
  }
}

class MatchStatistics extends StatelessWidget {
  const MatchStatistics({
    super.key,
    required this.liveMatch,
    required this.fixtureCubit,
  });

  final FixtureResponse liveMatch;
  final FixtureCubit fixtureCubit;

  @override
  Widget build(BuildContext context) {
    return liveMatch.statistics.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              Statisticss statistics = fixtureCubit.homeStatistics[index];
              Statisticss statisticss = fixtureCubit.awayStatistics[index];

              double maxValue =
                  statistics.value.toDouble() + statisticss.value.toDouble();
              return Column(
                children: [
                  Text(statistics.type),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(statistics.value.toString()),
                      Text(statisticss.value.toString()),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: AppSize.s30,
                      thumbColor: Colors.transparent,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 0.0,
                      ),
                    ),
                    child: Slider(
                      value: statistics.value.toDouble(),
                      onChanged: (double value) {},
                      min: 0,
                      max: maxValue,
                      activeColor: ColorManager.selectedItem,
                      inactiveColor: ColorManager.primary,
                      thumbColor: Colors.transparent,
                    ),
                  ),
                  separator(),
                ],
              );
            },
            itemCount: 9,
          )
        : const NoAvailableData();
  }
}

class TeamLinesUpHeader extends StatelessWidget {
  const TeamLinesUpHeader({super.key, required this.team});

  final Lineups team;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s80,
      width: double.infinity,
      color: ColorManager.content.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${StringManager.coach}: ${team.coach.name}',
              style: TextStyle(
                fontSize: 14.0,
                color: ColorManager.lightPrimary,
              ),
              maxLines: 2,
            ),
            const Spacer(),
            Text('${StringManager.formation}: ${team.formation}'),
          ],
        ),
      ),
    );
  }
}

class TeamLinesUpBody extends StatelessWidget {
  const TeamLinesUpBody({super.key, required this.team});

  final Lineups team;

  @override
  Widget build(BuildContext context) {
    return team.formation.length == 5
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return Text(index.toString());
                },
                itemCount: 4,
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('${StringManager.team}: ${team.team.name}'),
                  const Spacer(),
                  Text(team.formation),
                ],
              ),
              Text(
                '${StringManager.coach}: ${team.coach.name}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: ColorManager.lightPrimary,
                ),
              ),
            ],
          );
  }
}

class PlayerBuilder extends StatelessWidget {
  const PlayerBuilder({
    super.key,
    required this.teamLogo,
    required this.player,
    required this.season,
  });

  final String teamLogo;
  final Player player;
  final int season;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CachedNetworkImage(
          imageUrl: teamLogo,
          width: AppSize.s30,
          height: AppSize.s30,
          placeholder: (context, url) {
            return Shimmer(
              gradient: RadialGradient(
                colors: [
                  ColorManager.darkPrimary,
                  ColorManager.primary,
                  ColorManager.lightPrimary
                ],
              ),
              child: const CircleAvatar(
                radius: AppSize.s30,
              ),
            );
          },
        ),
        const SizedBox(width: AppSize.s6),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return PlayerView(
                    id: player.id!,
                    season: season,
                  );
                }),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    Text(
                      player.number.toString() ?? '',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: FontsSize.s14,
                          ),
                    ),
                    const SizedBox(width: AppSize.s6),
                    if (player.pos == 'G') ...[
                      Expanded(
                        child: Text(
                          StringManager.goalKeeper,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ] else if (player.pos == 'D') ...[
                      Expanded(
                        child: Text(
                          StringManager.defender,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ] else if (player.pos == 'M') ...[
                      Expanded(
                        child: Text(
                          StringManager.middle,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ] else if (player.pos == 'F') ...[
                      Expanded(
                        child: Text(
                          StringManager.forward,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: Text(
                          StringManager.unKnown,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
