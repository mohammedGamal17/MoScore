abstract class AuthState {}

class AuthInitial extends AuthState {}

class PasswordVisibility extends AuthState {}

class CreateUserLoading extends AuthState {}

class CreateUserSuccess extends AuthState {}

class CreateUserFail extends AuthState {
  final String message;

  CreateUserFail(this.message);
}

class SignInAnonymouslyLoading extends AuthState {}

class SignInAnonymouslySuccess extends AuthState {}

class SignInAnonymouslyFail extends AuthState {
  final String message;

  SignInAnonymouslyFail(this.message);
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

class SignInWithGoogleLoading extends AuthState {}

class SignInWithGoogleSuccess extends AuthState {}

class SignInWithGoogleFail extends AuthState {
  final String message;

  SignInWithGoogleFail(this.message);
}

class SignInWithFaceBookLoading extends AuthState {}

class SignInWithFaceBookSuccess extends AuthState {}

class SignInWithFaceBookFail extends AuthState {
  final String message;

  SignInWithFaceBookFail(this.message);
}

class SignOutLoading extends AuthState {}

class SignOutSuccess extends AuthState {}

class SignOutFail extends AuthState {
  final String message;

  SignOutFail(this.message);
}
