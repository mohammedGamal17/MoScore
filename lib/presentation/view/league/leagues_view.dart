import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/dependency_injection/dependency_injection.dart';
import '../../../domain/entities/entities.dart';
import '../../resources/colors/color_manager.dart';
import '../../resources/components/components.dart';
import '../../resources/string/string_manager.dart';
import '../../resources/values/values_manager.dart';
import '../../view_model/cubit/leagues_cubit/leagues_cubit.dart';
import '../../view_model/cubit/leagues_cubit/leagues_state.dart';
import 'league_over_view.dart';

class LeaguesView extends StatelessWidget {
  LeaguesView({super.key});

  final searchTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LeaguesCubit>()..getAllLeague(context),
      child: BlocConsumer<LeaguesCubit, LeaguesState>(
        listener: (context, state) {},
        builder: (context, state) {
          LeaguesCubit leaguesCubit = LeaguesCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(StringManager.league),
            ),
            body: leaguesCubit.leagues.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: AppPadding.p20,
                            right: AppPadding.p20,
                            left: AppPadding.p20,
                          ),
                          child: Column(
                            children: [
                              Search(
                                searchTextEditController:
                                    searchTextEditController,
                                leaguesCubit: leaguesCubit,
                              ),
                              const SizedBox(height: AppSize.s20),
                              Body(
                                allLeagues: leaguesCubit.leagues,
                                leaguesCubit: leaguesCubit,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: AppSize.s60,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                    ],
                  )
                : AdaptiveCircleIndicator(),
          );
        },
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    super.key,
    required this.searchTextEditController,
    required this.leaguesCubit,
  });

  final TextEditingController searchTextEditController;
  final LeaguesCubit leaguesCubit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchTextEditController,
      style: TextStyle(color: ColorManager.primary),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: ColorManager.primary,
        ),
        hintText: 'World Cup',
      ),
      onChanged: (value) {
        leaguesCubit.onSearchTextChanged(value);
      },
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.allLeagues,
    required this.leaguesCubit,
  });

  final List<LeagueResponse> allLeagues;
  final LeaguesCubit leaguesCubit;

  @override
  Widget build(BuildContext context) {
    return leaguesCubit.searchResult.isNotEmpty
        ? SearchedLeagues(leaguesCubit: leaguesCubit)
        : AllLeagues(allLeagues: allLeagues);
  }
}

class SearchedLeagues extends StatelessWidget {
  const SearchedLeagues({
    super.key,
    required this.leaguesCubit,
  });

  final LeaguesCubit leaguesCubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return LeagueItem(
            leagueResponse: leaguesCubit.searchResult[index],
          );
        },
        itemCount: leaguesCubit.searchResult.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: AppSize.s10),
      ),
    );
  }
}

class AllLeagues extends StatelessWidget {
  const AllLeagues({
    super.key,
    required this.allLeagues,
  });

  final List<LeagueResponse> allLeagues;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return LeagueItem(
            leagueResponse: allLeagues[index],
          );
        },
        itemCount: allLeagues.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: AppSize.s10),
      ),
    );
  }
}

class LeagueItem extends StatelessWidget {
  const LeagueItem({
    super.key,
    required this.leagueResponse,
  });

  final LeagueResponse leagueResponse;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LeagueOverView(
              leagueResponse: leagueResponse,
              season: 2022,
            );
          },
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s24),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorManager.darkPrimary,
                ColorManager.primary,
                ColorManager.lightPrimary,
              ],
            ),
          ),
          height: AppSize.s100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
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
                      Text(
                        leagueResponse.league.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSize.s10),
                      Text(
                        leagueResponse.country.name,
                        style: Theme.of(context).textTheme.displayMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
