import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:moscore/domain/repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/remote/info/network_info.dart';
import '../../data/repositories_implementation/repositories_implementation.dart';
import '../../presentation/view_model/cubit/profile_cubit/profile_cubit.dart';
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

    // Network Info
    getIt.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImplement(InternetConnectionChecker()));

    // Repositories
    getIt.registerLazySingleton<Repositories>(
        () => RepositoriesImplementation());
    // UseCases

    // Cubit
    getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<NetworkInfo>()));
    getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt<NetworkInfo>()));
  }
}
