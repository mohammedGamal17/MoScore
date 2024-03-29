import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moscore/app/dependency_injection/dependency_injection.dart';
import 'package:moscore/app/shared_preferences/shared_preferences.dart';
import 'package:moscore/data/models/user/users_model.dart';
import 'package:moscore/data/network/remote/info/network_info.dart';
import 'package:moscore/presentation/resources/string/string_manager.dart';
import 'package:quickalert/quickalert.dart';

import '../../../resources/colors/color_manager.dart';
import '../../../resources/components/components.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._networkInfo) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  final NetworkInfo _networkInfo;
  UsersModel? usersModel;
  final String? uId = getIt<AppPreferences>().getUId();
  final ImagePicker _picker = ImagePicker();
  File? imagePath;
  String? imageLink;

  void getUserData(context) {
    emit(GetUserDataLoading());

    final fireStore = FirebaseFirestore.instance;
    final fireStoreDirection = fireStore.collection('users').doc(uId);
    fireStoreDirection.get().then((value) {
      usersModel = UsersModel.fromJson(value.data()!);
      emit(GetUserDataSuccess());
    }).catchError((onError) {
      snack(context, content: onError.toString(), bgColor: ColorManager.error);
      emit(GetUserDataFail(onError.toString()));
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }

  Future<void> userUpdateData(
    context, {
    String? displayName,
    String? email,
    String? photoURL,
  }) async {
    if (await _networkInfo.isConnected) {
      emit(UpdateUserDataLoading());
      UsersModel userModel = UsersModel(
        name: displayName ?? usersModel!.name,
        image: photoURL ?? usersModel!.image,
        email: email ?? usersModel!.email,
        uId: uId!,
      );

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      return await users.doc(uId).update(userModel.toJson()).then((value) {
        //FirebaseAuth.instance.currentUser!.updateEmail(email!);
        FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
        FirebaseAuth.instance.currentUser!.updatePhotoURL(photoURL);
        alert(
          context,
          quickAlertType: QuickAlertType.success,
          text: StringManager.updated,
          textColor: ColorManager.primary,
        );
        emit(UpdateUserDataSuccess());
      }).catchError((onError) {
        emit(UpdateUserDataFail(onError.toString()));
        alert(
          context,
          quickAlertType: QuickAlertType.error,
          text: onError.toString(),
          textColor: ColorManager.error,
        );
      });
    } else {
      noInternet(context);
    }
  }

  Future pickImage() async {
    await _picker
        .pickImage(source: ImageSource.gallery, imageQuality: 100)
        .then((value) {
      if (value!.path.isNotEmpty) {
        imagePath = File(value.path);
        emit(ImagePickedSuccess());
      }
    }).onError((error, stackTrace) {
      emit(ImagePickedFail());
    });
  }

  Future uploadImage(context) async {
    if (await _networkInfo.isConnected) {
      emit(ImageUploadLoading());
      final storageRef = FirebaseStorage.instance.ref();

      final imagesRef = storageRef
          .child('users/${(Uri.file(imagePath!.path).pathSegments.last)}');
      try {
        final imageUrl = await imagesRef.putFile(imagePath!);
        imageUrl.ref.getDownloadURL().then((value) => {
              userUpdateData(
                context,
                photoURL: value,
              ),
              imageLink = value,
              emit(ImageUploadSuccess()),
            });
      } on FirebaseException catch (e) {
        emit(ImageUploadFail(e.message.toString()));
        alert(
          context,
          quickAlertType: QuickAlertType.error,
          text: e.message.toString(),
          textColor: ColorManager.error,
        );
      }
    } else {
      emit(ImageUploadFail(StringManager.noInternetError));
      noInternet(context);
    }
  }

  List favPlayer = [1, 1, 1, 1, 1, 1];
  List favTeam = [1, 1, 1, 1, 1, 1, 1, 1];
  List favLeague = [1, 1, 1];

  bool readOnly = true;

  bool changeReadOnly() {
    readOnly = !readOnly;
    emit(ChangeReadOnly());
    return readOnly;
  }

  bool nameChanged = false;

  bool changeName() {
    nameChanged != nameChanged;
    emit(ChangeName());
    return nameChanged;
  }
}
