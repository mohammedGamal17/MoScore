import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:moscore/domain/use_cases/fixture_by_id_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/remote/info/network_info.dart';
import '../../data/network/remote/remote_data_source/remote_data_source.dart';
import '../../data/repositories_implementation/repositories_implementation.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/use_cases/live_fixture_use_case.dart';
import '../../presentation/view_model/cubit/fixture_cubit/fixture_cubit.dart';
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
    getIt.registerLazySingleton<AppPreferences>(
      () => AppPreferences(
        getIt(),
      ),
    );

    // Network Info
    getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplement(
        InternetConnectionChecker(),
      ),
    );

    // Remote Data Source
    getIt.registerLazySingleton<BaseRemoteDataSource>(
      () => RemoteDataSourceImplement(),
    );

    // Repositories
    getIt.registerLazySingleton<Repositories>(
      () => RepositoriesImplementation(
        getIt<BaseRemoteDataSource>(),
      ),
    );
    // UseCases
    getIt.registerLazySingleton<LiveFixtureUseCase>(
      () => LiveFixtureUseCase(
        getIt<Repositories>(),
      ),
    );
    getIt.registerLazySingleton<FixtureByIdUseCase>(
      () => FixtureByIdUseCase(
        getIt<Repositories>(),
      ),
    );

    // Cubit
    getIt.registerFactory<AuthCubit>(
      () => AuthCubit(
        getIt<NetworkInfo>(),
      ),
    );
    getIt.registerFactory<ProfileCubit>(
      () => ProfileCubit(
        getIt<NetworkInfo>(),
      ),
    );
    getIt.registerFactory<FixtureCubit>(
      () => FixtureCubit(
        getIt<NetworkInfo>(),
        getIt<LiveFixtureUseCase>(),
        getIt<FixtureByIdUseCase>(),
      ),
    );
  }
}
