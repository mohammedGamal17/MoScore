import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/entities.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';
import '../assets/assets.dart';
import '../colors/color_manager.dart';
import '../string/string_manager.dart';
import '../values/values_manager.dart';
import 'components.dart';
import 'no_live_matches.dart';

class LiveMatches extends StatelessWidget {
  const LiveMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FixtureCubit>()..getLiveFixture(context),
      child: BlocConsumer<FixtureCubit, FixtureState>(
        listener: (context, state) {},
        builder: (context, state) {
          FixtureCubit fixtureCubit = FixtureCubit.get(context);
          return RefreshIndicator(
            onRefresh: () => fixtureCubit.reload(context),
            backgroundColor: ColorManager.primary,
            color: ColorManager.white,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    state is GetLiveFixtureSuccess
                        ? LiveMatch(getLiveFixtureSuccessState: state)
                        : AdaptiveCircleIndicator(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LiveMatch extends StatelessWidget {
  LiveMatch({super.key, required this.getLiveFixtureSuccessState});

  final ScrollController _horizontal = ScrollController();
  final GetLiveFixtureSuccess getLiveFixtureSuccessState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringManager.liveMatch,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSize.s20),
        getLiveFixtureSuccessState.liveFixture.isNotEmpty
            ? SizedBox(
                height: AppSize.s214,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: getLiveFixtureSuccessState.liveFixture.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: _horizontal,
                  itemBuilder: (context, index) {
                    FixtureResponse liveMatch =
                        getLiveFixtureSuccessState.liveFixture[index];
                    return MatchBody(liveMatch: liveMatch);
                  },
                ),
              )
            : const NoLiveMatches()
      ],
    );
  }
}

class MatchBody extends StatelessWidget {
  const MatchBody({super.key, required this.liveMatch});

  final FixtureResponse liveMatch;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO NAVIGATE TO MATCH DETAILS SCREEN
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s10),
          child: Container(
            width: AppSize.s300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorManager.darkPrimary,
                  ColorManager.primary,
                  ColorManager.lightPrimary,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  // League Logo
                  CachedNetworkImage(
                    imageUrl: liveMatch.league.logo,
                    color: Colors.white.withOpacity(0.1),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.darkPrimary,
                          ColorManager.primary,
                          ColorManager.lightPrimary,
                        ],
                      ),
                      child: Container(),
                    ),
                    errorWidget: (context, url, error) => Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.darkPrimary,
                          ColorManager.primary,
                          ColorManager.lightPrimary,
                        ],
                      ),
                      child: const Image(
                        image: AssetImage(AssetsResources.logo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        liveMatch.league.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppSize.s6),
                      Text(
                        liveMatch.league.round,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: ColorManager.content),
                      ),
                      const SizedBox(height: AppSize.s10),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
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
                                    Expanded(
                                      child: Text(
                                        liveMatch.teams.home.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
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
                                              .headlineLarge,
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
                                              .headlineLarge,
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
                                                '${liveMatch.fixture.status.elapsed.toString()}\''),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
                                    Expanded(
                                      child: Text(
                                        liveMatch.teams.away.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
