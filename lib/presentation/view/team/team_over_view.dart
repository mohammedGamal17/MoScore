import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/entities.dart';
import '../../resources/colors/color_manager.dart';
import '../../resources/components/components.dart';
import '../../resources/string/string_manager.dart';
import '../../resources/values/values_manager.dart';
import '../../view_model/cubit/team_cubit/team_cubit.dart';
import '../../view_model/cubit/team_cubit/team_state.dart';

class TeamOverView extends StatelessWidget {
  const TeamOverView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TeamCubit>()..getTeamInfo(context, id: id),
      child: BlocConsumer<TeamCubit, TeamState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: state is TeamInfoSuccess
                ? Builder(
                    builder: (context) {
                      TeamInfo team = state.teamInfo[0];
                      return NestedScrollView(
                        headerSliverBuilder: (
                          BuildContext context,
                          bool innerBoxIsScrolled,
                        ) {
                          return [
                            SliverAppBar(
                              pinned: true,
                              floating: true,
                              snap: false,
                              scrolledUnderElevation: AppSize.s20,
                              expandedHeight: AppSize.s200,
                              centerTitle: true,
                              title: Text(team.team.name),
                              flexibleSpace: FlexibleSpaceBar(
                                background: SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: team.team.logo,
                                          height: AppSize.s140,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Shimmer(
                                            gradient: LinearGradient(
                                              colors: [
                                                ColorManager.darkPrimary,
                                                ColorManager.primary,
                                                ColorManager.lightPrimary,
                                                ColorManager.backGround,
                                              ],
                                            ),
                                            child: const CircleAvatar(
                                              radius: AppSize.s40,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(AppSize.s40),
                                  bottomLeft: Radius.circular(AppSize.s40),
                                ),
                              ),
                            ),
                          ];
                        },
                        body: Padding(
                          padding: const EdgeInsets.all(AppPadding.p20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    StringManager.name,
                                    style: TextStyle(
                                      fontSize: AppSize.s14,
                                      color: ColorManager.lightPrimary,
                                    ),
                                  ),
                                  const Text(':'),
                                  const SizedBox(width: AppSize.s6),
                                  Expanded(
                                    child: Text(
                                      team.team.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    StringManager.founded,
                                    style: TextStyle(
                                      fontSize: AppSize.s14,
                                      color: ColorManager.lightPrimary,
                                    ),
                                  ),
                                  const Text(':'),
                                  const SizedBox(width: AppSize.s6),
                                  Expanded(
                                    child: Text(
                                      team.team.founded.toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              team.team.national!
                                  ? Row(
                                      children: [
                                        Text(
                                          StringManager.nationalTeam,
                                          style: TextStyle(
                                            fontSize: AppSize.s14,
                                            color: ColorManager.lightPrimary,
                                          ),
                                        ),
                                        const Text(':'),
                                        const SizedBox(width: AppSize.s6),
                                        Expanded(
                                          child: Text(
                                            team.team.national.toString(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          StringManager.country,
                                          style: TextStyle(
                                            fontSize: AppSize.s14,
                                            color: ColorManager.lightPrimary,
                                          ),
                                        ),
                                        const Text(':'),
                                        const SizedBox(width: AppSize.s6),
                                        Expanded(
                                          child: Text(
                                            team.team.country!,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                              separator(),
                              Row(
                                children: [
                                  Text(
                                    StringManager.stadium,
                                    style: TextStyle(
                                      fontSize: AppSize.s14,
                                      color: ColorManager.lightPrimary,
                                    ),
                                  ),
                                  const Text(':'),
                                  const SizedBox(width: AppSize.s6),
                                  Expanded(
                                    child: Text(
                                      team.venue.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Text(
                                    StringManager.city,
                                    style: TextStyle(
                                      fontSize: AppSize.s14,
                                      color: ColorManager.lightPrimary,
                                    ),
                                  ),
                                  const Text(':'),
                                  const SizedBox(width: AppSize.s6),
                                  Expanded(
                                    child: Text(
                                      team.venue.city,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : AdaptiveCircleIndicator(),
          );
        },
      ),
    );
  }
}
