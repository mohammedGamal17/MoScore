import '../../../domain/entities/entities.dart';
import '../fixture_response/fixture_response_model.dart';

class TeamInfoResponseModel extends TeamInfoResponse {
  const TeamInfoResponseModel({required super.teamInfo});

  factory TeamInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      TeamInfoResponseModel(
        teamInfo: TeamInfoModel.fromJson(json[]),
      );
}

class TeamInfoModel extends TeamInfo {
  const TeamInfoModel({
    required super.team,
    required super.venue,
  });

  factory TeamInfoModel.fromJson(Map<String, dynamic> json) =>
      TeamInfoModel(
        team: TeamModel.fromJson(json['team']),
        venue: VenueModel.fromJson(json['venue']),
      );
}

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
      fixtures: FixturesModel.fromJson(json['fixtures']),
      goals: ResponseGoalsModel.fromJson(json['goals']),
      cleanSheet: CleanSheetModel.fromJson(json['clean_sheet']),
      penalty: PenaltyStatisticsModel.fromJson(json['penalty']),
      cards: CardsModel.fromJson(json['cards']),
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

class ResponseGoalsModel extends ResponseGoals {
  const ResponseGoalsModel({
    required super.goalsFor,
    required super.against,
  });

  factory ResponseGoalsModel.fromJson(Map<String, dynamic> json) {
    return ResponseGoalsModel(
      goalsFor: GoalsStatisticsModel.fromJson(json['for']),
      against: GoalsStatisticsModel.fromJson(json['against']),
    );
  }
}

class GoalsStatisticsModel extends GoalsStatistics {
  const GoalsStatisticsModel({required super.total});

  factory GoalsStatisticsModel.fromJson(Map<String, dynamic> json) {
    return GoalsStatisticsModel(
      total: CleanSheetModel.fromJson(json['total']),
    );
  }
}

class PenaltyStatisticsModel extends PenaltyStatistics {
  const PenaltyStatisticsModel({
    required super.scored,
    required super.missed,
    required super.total,
  });

  factory PenaltyStatisticsModel.fromJson(Map<String, dynamic> json) {
    return PenaltyStatisticsModel(
      scored: ScoredOrMissedModel.fromJson(json['scored']),
      missed: ScoredOrMissedModel.fromJson(json['missed']),
      total: json['total'],
    );
  }
}

class ScoredOrMissedModel extends ScoredOrMissed {
  const ScoredOrMissedModel({
    required super.total,
    required super.percentage,
  });

  factory ScoredOrMissedModel.fromJson(Map<String, dynamic> json) {
    return ScoredOrMissedModel(
      total: json['total'],
      percentage: json['percentage'],
    );
  }
}

class CardsModel extends Cards {
  const CardsModel({
    required super.yellow,
    required super.red,
  });

  factory CardsModel.fromJson(Map<String, dynamic> json) {
    return CardsModel(
      yellow: Map.from(json['yellow']!).map(
        (k, v) => MapEntry<String, ScoredOrMissedModel>(
          k,
          ScoredOrMissedModel.fromJson(v),
        ),
      ),
      red: Map.from(json['red']!).map(
        (k, v) => MapEntry<String, ScoredOrMissedModel>(
          k,
          ScoredOrMissedModel.fromJson(v),
        ),
      ),
    );
  }
}
