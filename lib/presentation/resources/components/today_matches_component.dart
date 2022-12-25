import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moscore/presentation/resources/string/string_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/entities.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';
import '../colors/color_manager.dart';
import '../fonts/fonts_manager.dart';
import '../values/values_manager.dart';
import 'components.dart';

class TodayMatches extends StatelessWidget {
  const TodayMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FixtureCubit>()..getTodayMatches(context),
      child: BlocConsumer<FixtureCubit, FixtureState>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is GetTodayMatchesSuccess
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          StringManager.todayMatches,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: ColorManager.primary,
                                    fontSize: FontsSize.s20,
                                  ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
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
                    SizedBox(
                      height: 600.0,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          FixtureTodayResponse matches =
                              state.fixtureToday[index];
                          DateTime tsDate = DateTime.fromMillisecondsSinceEpoch(
                              matches.fixture.timestamp);
                          String fDateTime = DateFormat('hh:mm').format(tsDate);
                          return Card(
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
                                    Expanded(
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
                                                child: Container(),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: AppSize.s6),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          fDateTime,
                                          style: TextStyle(
                                              color: ColorManager.white),
                                        ),
                                        Text(
                                          '30 Oct',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: AppSize.s6),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: matches.teams.away.logo,
                                            height: AppSize.s60,
                                            width: AppSize.s60,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Shimmer(
                                              gradient: LinearGradient(
                                                colors: [
                                                  ColorManager.darkPrimary,
                                                  ColorManager.primary,
                                                  ColorManager.lightPrimary,
                                                ],
                                              ),
                                              child: Container(),
                                            ),
                                          ),
                                          const SizedBox(width: AppSize.s10),
                                          Expanded(
                                            child: Text(
                                              matches.teams.away.name,
                                              style: TextStyle(
                                                  color: ColorManager.white),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: state.fixtureToday.length,
                      ),
                    ),
                  ],
                )
              : AdaptiveCircleIndicator();
        },
      ),
    );
  }
}
