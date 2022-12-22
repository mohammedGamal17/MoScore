import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moscore/app/dependency_injection/dependency_injection.dart';
import 'package:moscore/app/shared_preferences/shared_preferences.dart';
import 'package:moscore/data/models/user/users_model.dart';
import 'package:moscore/data/network/remote/info/network_info.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../../../resources/assets/assets.dart';
import '../../../resources/colors/color_manager.dart';
import '../../../resources/components/components.dart';
import '../../../resources/routes/routes_manager.dart';
import '../../../resources/string/string_manager.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._networkInfo) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  final NetworkInfo _networkInfo;
  bool isShow = false;

  void changePasswordVisibility() {
    isShow = !isShow;
    emit(PasswordVisibility());
  }

  /// Create User Firebase Fire Store
  Future<void> userCreate(
    BuildContext context, {
    required String displayName,
    required String email,
    required String uId,
    String? photoURL,
  }) async {
    emit(CreateUserLoading());
    UsersModel usersModel = UsersModel(
      name: displayName,
      email: email,
      image: photoURL ?? AssetsResources.logoURL,
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
    });
  }

  /// Sign In Anonymously With Firebase
  Future signInAnonymously(
    context,
  ) async {
    if (await _networkInfo.isConnected) {
      emit(SignInAnonymouslyLoading());
      try {
        await FirebaseAuth.instance.signInAnonymously().then((value) {
          getIt<AppPreferences>().setUId(uID: value.user!.uid);
          getIt<AppPreferences>().setIsAnonymously(isAnonymous: true);
          userCreate(
            context,
            displayName: value.user!.displayName ??
                StringManager.anonymouslyUser(
                  firstThreeIndex: value.user!.uid.substring(1, 4),
                ),
            email: value.user!.email ??
                StringManager.anonymouslyMail(
                  firstThreeIndex: value.user!.uid.substring(1, 4),
                ),
            uId: value.user!.uid,
          );
          emit(SignInAnonymouslySuccess());
        });
      } on FirebaseAuthException catch (e) {
        emit(SignInAnonymouslyFail(e.message.toString()));
        alert(
          context,
          quickAlertType: QuickAlertType.error,
          text: e.message.toString(),
          textColor: ColorManager.error,
        );
      }
    } else {
      alert(
        context,
        quickAlertType: QuickAlertType.error,
        text: StringManager.noInternetError,
        textColor: ColorManager.error,
      );
      return null;
    }
  }

  /// Create User With Email And Password With Firebase
  void createUserWithEmailAndPassword({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    if (await _networkInfo.isConnected) {
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
        snack(context,
            content: e.message.toString(), bgColor: ColorManager.red);
      } catch (e) {
        emit(UserRegisterFail(e.toString()));
        snack(context, content: e.toString(), bgColor: ColorManager.red);
        if (kDebugMode) {
          print(onError.toString());
        }
      }
    } else {
      if (kDebugMode) {
        print(StringManager.noInternetError);
      }
      return alert(
        context,
        quickAlertType: QuickAlertType.error,
        text: StringManager.noInternetError,
        textColor: ColorManager.error,
      );
    }
  }

  /// Sign In With Email And Password With Firebase
  void signInWithEmailAndPassword({
    required BuildContext context,
    required String emailAddress,
    required String password,
  }) async {
    if (await _networkInfo.isConnected) {
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
    } else {
      if (kDebugMode) {
        print(StringManager.noInternetError);
      }
      return alert(
        context,
        quickAlertType: QuickAlertType.error,
        text: StringManager.noInternetError,
        textColor: ColorManager.error,
      );
    }
  }

  /// Sign In With Google
  Future<UserCredential?> signInWithGoogle(context) async {
    if (await _networkInfo.isConnected) {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        getIt<AppPreferences>().setUId(uID: value.user!.uid);
        if (kDebugMode) {
          print(value.user!.photoURL);
        }
        userCreate(
          context,
          displayName: value.user!.displayName!,
          email: value.user!.email!,
          uId: value.user!.uid,
          photoURL: value.user!.photoURL,
        );
        emit(SignInWithGoogleSuccess());
        return value;
      }).catchError((onError) {
        if (kDebugMode) {
          print(onError.toString());
        }
        alert(
          context,
          quickAlertType: QuickAlertType.error,
          text: onError.toString(),
          textColor: ColorManager.red,
        );
      });
    } else {
      alert(
        context,
        quickAlertType: QuickAlertType.error,
        text: StringManager.noInternetError,
        textColor: ColorManager.error,
      );
      return null;
    }
  }

  /// Sign In With FaceBook
  Future<UserCredential?> signInWithFacebook(context) async {
    emit(SignInWithFaceBookLoading());
    if (await _networkInfo.isConnected) {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential fbAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      return FirebaseAuth.instance
          .signInWithCredential(fbAuthCredential)
          .then((value) {
        getIt<AppPreferences>().setUId(uID: value.user!.uid);
        userCreate(
          context,
          displayName: value.user!.displayName!,
          email: value.user!.email!,
          uId: value.user!.uid,
          photoURL: value.user!.photoURL,
        );
        emit(SignInWithFaceBookSuccess());
        return value;
      }).catchError((onError) {
        if (kDebugMode) {
          print(onError.toString());
        }
        alert(
          context,
          quickAlertType: QuickAlertType.error,
          text: onError.toString(),
          textColor: ColorManager.red,
        );
        emit(SignInWithFaceBookFail(onError.toString()));
      });
    } else {
      alert(
        context,
        quickAlertType: QuickAlertType.error,
        text: StringManager.noInternetError,
        textColor: ColorManager.red,
      );
      emit(SignInWithFaceBookFail(StringManager.noInternetError));
      return null;
    }
  }

  /// SignOut Function
  Future signOut(context) async {
    emit(SignOutLoading());
    await FirebaseAuth.instance.signOut().then((value) {
      getIt<AppPreferences>().clearAllCache();
      alert(
        context,
        quickAlertType: QuickAlertType.success,
        text: StringManager.logOut,
        textColor: ColorManager.primary,
      );
      Navigator.pushReplacementNamed(context, Routes.login);
      getIt<AppPreferences>().setUId(uID: '');
      getIt<AppPreferences>().setIsSignIn(isSign: false);
      emit(SignOutSuccess());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      alert(
        context,
        quickAlertType: QuickAlertType.success,
        text: onError.toString(),
        textColor: ColorManager.primary,
      );
      emit(SignOutFail(onError.toString()));
    });
  }
}
