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

class GetTodayMatchesLoading extends FixtureState {}

class GetTodayMatchesSuccess extends FixtureState {
  final List<FixtureTodayResponse> fixtureToday;

  GetTodayMatchesSuccess({
    required this.fixtureToday,
  });
}

class GetTodayMatchesFail extends FixtureState {
  final List<FixtureTodayResponse> fixtureToday;

  final String message;

  GetTodayMatchesFail({
    required this.message,
    this.fixtureToday = const [],
  });
}

class GetStandingLeagueLoading extends FixtureState {}

class GetStandingLeagueSuccess extends FixtureState {
  final List<LeagueStandingResponse> league;

  GetStandingLeagueSuccess({required this.league});
}

class GetStandingLeagueFail extends FixtureState {
  final String message;

  GetStandingLeagueFail(this.message);
}
