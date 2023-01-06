import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/domain/entities/entities.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../resources/colors/color_manager.dart';
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
          leagueId: 39,
          year: 2022,
        ),
      child: BlocConsumer<LeaguesCubit, LeaguesState>(
        listener: (context, state) {},
        builder: (context, state) {
          LeaguesCubit leaguesCubit = LeaguesCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p20,
                vertical: AppPadding.p10,
              ),
              child: Column(
                children: [
                  Card(
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
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          DropdownButton<int>(
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
                                leagueId: 39,
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
