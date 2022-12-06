import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/app/dependency_injection/dependency_injection.dart';
import 'package:moscore/presentation/resources/theme/theme_manager.dart';

import '../presentation/resources/routes/routes_manager.dart';
import '../presentation/view_model/cubit/auth_cubit/auth_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesGenerator.getRoute,
        initialRoute: Routes.splash,
        themeMode: ThemeMode.light,
        theme: getLightModeThemeData(),
      ),
    );
  }
}
