import 'package:get_it/get_it.dart';

import 'package:moscore/domain/repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories_implementation/repositories_implemntation.dart';
import '../../presentation/view_model/cubit/app_cubit/app_cubit.dart';
import '../../presentation/view_model/cubit/auth_cubit/auth_cubit.dart';
import '../shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class Di {
  Future<void> getItSetup() async {
    //Shared Pref init
    final prefs = await SharedPreferences.getInstance();
    // shared pref instance
    getIt.registerLazySingleton<SharedPreferences>(() => prefs);
    getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(getIt()));

    // Repositories
    getIt.registerLazySingleton<Repositories>(
        () => RepositoriesImplementation());
    // UseCases

    // Cubit
    getIt.registerFactory<AuthCubit>(() => AuthCubit());
    getIt.registerFactory<AppCubit>(() => AppCubit());
  }
}
