import '../../../domain/entities/entities.dart';
import '../fixture_response/fixture_response_model.dart';

class LeagueStandingResponseModel extends LeagueStandingResponse {
  const LeagueStandingResponseModel({required super.league});

  factory LeagueStandingResponseModel.fromJson(Map<String, dynamic> json) =>
      LeagueStandingResponseModel(
        league: LeagueStandingModel.fromJson(json['league']),
      );
}

class LeagueStandingModel extends LeagueStanding {
  const LeagueStandingModel({
    required super.id,
    required super.name,
    required super.country,
    required super.logo,
    required super.flag,
    required super.season,
    required super.standings,
  });

  factory LeagueStandingModel.fromJson(Map<String, dynamic> json) =>
      LeagueStandingModel(
        id: json['id'],
        name: json['name'],
        country: json['country'],
        logo: json['logo'],
        flag: json['flag'],
        season: json['season'],
        standings: json['standings'] == null
            ? []
            : List<List<Standing?>?>.from(
                json['standings']!.map(
                  (x) => x == null
                      ? []
                      : List<Standing?>.from(
                          x!.map(
                            (x) => StandingModel.fromJson(x),
                          ),
                        ),
                ),
              ),
      );
}

class StandingModel extends Standing {
  const StandingModel({
    required super.rank,
    required super.team,
    required super.points,
    required super.goalsDiff,
    required super.group,
    required super.all,
  });

  factory StandingModel.fromJson(Map<String, dynamic> json) => StandingModel(
        rank: json['rank'],
        team: TeamModel.fromJson(json['team']),
        points: json['points'],
        goalsDiff: json['goalsDiff'],
        group: json['group'],
        all: AllModel.fromJson(json['all']),
      );
}

class AllModel extends All {
  const AllModel({
    required super.played,
    required super.win,
    required super.draw,
    required super.lose,
    required super.goals,
  });

  factory AllModel.fromJson(Map<String, dynamic> json) => AllModel(
        played: json['played'],
        win: json['win'],
        draw: json['draw'],
        lose: json['lose'],
        goals: GoalsForStandingModel.fromJson(json['goals']),
      );
}

class GoalsForStandingModel extends GoalsForStanding {
  const GoalsForStandingModel({
    required super.goalsFor,
    required super.against,
  });

  factory GoalsForStandingModel.fromJson(Map<String, dynamic> json) =>
      GoalsForStandingModel(
        goalsFor: json['for'],
        against: json['against'],
      );
}
