import 'package:flutter/material.dart';

import '../presentation/resources/routes/routes_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesGenerator.getRoute,
      initialRoute: Routes.splash,
    );
  }
}
