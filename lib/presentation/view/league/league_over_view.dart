import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/entities.dart';
import '../../resources/colors/color_manager.dart';
import '../../resources/components/components.dart';
import '../../resources/values/values_manager.dart';
import '../../view_model/cubit/leagues_cubit/leagues_cubit.dart';
import '../../view_model/cubit/leagues_cubit/leagues_state.dart';

class LeagueOverView extends StatelessWidget {
  const LeagueOverView({
    super.key,
    required this.leagueResponse,
    required this.season,
  });

  final LeagueResponse leagueResponse;
  final int season;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LeaguesCubit>()
        ..getStandingLeague(
          context,
          leagueId: leagueResponse.league.id,
          year: season,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(leagueResponse.league.name),
          centerTitle: true,
        ),
        body: Body(leagueResponse: leagueResponse),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key, required this.leagueResponse});

  final LeagueResponse leagueResponse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p10,
      ),
      child: Column(
        children: [
          Head(leagueResponse: leagueResponse),
          const SizedBox(height: AppSize.s10),
          Row(
            children: const [
              Text('#'),
              SizedBox(width: AppSize.s14),
              Text('Team'),
              Spacer(),
              Text('Pts'),
              SizedBox(width: AppSize.s10),
              Text('P'),
              SizedBox(width: AppSize.s10),
              Text('W'),
              SizedBox(width: AppSize.s10),
              Text('D'),
              SizedBox(width: AppSize.s10),
              Text('L'),
            ],
          ),
          const SizedBox(height: AppSize.s10),
          const StandingTable(),
        ],
      ),
    );
  }
}

class Head extends StatelessWidget {
  const Head({super.key, required this.leagueResponse});

  final LeagueResponse leagueResponse;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaguesCubit, LeaguesState>(
      listener: (context, state) {},
      builder: (context, state) {
        LeaguesCubit leaguesCubit = LeaguesCubit.get(context);
        return Card(
          shadowColor: ColorManager.selectedItem,
          elevation: AppSize.s10,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p10,
              vertical: AppPadding.p4,
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: leagueResponse.league.logo,
                  fit: BoxFit.fill,
                  height: AppSize.s100,
                  width: AppSize.s100,
                ),
                const SizedBox(width: AppSize.s14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(leagueResponse.league.name),
                      const SizedBox(height: AppSize.s6),
                      Text(
                        leagueResponse.country.name,
                        style: Theme.of(context).textTheme.displayMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // leagueResponse.seasons.isEmpty
                //     ? const SizedBox()
                //     : DropdownButton<int>(
                //         items: leagueResponse.seasons.map(
                //           (season) {
                //             return DropdownMenuItem<int>(
                //               value: season.year,
                //               child: Text(
                //                 season.year.toString(),
                //               ),
                //             );
                //           },
                //         ).toList(),
                //         value: leaguesCubit.year,
                //         onChanged: (int? value) {
                //           leaguesCubit.changeYear(value!);
                //           leaguesCubit.getStandingLeague(
                //             context,
                //             leagueId: leagueResponse.league.id,
                //             year: value,
                //           );
                //         },
                //         iconSize: AppSize.s26,
                //         iconEnabledColor: ColorManager.primary,
                //         style: Theme.of(context).textTheme.bodyMedium,
                //       ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StandingTable extends StatelessWidget {
  const StandingTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaguesCubit, LeaguesState>(
      listener: (context, state) {},
      builder: (context, state) {
        LeaguesCubit leaguesCubit = LeaguesCubit.get(context);

        return leaguesCubit.standing.isNotEmpty
            ? Expanded(
                // Check if League Or Champions League
                child: leaguesCubit.standing.length > 1
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          List<Standing?> group = leaguesCubit.standing[index];
                          return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Standing? team = group[index];
                              return TeamBuilder(
                                leaguesCubit: leaguesCubit,
                                index: index,
                                team: team!,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: AppSize.s8);
                            },
                            itemCount: group.length,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: AppSize.s16);
                        },
                        itemCount: leaguesCubit.standing.length,
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          Standing? team = leaguesCubit.standing.first[index];
                          return TeamBuilder(
                            leaguesCubit: leaguesCubit,
                            index: index,
                            team: team!,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: AppSize.s10);
                        },
                        itemCount: leaguesCubit.standing.length,
                      ),
              )
            : AdaptiveCircleIndicator();
      },
    );
  }
}

class TeamBuilder extends StatelessWidget {
  const TeamBuilder({
    super.key,
    required this.leaguesCubit,
    required this.index,
    required this.team,
  });

  final LeaguesCubit leaguesCubit;
  final int index;
  final Standing team;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (index == 0) ...[
          Text(
            team.rank.toString(),
            style: TextStyle(color: ColorManager.green),
          ),
        ] else if (index >= leaguesCubit.standing.length - 3) ...[
          Text(
            team.rank.toString(),
            style: TextStyle(color: ColorManager.red),
          ),
        ] else ...[
          Text(team.rank.toString()),
        ],
        const SizedBox(width: AppSize.s14),
        CachedNetworkImage(
          imageUrl: team.team.logo,
          height: AppSize.s40,
          width: AppSize.s40,
          placeholder: (context, url) => Shimmer(
            gradient: LinearGradient(
              colors: [
                ColorManager.darkPrimary,
                ColorManager.primary,
                ColorManager.lightPrimary,
                ColorManager.backGround,
              ],
            ),
            child: const SizedBox(
              height: AppSize.s40,
              width: AppSize.s40,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.sports_soccer_sharp,
          ),
        ),
        const SizedBox(width: AppSize.s6),
        Expanded(
          child: Text(
            team.team.name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(team.points.toString()),
        const SizedBox(width: AppSize.s6),
        Text(team.all.played.toString()),
        const SizedBox(width: AppSize.s6),
        Text(
          team.all.win.toString(),
          style: TextStyle(color: ColorManager.green),
        ),
        const SizedBox(width: AppSize.s6),
        Text(
          team.all.draw.toString(),
          style: TextStyle(color: ColorManager.grey),
        ),
        const SizedBox(width: AppSize.s6),
        Text(
          team.all.lose.toString(),
          style: TextStyle(color: ColorManager.red),
        ),
      ],
    );
  }
}
