import 'package:flutter/material.dart';

import '../../resources/colors/color_manager.dart';
import '../../resources/string/string_manager.dart';
import '../../resources/values/values_manager.dart';

class TeamOverView extends StatelessWidget {
  const TeamOverView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (
          BuildContext context,
          bool innerBoxIsScrolled,
        ) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              scrolledUnderElevation: AppSize.s20,
              expandedHeight: AppSize.s200,
              centerTitle: true,
              title: Text('TEAM'),
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'liveMatch.league.name',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppSize.s4),
                        // Expanded(
                        //   child: SizedBox(
                        //     width: double.infinity,
                        //     height: double.infinity,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.stretch,
                        //       children: [
                        //         // Home
                        //         Expanded(
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             children: [
                        //               CachedNetworkImage(
                        //                 imageUrl: liveMatch.teams.home.logo,
                        //                 fit: BoxFit.cover,
                        //                 height: AppSize.s100,
                        //               ),
                        //               const SizedBox(height: AppSize.s4),
                        //               Text(
                        //                 liveMatch.teams.home.name,
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .headlineLarge,
                        //                 textAlign: TextAlign.center,
                        //                 maxLines: 2,
                        //                 overflow: TextOverflow.ellipsis,
                        //               ),
                        //               const SizedBox(height: AppSize.s4),
                        //               Text(
                        //                 StringManager.home,
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .labelMedium!
                        //                     .copyWith(
                        //                     color: ColorManager.content),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // Time and Score
                        //         Expanded(
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Row(
                        //                 crossAxisAlignment:
                        //                 CrossAxisAlignment.center,
                        //                 mainAxisAlignment:
                        //                 MainAxisAlignment.center,
                        //                 children: [
                        //                   Text(
                        //                     liveMatch.goals.home.toString(),
                        //                     style: Theme.of(context)
                        //                         .textTheme
                        //                         .headlineLarge!
                        //                         .copyWith(
                        //                         fontSize: FontsSize.s24),
                        //                   ),
                        //                   Text(
                        //                     ':',
                        //                     style: Theme.of(context)
                        //                         .textTheme
                        //                         .headlineLarge,
                        //                   ),
                        //                   Text(
                        //                     liveMatch.goals.away.toString(),
                        //                     style: Theme.of(context)
                        //                         .textTheme
                        //                         .headlineLarge!
                        //                         .copyWith(
                        //                         fontSize: FontsSize.s24),
                        //                   ),
                        //                 ],
                        //               ),
                        //               const SizedBox(height: AppSize.s4),
                        //               ClipRRect(
                        //                 borderRadius:
                        //                 BorderRadius.circular(AppSize.s10),
                        //                 child: Stack(
                        //                   alignment: Alignment.center,
                        //                   children: [
                        //                     Container(
                        //                       height: AppSize.s26,
                        //                       width: AppSize.s40,
                        //                       color: ColorManager.selectedItem,
                        //                     ),
                        //                     Container(
                        //                       height: AppSize.s24,
                        //                       width: AppSize.s38,
                        //                       decoration: BoxDecoration(
                        //                         color: ColorManager.darkPrimary,
                        //                         borderRadius:
                        //                         BorderRadius.circular(
                        //                             AppSize.s10),
                        //                       ),
                        //                       alignment: Alignment.center,
                        //                       child: Text(
                        //                         '${liveMatch.fixture.status.elapsed.toString()}\'',
                        //                         style: Theme.of(context)
                        //                             .textTheme
                        //                             .labelLarge,
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // Away
                        //         Expanded(
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             children: [
                        //               CachedNetworkImage(
                        //                 imageUrl: liveMatch.teams.away.logo,
                        //                 fit: BoxFit.cover,
                        //                 height: AppSize.s100,
                        //               ),
                        //               const SizedBox(height: AppSize.s4),
                        //               Text(
                        //                 liveMatch.teams.away.name,
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .headlineLarge,
                        //                 textAlign: TextAlign.center,
                        //                 maxLines: 2,
                        //                 overflow: TextOverflow.ellipsis,
                        //               ),
                        //               const SizedBox(height: AppSize.s4),
                        //               Text(
                        //                 StringManager.away,
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .labelMedium!
                        //                     .copyWith(
                        //                     color: ColorManager.content),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(AppSize.s40),
                  bottomLeft: Radius.circular(AppSize.s40),
                ),
              ),
            ),
          ];
        },
        body: const Padding(
          padding: EdgeInsets.all(AppPadding.p20),
          child: Center(child: Text('s')),
        ),
      ),
    );
  }
}
