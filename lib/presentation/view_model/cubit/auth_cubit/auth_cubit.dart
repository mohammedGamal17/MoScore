import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moscore/domain/use_cases/auth_use_cases/register_use_case.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.registerUseCase) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  final RegisterUseCase registerUseCase;
  bool isShow = false;

  void changePasswordVisibility() {
    isShow = !isShow;
    emit(PasswordVisibility());
  }

  void createUserWithEmailAndPassword({
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
          .then((value) {
        imageUrl = value.user!.photoURL!;
        registerUseCase.call(
          RegisterInputs(
            value.user!.displayName!,
            emailAddress,
            password,
            value.user!.photoURL!,
          ),
        );
      });
      emit(CreateUserSuccess());
    } on FirebaseAuthException catch (e) {
      emit(CreateUserFail(e.message.toString()));

      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      emit(CreateUserFail(e.toString()));
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
