import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
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
                ? NestedScrollView(
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
                          title: Text(state.teamInfo[0].team.name),
                          flexibleSpace: FlexibleSpaceBar(
                            background: SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: state.teamInfo[0].team.logo,
                                      height: AppSize.s140,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Shimmer(
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
                    body:  Padding(
                      padding:const EdgeInsets.all(AppPadding.p20),
                      child: Column(
                        children: [
                          Text(state.teamInfo[0].team.name),
                          Text(state.teamInfo[0].team.founded.toString()),
                          Text(state.teamInfo[0].team.national.toString()),
                          Text(state.teamInfo[0].team.country!),

                          separator(),

                          Text(state.teamInfo[0].venue.name),
                          Text(state.teamInfo[0].venue.city),

                        ],
                      ),
                    ),
                  )
                : AdaptiveCircleIndicator(),
          );
        },
      ),
    );
  }
}
