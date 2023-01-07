

import '../../../../domain/entities/entities.dart';

abstract class LeaguesState {}

class LeaguesInitial extends LeaguesState {}

class GetLeaguesLoading extends LeaguesState {}

class GetLeaguesSuccess extends LeaguesState {
  final List<LeagueResponse> allLeagues;

  GetLeaguesSuccess({required this.allLeagues});
}

class GetLeaguesFail extends LeaguesState {
  final String message;

  GetLeaguesFail(this.message);
}

class LeaguesSearch extends LeaguesState {}

class LeaguesSearchEmpty extends LeaguesState {}

class DropDownYearChanged extends LeaguesState {}

class GetStandingLeagueLoading extends LeaguesState {}

class GetStandingLeagueSuccess extends LeaguesState {
  final List<LeagueStandingResponse> league;

  GetStandingLeagueSuccess({required this.league});
}

class GetStandingLeagueFail extends LeaguesState {
  final String message;

  GetStandingLeagueFail(this.message);
}