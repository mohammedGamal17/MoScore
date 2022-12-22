import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/entities.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';
import '../colors/color_manager.dart';
import '../fonts/fonts_manager.dart';
import '../string/string_manager.dart';
import '../values/values_manager.dart';
import 'components.dart';

class MatchSummaryComponents extends StatelessWidget {
  const MatchSummaryComponents({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FixtureCubit, FixtureState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is GetLiveFixtureSuccess
            ? Builder(builder: (context) {
                FixtureResponse liveMatch = state.liveFixture.elementAt(index);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
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
                                            borderRadius: BorderRadius.circular(
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
              })
            : AdaptiveCircleIndicator();
      },
    );
  }
}
