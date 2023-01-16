import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/presentation/view/team/team_over_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/ads/ads_helper.dart';
import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/entities.dart';
import '../../resources/colors/color_manager.dart';
import '../../resources/components/components.dart';
import '../../resources/string/string_manager.dart';
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
              Text(StringManager.dash),
              SizedBox(width: AppSize.s14),
              Text(StringManager.team),
              Spacer(),
              Text(StringManager.points),
              SizedBox(width: AppSize.s10),
              Text(StringManager.play),
              SizedBox(width: AppSize.s10),
              Text(StringManager.win),
              SizedBox(width: AppSize.s10),
              Text(StringManager.draw),
              SizedBox(width: AppSize.s10),
              Text(StringManager.lose),
              SizedBox(width: AppSize.s10),
              Text(StringManager.goals),
              SizedBox(width: AppSize.s8),
            ],
          ),
          const SizedBox(height: AppSize.s10),
          const StandingTable(),
          const BannerAdComponent(),
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
                leaguesCubit.standingForOneGroup.isEmpty
                    ? const SizedBox()
                    : DropdownButton<int>(
                        items: leagueResponse.seasons.map(
                          (season) {
                            return DropdownMenuItem<int>(
                              value: season.year,
                              child: Text(
                                season.year.toString(),
                              ),
                            );
                          },
                        ).toList(),
                        value: leaguesCubit.year,
                        onChanged: (int? value) {
                          leaguesCubit.changeYear(value!);
                          leaguesCubit.getStandingLeague(
                            context,
                            leagueId: leagueResponse.league.id,
                            year: value,
                          );
                        },
                        iconSize: AppSize.s26,
                        iconEnabledColor: ColorManager.primary,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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

        return leaguesCubit.standingForGroups.isNotEmpty ||
                leaguesCubit.standingForOneGroup.isNotEmpty
            ? Expanded(
                // Check if League one Group or multi Groups
                child: leaguesCubit.standingForGroups.length > 1
                    ? LeagueOfGroups(leaguesCubit: leaguesCubit)
                    : LeagueOfOneGroup(leaguesCubit: leaguesCubit),
              )
            : AdaptiveCircleIndicator();
      },
    );
  }
}

class LeagueOfGroups extends StatelessWidget {
  const LeagueOfGroups({super.key, required this.leaguesCubit});

  final LeaguesCubit leaguesCubit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        List<Standing?> group = leaguesCubit.standingForGroups[index];
        return ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            Standing? team = group[index];

            return Column(
              children: [
                if (index == 0)
                  Column(
                    children: [
                      Text(team!.group),
                      separator(
                          horizontalPadding: AppPadding.p100,
                          verticalPadding: AppPadding.p6)
                    ],
                  ),
                TeamBuilder(
                  leaguesCubit: leaguesCubit,
                  index: index,
                  team: team!,
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: AppSize.s8);
          },
          itemCount: group.length,
        );
      },
      separatorBuilder: (context, index) {
        return separator();
      },
      itemCount: leaguesCubit.standingForGroups.length,
    );
  }
}

class LeagueOfOneGroup extends StatelessWidget {
  const LeagueOfOneGroup({super.key, required this.leaguesCubit});

  final LeaguesCubit leaguesCubit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        Standing? team = leaguesCubit.standingForOneGroup[index];
        return TeamBuilder(
          leaguesCubit: leaguesCubit,
          index: index,
          team: team!,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: AppSize.s10);
      },
      itemCount: leaguesCubit.standingForOneGroup.length,
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
        SizedBox(
          width: AppSize.s24,
          child: Text(team.rank.toString()),
        ),
        const SizedBox(width: AppSize.s10),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeamOverView(id:team.team.id),
              ),
            );
          },
          child: CachedNetworkImage(
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
        ),
        const SizedBox(width: AppSize.s4),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeamOverView(id:team.team.id),
                ),
              );
            },
            child: Text(
              team.team.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        SizedBox(
          width: AppSize.s24,
          child: Text(
            team.points.toString(),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: AppSize.s24,
          child: Text(
            team.all.played.toString(),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: AppSize.s24,
          child: Text(
            team.all.win.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorManager.green),
          ),
        ),
        SizedBox(
          width: AppSize.s16,
          child: Text(
            team.all.draw.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorManager.grey),
          ),
        ),
        SizedBox(
          width: AppSize.s24,
          child: Text(
            team.all.lose.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorManager.red),
          ),
        ),
        SizedBox(
          width: AppSize.s30,
          child: Text(
            team.goalsDiff.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorManager.red),
          ),
        ),
      ],
    );
  }
}
