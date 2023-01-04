import 'package:flutter/material.dart';
import 'package:moscore/presentation/resources/assets/assets.dart';
import 'package:moscore/presentation/resources/colors/color_manager.dart';

import '../../resources/string/string_manager.dart';
import '../../resources/values/values_manager.dart';

class LeaguesView extends StatelessWidget {
  LeaguesView({super.key});

  final searchTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(StringManager.league),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          children: [
            TextFormField(
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
            ),
            const SizedBox(height: AppSize.s20),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return const LeagueItem();
                },
                itemCount: 50,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: AppSize.s10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeagueItem extends StatelessWidget {
  const LeagueItem({super.key});

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
        height: AppSize.s80,
        child: Row(
          children: [
            const Image(
              image: AssetImage(AssetsResources.logo),
            ),
            const SizedBox(width: AppSize.s14),
            Text(
              'WORLD CUP',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
