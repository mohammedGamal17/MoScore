import '../../domain/entities/entities.dart';
import 'fixture_response/fixture_response_model.dart';

class TeamStatisticsModel extends TeamStatistics {
  const TeamStatisticsModel({
    required super.league,
    required super.team,
    required super.form,
    required super.fixtures,
    required super.goals,
    required super.cleanSheet,
    required super.penalty,
    required super.cards,
  });

  factory TeamStatisticsModel.fromJson(Map<String, dynamic> json) {
    return TeamStatisticsModel(
      league: LeagueModel.fromJson(json['league']),
      team: TeamModel.fromJson(json['team']),
      form: json['form'],
      fixtures: fixtures,
      goals: goals,
      cleanSheet: cleanSheet,
      penalty: penalty,
      cards: cards,
    );
  }
}

class FixturesModel extends Fixtures {
  const FixturesModel({
    required super.played,
    required super.wins,
    required super.draws,
    required super.loses,
  });

  factory FixturesModel.fromJson(Map<String, dynamic> json) {
    return FixturesModel(
      played: CleanSheetModel.fromJson(json['played']),
      wins: CleanSheetModel.fromJson(json['wins']),
      draws: CleanSheetModel.fromJson(json['draws']),
      loses: CleanSheetModel.fromJson(json['loses']),
    );
  }
}

class CleanSheetModel extends CleanSheet {
  const CleanSheetModel({
    required super.home,
    required super.away,
    required super.total,
  });

  factory CleanSheetModel.fromJson(Map<String, dynamic> json) {
    return CleanSheetModel(
      home: json['home'],
      away: json['away'],
      total: json['total'],
    );
  }
}
