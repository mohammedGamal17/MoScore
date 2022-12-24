import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/entities.dart';
import '../../resources/colors/color_manager.dart';
import '../../resources/components/components.dart';
import '../../resources/fonts/fonts_manager.dart';
import '../../resources/string/string_manager.dart';
import '../../resources/values/values_manager.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';

class MatchesDetailsView extends StatelessWidget {
  const MatchesDetailsView({
    super.key,
    required this.id,
  });

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
                  ? RefreshIndicator(
                      onRefresh: () => fixtureCubit.reloadFixture(context,id: id),
                      backgroundColor: ColorManager.primary,
                      color: ColorManager.white,
                      child: Body(state: state),
                    )
                  : AdaptiveCircleIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key, required this.state});

  final GetFixtureByIdSuccess state;

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
            pinned: true,
            floating: true,
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
                                          .copyWith(
                                              color: ColorManager.content),
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
                                          .copyWith(
                                              color: ColorManager.content),
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
                Tab(child: Text('Flight')),
                Tab(child: Text('Train')),
                Tab(child: Text('Car')),
              ],
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(AppSize.s50),
                left: Radius.circular(AppSize.s50),
              ),
            ),
          ),
        ];
      },
      body: const TabBarView(
        children: <Widget>[
          Icon(Icons.flight, size: 350),
          Icon(Icons.directions_transit, size: 350),
          Icon(Icons.directions_car, size: 350),
        ],
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

class MatchBody extends StatelessWidget {
  const MatchBody({super.key, required this.liveMatch});

  final FixtureResponse liveMatch;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MatchSummary extends StatelessWidget {
  const MatchSummary({super.key, required this.liveMatch});

  final FixtureResponse liveMatch;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      reverse: true,
      itemBuilder: (context, index) {
        Events event = liveMatch.events[index];
        return Text(
          '${event.detail == 'Penalty' ? 'Goal Penalty' : event.detail}: ${event.time.elapsed}\' ${event.player.name}',
        );
      },
      itemCount: liveMatch.events.length,
    );
  }
}
