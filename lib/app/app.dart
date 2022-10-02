import 'package:flutter/material.dart';

import '../presentation/resources/routes/routes_manager.dart';
import '../presentation/view/on_boarding_view.dart';

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
