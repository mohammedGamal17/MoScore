import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moscore/domain/entities/entities.dart';

import '../../resources/colors/color_manager.dart';
import '../../resources/values/values_manager.dart';

class LeagueOverView extends StatelessWidget {
  const LeagueOverView({super.key, required this.leagueResponse});

  final LeagueResponse leagueResponse;

  @override
  Widget build(BuildContext context) {
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
                            style: Theme.of(context).textTheme.displayMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    DropdownButton(
                      items: leagueResponse.seasons.map(
                        (season) {
                          return DropdownMenuItem(
                            value: season.year,
                            child: Text(
                              season.year.toString(),
                            ),
                          );
                        },
                      ).toList(),
                      value: leagueResponse.seasons[0].year,
                      onChanged: (value) {},
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
  }
}
