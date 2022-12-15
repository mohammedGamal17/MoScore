abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetUserDataLoading extends ProfileState {}

class GetUserDataSuccess extends ProfileState {}

class GetUserDataFail extends ProfileState {
  final String message;

  GetUserDataFail(this.message);
}
