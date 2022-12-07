abstract class AuthState {}

class AuthInitial extends AuthState {}

class PasswordVisibility extends AuthState {}

class CreateUserLoading extends AuthState {}

class CreateUserSuccess extends AuthState {}

class CreateUserFail extends AuthState {
  final String message;

  CreateUserFail(this.message);
}

class UserRegisterLoading extends AuthState {}

class UserRegisterSuccess extends AuthState {}

class UserRegisterFail extends AuthState {
  final String message;

  UserRegisterFail(this.message);
}

class UserLoginLoading extends AuthState {}

class UserLoginSuccess extends AuthState {}

class UserLoginFail extends AuthState {
  final String message;

  UserLoginFail(this.message);
}
