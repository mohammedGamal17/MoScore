import 'package:flutter/material.dart';
import 'package:moscore/presentation/resources/theme/theme_manager.dart';

import '../presentation/resources/routes/routes_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesGenerator.getRoute,
      initialRoute: Routes.splash,
      theme: getLightModeThemeData(),
    );
  }
}
