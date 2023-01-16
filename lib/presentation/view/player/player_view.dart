import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moscore/app/ads/ads_helper.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/player_entities.dart';
import '../../resources/colors/color_manager.dart';
import '../../resources/components/components.dart';
import '../../resources/components/no_live_matches_component.dart';
import '../../resources/fonts/fonts_manager.dart';
import '../../resources/string/string_manager.dart';
import '../../resources/values/values_manager.dart';
import '../../view_model/cubit/player_cubit/player_cubit.dart';
import '../../view_model/cubit/player_cubit/player_state.dart';
import '../team/team_over_view.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key, required this.id, required this.season});

  final int id;
  final int season;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<PlayerCubit>()..getPlayer(context, id: id, season: season),
      child: BlocConsumer<PlayerCubit, PlayerState>(
        listener: (context, state) {},
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              body: state is GetPlayerInfoSuccess
                  ? state.playerInfo.isNotEmpty
                      ? Builder(
                          builder: (index) {
                            PlayerInfo player = state.playerInfo[0];
                            return NestedScrollView(
                              headerSliverBuilder: (
                                BuildContext context,
                                bool innerBoxIsScrolled,
                              ) {
                                return [
                                  CustomAppBar(player: player),
                                ];
                              },
                              body: SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p20,
                                    vertical: AppPadding.p10,
                                  ),
                                  child: TabBarView(
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      PlayerDetails(player: player),
                                      PlayerStatistics(player: player),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Column(
                          children: [
                            AppBar(),
                            const Center(child: NoAvailableData()),
                          ],
                        )
                  : AdaptiveCircleIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.player});

  final PlayerInfo player;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      snap: false,
      scrolledUnderElevation: AppSize.s20,
      expandedHeight: AppSize.s250,
      centerTitle: true,
      title: Text(player.player.name!),
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                CircleAvatar(
                  radius: AppSize.s60,
                  backgroundColor: Colors.transparent,
                  child: CachedNetworkImage(
                    imageUrl: player.player.photo!,
                    placeholder: (context, url) {
                      return Shimmer(
                        gradient: LinearGradient(
                          colors: [
                            ColorManager.darkPrimary,
                            ColorManager.primary,
                            ColorManager.lightPrimary,
                            ColorManager.backGround,
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: AppSize.s60,
                        ),
                      );
                    },
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
          Tab(child: Text(StringManager.details)),
          Tab(child: Text(StringManager.statistics)),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(AppSize.s40),
          bottomLeft: Radius.circular(AppSize.s40),
        ),
      ),
    );
  }
}

class PlayerDetails extends StatelessWidget {
  const PlayerDetails({super.key, required this.player});

  final PlayerInfo player;

  @override
  Widget build(BuildContext context) {
    DateTime date = player.player.birth!.date!;
    String dateOfBirth = DateFormat('yyyy-MM-dd').format(date);
    return Column(
      children: [
        Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: AppSize.s10,
            ),
            children: [
              PlayerInfoBuilder(
                stringKey: StringManager.fullName,
                value: '${player.player.firstname} ${player.player.lastname}',
              ),
              PlayerInfoBuilder(
                stringKey: StringManager.dateOfBirth,
                value: '$dateOfBirth\n${player.player.age} ${StringManager.years}',
              ),
              PlayerInfoBuilder(
                stringKey: StringManager.placeOfBirth,
                value:
                    '${player.player.birth!.place}, ${player.player.birth!.country}',
              ),
              PlayerInfoBuilder(
                stringKey: StringManager.nationality,
                value: player.player.nationality!,
              ),
              PlayerInfoBuilder(
                stringKey: StringManager.height,
                value: player.player.height!,
              ),
              PlayerInfoBuilder(
                stringKey: StringManager.weight,
                value: player.player.weight!,
              ),
              PlayerInfoBuilder(
                stringKey: StringManager.position,
                value: player.statistics![0]!.games!.position!,
              ),
            ],
          ),
        ),
        const BannerAdComponent(),
      ],
    );
  }
}

class PlayerStatistics extends StatelessWidget {
  const PlayerStatistics({
    super.key,
    required this.player,
  });

