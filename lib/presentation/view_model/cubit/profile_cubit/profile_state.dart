abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetUserDataLoading extends ProfileState {}

class GetUserDataSuccess extends ProfileState {}

class GetUserDataFail extends ProfileState {
  final String message;

  GetUserDataFail(this.message);
}

class UpdateUserDataLoading extends ProfileState {}

class UpdateUserDataSuccess extends ProfileState {}

class UpdateUserDataFail extends ProfileState {
  final String message;

  UpdateUserDataFail(this.message);
}

class ImagePickedSuccess extends ProfileState {}

class ImagePickedFail extends ProfileState {}
