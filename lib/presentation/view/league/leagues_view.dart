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
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(StringManager.league),
            ),
            body: state is GetLeaguesSuccess
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
                                getLeaguesSuccess: state,
                              ),
                              const SizedBox(height: AppSize.s20),
                              Leagues(
                                getLeaguesSuccess: state,
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
    required this.getLeaguesSuccess,
  });

  final TextEditingController searchTextEditController;
  final GetLeaguesSuccess getLeaguesSuccess;

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
        // TODO SEARCH ON LIST OF LEAGUES
      },
    );
  }
}

class Leagues extends StatelessWidget {
  const Leagues({
    super.key,
    required this.getLeaguesSuccess,
  });

  final GetLeaguesSuccess getLeaguesSuccess;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return LeagueItem(
            leagueResponse: getLeaguesSuccess.allLeagues[index],
          );
        },
        itemCount: getLeaguesSuccess.allLeagues.length,
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
    return ClipRRect(
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
        height: AppSize.s120,
        child: Row(
          children: [
             CachedNetworkImage(
              imageUrl: leagueResponse.league.logo,
               fit: BoxFit.cover,
               height: AppSize.s120,
               width: AppSize.s120,
            ),
            const SizedBox(width: AppSize.s14),
            Expanded(
              child: Text(
                leagueResponse.league.name,
                style: Theme.of(context).textTheme.headlineLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
