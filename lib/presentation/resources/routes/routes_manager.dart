import 'package:flutter/material.dart';
import 'package:moscore/presentation/view/authentication/login_view.dart';
import 'package:moscore/presentation/view/profile/profile_update.dart';
import 'package:moscore/presentation/view/splash_view/splash_view.dart';

import '../../view/authentication/register_view.dart';
import '../../view/home/home_view.dart';
import '../../view/matches/matches_details_view.dart';
import '../../view/matches/matches_view.dart';
import '../../view/on_boarding/on_boarding_view.dart';
import '../../view/profile/profile_view.dart';
import '../string/string_manager.dart';

class Routes {
  static const String splash = '/';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String matches = '/matches';
  static const String matchesDetails = '/matchesDetails';
  static const String profile = '/profile';
  static const String profileUpdate = '/profile/profileUpdate';
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (context) => OnBoarding());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => LoginView());
      case Routes.register:
        return MaterialPageRoute(builder: (context) => RegisterView());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomeView());
      case Routes.matches:
        return MaterialPageRoute(builder: (context) => const MatchesView());
      case Routes.matchesDetails:
        return MaterialPageRoute(
            builder: (context) => const MatchesDetailsView());
      case Routes.profile:
        return MaterialPageRoute(builder: (context) => const ProfileView());
      case Routes.profileUpdate:
        return MaterialPageRoute(builder: (context) => ProfileUpdate());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              StringManager.noRouteFined,
            ),
          ),
          body: const Center(
            child: Text(
              StringManager.noRouteFined,
            ),
          ),
        );
      },
    );
  }
}
