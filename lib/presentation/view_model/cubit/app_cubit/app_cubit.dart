import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/app/dependency_injection/dependency_injection.dart';
import 'package:moscore/app/shared_preferences/shared_preferences.dart';
import 'package:moscore/data/models/user/users_model.dart';

import '../../../resources/colors/color_manager.dart';
import '../../../resources/components/components.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  UsersModel? usersModel;
  final String? uId = getIt<AppPreferences>().getUId();

  void getUserData(context) {
    emit(GetUserDataLoading());

    final fireStore = FirebaseFirestore.instance;
    final fireStoreDirection = fireStore.collection('users').doc(uId);
    fireStoreDirection.get().then((value) {
      usersModel = UsersModel.fromJson(value.data()!);
      if (kDebugMode) {
        print(usersModel!.name);
      }
      emit(GetUserDataSuccess());
    }).catchError((onError) {
      snack(context, content: onError.toString(), bgColor: ColorManager.error);
      emit(GetUserDataFail(onError.toString()));
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }
}