import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moscore/app/dependency_injection/dependency_injection.dart';
import 'package:moscore/app/shared_preferences/shared_preferences.dart';
import 'package:moscore/data/models/user/users_model.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../../../resources/assets/assets.dart';
import '../../../resources/colors/color_manager.dart';
import '../../../resources/components/components.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  bool isShow = false;

  void changePasswordVisibility() {
    isShow = !isShow;
    emit(PasswordVisibility());
  }

  Future<void> userCreate(
    BuildContext context, {
    required String displayName,
    required String email,
    required String uId,
    String photoURL = AssetsResources.logo,
  }) async {
    emit(CreateUserLoading());
    UsersModel usersModel = UsersModel(
      name: displayName,
      email: email,
      image: photoURL,
      uId: uId,
    );
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return await users.doc(uId).set(usersModel.toJson()).then((value) {
      emit(CreateUserSuccess());
    }).catchError((onError) {
      emit(CreateUserFail(onError.toString()));
      if (kDebugMode) {
        print(onError.toString());
      }
      snack(context, content: onError.toString(), bgColor: ColorManager.red);
    });
  }

  /// Create User With Email And Password With Firebase
  void createUserWithEmailAndPassword({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(UserRegisterLoading());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (data) {
          userCreate(
            context,
            displayName: name,
            email: email,
            uId: data.user!.uid,
          );
        },
      );
      emit(UserRegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(UserRegisterFail(e.message.toString()));
      snack(context, content: e.message.toString(), bgColor: ColorManager.red);

    } catch (e) {
      emit(UserRegisterFail(e.toString()));
      snack(context, content: e.toString(), bgColor: ColorManager.red);
      if (kDebugMode) {
        print(onError.toString());
      }
    }
  }

  /// Sign In With Email And Password With Firebase
  void signInWithEmailAndPassword({
    required BuildContext context,
    required String emailAddress,
    required String password,
  }) async {
    try {
      emit(UserLoginLoading());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      )
          .then((value) {
        getIt<AppPreferences>().setUId(uID: value.user!.uid);
        emit(UserLoginSuccess());
      });
    } on FirebaseAuthException catch (e) {
      emit(UserLoginFail(e.message.toString()));
      //snack(context, content: e.message.toString(), bgColor: ColorManager.error);
      alert(
        context,
        quickAlertType: QuickAlertType.error,
        text: e.message.toString(),
        textColor: ColorManager.error,
      );
      if (kDebugMode) {
        print(onError.toString());
      }
    }
  }
}
