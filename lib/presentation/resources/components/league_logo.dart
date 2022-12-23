import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/entities.dart';
import '../assets/assets.dart';
import '../colors/color_manager.dart';

class LeagueLogoHome extends StatelessWidget {
  const LeagueLogoHome({super.key, required this.liveMatch});

  final FixtureLiveResponse liveMatch;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
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
    );
  }
}

class LeagueLogoMatchDetails extends StatelessWidget {
  const LeagueLogoMatchDetails({super.key, required this.liveMatch});

  final FixtureResponse liveMatch;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
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
    );
  }
}