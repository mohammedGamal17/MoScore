import '../../../../domain/entities/entities.dart';

abstract class FixtureState {}

class FixtureInitial extends FixtureState {}

class GetLiveFixtureLoading extends FixtureState {}

class GetLiveFixtureSuccess extends FixtureState {
  final List<FixtureLiveResponse> liveFixture;

  GetLiveFixtureSuccess({
    required this.liveFixture,
  });
}

class GetLiveFixtureFail extends FixtureState {
  final List<FixtureLiveResponse> liveFixture;

  final String message;

  GetLiveFixtureFail({
    required this.message,
    this.liveFixture = const [],
  });
}

class GetFixtureByIdLoading extends FixtureState {}

class GetFixtureByIdSuccess extends FixtureState {
  final List<FixtureResponse> liveFixture;

  GetFixtureByIdSuccess({
    required this.liveFixture,
  });
}

class GetFixtureByIdFail extends FixtureState {
  final List<FixtureResponse> liveFixture;

  final String message;

  GetFixtureByIdFail({
    required this.message,
    this.liveFixture = const [],
  });
}