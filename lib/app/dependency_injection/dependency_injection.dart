import 'package:get_it/get_it.dart';
import 'package:moscore/domain/use_cases/auth_use_cases/register_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/view_model/cubit/auth_cubit/auth_cubit.dart';
import '../shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> getItSetup() async {
  //Shared Pref init
  final prefs = await SharedPreferences.getInstance();
  // Shared Pref inject
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(prefs));

  // UseCases
  getIt.registerLazySingleton<RegisterUseCase>(getIt());


  // Cubit
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
}
