import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../resources/assets/assets.dart';
import '../../resources/colors/color_manager.dart';
import '../../resources/components/components.dart';
import '../../resources/components/live_matches_component.dart';
import '../../resources/components/today_matches_component.dart';
import '../../resources/fonts/fonts_manager.dart';
import '../../resources/routes/routes_manager.dart';
import '../../resources/string/string_manager.dart';
import '../../resources/values/values_manager.dart';
import '../../view_model/cubit/fixture_cubit/fixture_cubit.dart';
import '../../view_model/cubit/fixture_cubit/fixture_state.dart';
import '../../view_model/cubit/profile_cubit/profile_cubit.dart';
import '../../view_model/cubit/profile_cubit/profile_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          StringManager.appName,
          style: TextStyle(
            color: ColorManager.white,
            fontSize: FontsSize.s26,
            fontWeight: FontsWight.semiBold,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(AppSize.s24),
            bottomLeft: Radius.circular(AppSize.s24),
          ),
        ),
      ),
      drawer: const DrawerComponent(),
      body: BlocProvider(
        create: (context) => getIt<FixtureCubit>()
          ..getLiveFixture(context)
          ..getTodayMatches(context),
        child: BlocConsumer<FixtureCubit, FixtureState>(
          listener: (context, state) {},
          builder: (context, state) {
            FixtureCubit fixtureCubit = FixtureCubit.get(context);
            return state is GetLiveFixtureSuccess ||
                    state is GetTodayMatchesSuccess
                ? RefreshIndicator(
                    onRefresh: () => fixtureCubit.reloadHome(context),
                    backgroundColor: ColorManager.primary,
                    color: ColorManager.white,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LiveMatches(),
                            separator(horizontalPadding: AppPadding.p0),
                            const TodayMatches()
                          ],
                        ),
                      ),
                    ),
                  )
                : AdaptiveCircleIndicator();
          },
        ),
      ),
    );
  }
}

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        ProfileCubit profileCubit = ProfileCubit.get(context);
        return Drawer(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              DrawerHeaderComponent(profileCubit: profileCubit),
              ListTile(
                leading: const Icon(
                  Icons.search,
                ),
                title: const Text(StringManager.search),
                onTap: () {
                  // TODO SEARCH FROM API
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.live_tv_outlined,
                ),
                title: const Text(StringManager.live),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.sports_soccer_sharp),
                title: const Text(StringManager.league),
                onTap: () {
                  Navigator.pushNamed(context, Routes.leagues);
                },
              ),
              separator(
                horizontalPadding: AppPadding.p0,
                verticalPadding: AppPadding.p0,
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text(StringManager.settings),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text(StringManager.rateUs),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text(StringManager.shareMoScore),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}

class DrawerHeaderComponent extends StatelessWidget {
  const DrawerHeaderComponent({super.key, required this.profileCubit});

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: ColorManager.primary,
        image: const DecorationImage(
          image: AssetImage(AssetsResources.logo),
          opacity: 0.03,
          fit: BoxFit.cover,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorManager.primary,
            ColorManager.lightPrimary,
            ColorManager.backGround,
          ],
        ),
      ),
      child: profileCubit.usersModel != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s30),
                  child: CachedNetworkImage(
                    imageUrl: profileCubit.usersModel!.image,
                    placeholder: (context, url) => Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.primary,
                          ColorManager.lightPrimary,
                          ColorManager.white,
                        ],
                      ),
                      child: const CircleAvatar(radius: AppSize.s30),
                    ),
                    height: AppSize.s60,
                    width: AppSize.s60,
                  ),
                ),
                const SizedBox(height: AppSize.s10),
                Text(
                  profileCubit.usersModel!.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: FontsSize.s18),
                ),
                const SizedBox(height: AppSize.s10),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.profile);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringManager.profile,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Icon(Icons.keyboard_arrow_right_rounded)
                    ],
                  ),
                )
              ],
            )
          : AdaptiveCircleIndicator(),
    );
  }
}

class HomeLoadingSimmer extends StatelessWidget {
  const HomeLoadingSimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Shimmer(
        gradient: LinearGradient(
          colors: [
            ColorManager.darkPrimary,
            ColorManager.primary,
            ColorManager.lightPrimary,
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringManager.liveMatch,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: ColorManager.primary, fontSize: FontsSize.s20),
            ),
            const SizedBox(height: AppSize.s20),
            const SizedBox(
              height: AppSize.s250,
              width: double.infinity,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.s12),
                    ),
                  ),
                  color: ColorManager.primary,
                  elevation: AppSize.s6,
                  shadowColor: ColorManager.lightPrimary,
                  child: const SizedBox(
                    width: double.infinity,
                    height: AppSize.s100,
                  ),
                );
              },
              itemCount: 20,
            ),
          ],
        ),
      ),
    );
  }
}
