abstract class AuthState {}

class AuthInitial extends AuthState {}

class PasswordVisibility extends AuthState {}

class CreateUserLoading extends AuthState {}

class CreateUserSuccess extends AuthState {}

class CreateUserFail extends AuthState {
  final String message;

  CreateUserFail(this.message);
}
