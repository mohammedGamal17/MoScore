import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moscore/domain/entities/entities.dart';

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

  void userCreate({
    required String displayName,
    required String email,
    required String photoURL,
    required String uId,
  }) {
    Users user = Users(
      name: displayName,
      email: email,
      image: photoURL,
      uId: uId,
    );
  }

  /// Create User With Email And Password With Firebase
  void createUserWithEmailAndPassword({
    required BuildContext context,
    required String name,
    required String emailAddress,
    required String password,
    required String imageUrl,
  }) async {
    try {
      emit(CreateUserLoading());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      )
          .then(
        (data) {
          userCreate(
            displayName: name,
            email: emailAddress,
            photoURL: imageUrl,
            uId: data.user!.uid,
          );
          emit(CreateUserLoading());
        },
      );
      emit(CreateUserSuccess());
    } on FirebaseAuthException catch (e) {
      emit(CreateUserFail(e.message.toString()));
      snack(context, content: e.message.toString(), bgColor: ColorManager.red);
    } catch (e) {
      emit(CreateUserFail(e.toString()));
      snack(context, content: e.toString(), bgColor: ColorManager.red);
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
        emit(UserLoginSuccess());
      });
    } on FirebaseAuthException catch (e) {
      emit(UserLoginFail(e.message.toString()));
      snack(context, content: e.message.toString(), bgColor: ColorManager.red);
    }
  }
}