  final PlayerInfo player;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Column(
          children: [
            Text(player.player.name!),
            Text(
              '${StringManager.season}: ${player.statistics![0]!.league!.season!.toString()}',
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  Statistic? statistics = player.statistics![index];
                  return Expandable(
                    collapsed: ExpandableButton(
                      child: Column(
                        children: [
                          PlayerStatisticsLeague(statistics: statistics!),
                          Row(
                            children: [
                              const Spacer(),
                              ExpandableButton(
                                child: const Icon(Icons.arrow_drop_down),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    expanded: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlayerStatisticsLeague(statistics: statistics),
                        separator(
                          horizontalPadding: AppPadding.p80,
                          verticalPadding: AppPadding.p2,
                        ),
                        PlayerStatisticsTeam(statistics: statistics),
                        PlayerStatisticsInfo(statistics: statistics),
                        Row(
                          children: [
                            const Spacer(),
                            ExpandableButton(
                              child: const Icon(Icons.arrow_drop_up, size: 30),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => separator(),
                physics: const BouncingScrollPhysics(),
                itemCount: player.statistics!.length,
              ),
            ),
            const BannerAdComponent(),
          ],
        ),
      ),
    );
  }
}

class PlayerInfoBuilder extends StatelessWidget {
  const PlayerInfoBuilder({
    super.key,
    required this.stringKey,
    required this.value,
  });

  final String stringKey;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.primary,
      elevation: AppSize.s10,
      shadowColor: ColorManager.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            stringKey,
            style: TextStyle(
              fontSize: FontsSize.s14,
              color: ColorManager.lightBackGround,
            ),
          ),
          const SizedBox(height: AppSize.s4),
          SizedBox(
            height: AppSize.s1,
            width: double.infinity,
            child: Container(color: ColorManager.backGround),
          ),
          const SizedBox(height: AppSize.s6),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: FontsSize.s18,
                  color: ColorManager.backGround,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerStatisticsLeague extends StatelessWidget {
  const PlayerStatisticsLeague({super.key, required this.statistics});

  final Statistic statistics;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: AppSize.s30,
          backgroundColor: Colors.transparent,
          child: CachedNetworkImage(
            imageUrl: statistics.league!.logo!,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Shimmer(
                gradient: LinearGradient(
                  colors: [
                    ColorManager.darkPrimary,
                    ColorManager.primary,
                    ColorManager.primary,
                    ColorManager.backGround
                  ],
                ),
                child: const CircleAvatar(radius: AppSize.s30),
              );
            },
          ),
        ),
        const SizedBox(width: AppSize.s6),
        Expanded(
          child: Text(
            statistics.league!.name!,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          statistics.league!.country!,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }
}

class PlayerStatisticsTeam extends StatelessWidget {
  const PlayerStatisticsTeam({super.key, required this.statistics});

  final Statistic statistics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TeamOverView(id: statistics.team!.id!);
                  },
                ),
              );
            },
            child: CircleAvatar(
              radius: AppSize.s18,
              backgroundColor: Colors.transparent,
              child: CachedNetworkImage(
                imageUrl: statistics.team!.logo!,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Shimmer(
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.darkPrimary,
                        ColorManager.primary,
                        ColorManager.primary,
                        ColorManager.backGround
                      ],
                    ),
                    child: const CircleAvatar(radius: AppSize.s18),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: AppSize.s6),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TeamOverView(id: statistics.team!.id!);
                  },
                ),
              );
            },
            child: Text(
              statistics.team!.name!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: FontsSize.s14,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerStatisticsInfo extends StatelessWidget {
  const PlayerStatisticsInfo({super.key, required this.statistics});

  final Statistic statistics;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Goals
        const SizedBox(height: AppSize.s10),
        Text(
          StringManager.goal,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: ColorManager.darkPrimary, fontWeight: FontsWight.bold),
        ),
        const SizedBox(height: AppSize.s6),
        PlayerStatisticsBuilder(
          stringKey: StringManager.totalGoals,
          value: statistics.goals!.total!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.concededGoals,
          value: statistics.goals!.conceded!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.assists,
          value: statistics.goals!.assists!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.saves,
          value: statistics.goals!.saves!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.penaltyScored,
          value: statistics.penalty!.scored!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.penaltyMissed,
          value: statistics.penalty!.missed!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.penaltyWon,
          value: statistics.penalty!.won!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.penaltySaved,
          value: statistics.penalty!.saved!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.penaltyCommitted,
          value: statistics.penalty!.committed!.toString(),
        ),

        // Passes
        const SizedBox(height: AppSize.s10),
        Text(
          StringManager.passes,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: ColorManager.darkPrimary,
                fontWeight: FontsWight.bold,
              ),
        ),
        const SizedBox(height: AppSize.s6),
        PlayerStatisticsBuilder(
          stringKey: StringManager.totalPasses,
          value: statistics.passes!.total!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.keyPasses,
          value: statistics.passes!.key!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.accuracyPasses,
          value: statistics.passes!.accuracy!.toString(),
        ),

        // Defender
        const SizedBox(height: AppSize.s10),
        Text(
          StringManager.defender,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: ColorManager.darkPrimary,
                fontWeight: FontsWight.bold,
              ),
        ),
        const SizedBox(height: AppSize.s6),
        PlayerStatisticsBuilder(
          stringKey: StringManager.totalTackles,
          value: statistics.tackles!.total!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.blocksTackles,
          value: statistics.tackles!.blocks!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.interceptionsTackles,
          value: statistics.tackles!.interceptions!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.committedFouls,
          value: statistics.fouls!.committed!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.drawnFouls,
          value: statistics.fouls!.drawn!.toString(),
        ),

        // Cards
        const SizedBox(height: AppSize.s10),
        Text(
          StringManager.cards,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: ColorManager.darkPrimary,
                fontWeight: FontsWight.bold,
              ),
        ),
        const SizedBox(height: AppSize.s6),
        PlayerStatisticsBuilder(
          stringKey: StringManager.yellowCards,
          value: statistics.cards!.yellow!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.yellowRedCards,
          value: statistics.cards!.yellowRed!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.redCards,
          value: statistics.cards!.red!.toString(),
        ),

        // Other
        const SizedBox(height: AppSize.s10),
        Text(
          StringManager.other,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: ColorManager.darkPrimary,
                fontWeight: FontsWight.bold,
              ),
        ),
        const SizedBox(height: AppSize.s6),
        PlayerStatisticsBuilder(
          stringKey: StringManager.totalShots,
          value: statistics.shots!.total.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.totalOn,
          value: statistics.shots!.on!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.successDribbles,
          value: statistics.dribbles!.success!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.attemptsDribbles,
          value: statistics.dribbles!.attempts!.toString(),
        ),
        PlayerStatisticsBuilder(
          stringKey: StringManager.attemptsPast,
          value: statistics.dribbles!.past!.toString(),
        ),
      ],
    );
  }
}

class PlayerStatisticsBuilder extends StatelessWidget {
  const PlayerStatisticsBuilder({
    super.key,
    required this.stringKey,
    required this.value,
  });

  final String stringKey;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            stringKey,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          value,
          style: TextStyle(color: ColorManager.lightPrimary),
        ),
      ],
    );
  }
}
