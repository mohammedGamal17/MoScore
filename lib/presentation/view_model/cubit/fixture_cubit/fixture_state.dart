import '../../../../domain/entities/entities.dart';

abstract class FixtureState {}

class FixtureInitial extends FixtureState {}

class GetLiveFixtureLoading extends FixtureState {}

class GetLiveFixtureSuccess extends FixtureState {
  final List<FixtureResponse> result;

  GetLiveFixtureSuccess({
    required this.result,
  });
}

class GetLiveFixtureFail extends FixtureState {
  final List<FixtureResponse> result;

  final String message;

  GetLiveFixtureFail({
    required this.message,
    this.result = const [],
  });
}
