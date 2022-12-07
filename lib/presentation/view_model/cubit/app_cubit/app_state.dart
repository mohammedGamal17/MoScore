abstract class AppState {}

class AppInitial extends AppState {}

class GetUserDataLoading extends AppState {}

class GetUserDataSuccess extends AppState {}

class GetUserDataFail extends AppState {
  final String message;

  GetUserDataFail(this.message);
}
