import '../../../domain/entities/entities.dart';
import '../../../presentation/resources/string/string_manager.dart';

class FixtureResponseModel extends FixtureResponse {
  const FixtureResponseModel({
    required super.fixture,
    required super.league,
    required super.teams,
    required super.goals,
    required super.score,
    required super.events,
    required super.lineups,
    required super.statistics,
    required super.players,
  });

  factory FixtureResponseModel.fromJson(Map<String, dynamic> json) {
    return FixtureResponseModel(
      fixture: FixtureModel.fromJson(json['fixture']),
      league: LeagueModel.fromJson(json['league']),
      teams: TeamsModel.fromJson(json['teams']),
      goals: GoalsModel.fromJson(json['goals']),
      score: ScoreModel.fromJson(json['score']),
      events: List.from(json['events'])
          .map((e) => EventsModel.fromJson(e))
          .toList(),
      lineups: List.from(json['lineups'])
          .map((e) => LineupsModel.fromJson(e))
          .toList(),
      statistics: List.from(json['statistics'])
          .map((e) => StatisticsModel.fromJson(e))
          .toList(),
      players: List.from(json['players'])
          .map((e) => PlayersModel.fromJson(e))
          .toList(),
    );
  }
}

class FixtureLiveResponseModel extends FixtureLiveResponse {
  const FixtureLiveResponseModel({
    required super.fixture,
    required super.league,
    required super.teams,
    required super.goals,
    required super.score,
    required super.events,
  });

  factory FixtureLiveResponseModel.fromJson(Map<String, dynamic> json) {
    return FixtureLiveResponseModel(
      fixture: FixtureModel.fromJson(json['fixture']),
      league: LeagueModel.fromJson(json['league']),
      teams: TeamsModel.fromJson(json['teams']),
      goals: GoalsModel.fromJson(json['goals']),
      score: ScoreModel.fromJson(json['score']),
      events: List.from(json['events'])
          .map((e) => EventsModel.fromJson(e))
          .toList(),
    );
  }
}

class FixtureTodayResponseModel extends FixtureTodayResponse {
  const FixtureTodayResponseModel({
    required super.fixture,
    required super.league,
    required super.teams,
    required super.goals,
    required super.score,
  });

  factory FixtureTodayResponseModel.fromJson(Map<String, dynamic> json) {
    return FixtureTodayResponseModel(
      fixture: FixtureModel.fromJson(json['fixture']),
      league: LeagueModel.fromJson(json['league']),
      teams: TeamsModel.fromJson(json['teams']),
      goals: GoalsModel.fromJson(json['goals']),
      score: ScoreModel.fromJson(json['score']),
    );
  }
}

class FixtureModel extends Fixture {
  const FixtureModel({
    required super.id,
    required super.date,
    required super.timestamp,
    required super.venue,
    required super.status,
    required super.referee,
  });

  factory FixtureModel.fromJson(Map<String, dynamic> json) {
    return FixtureModel(
      id: json['id'],
      date: json['date'],
      timestamp: json['timestamp'],
      venue: VenueModel.fromJson(json['venue']),
      status: StatusModel.fromJson(json['status']),
      referee: json['referee'] ?? StringManager.unKnown,
    );
  }
}

class VenueModel extends Venue {
  const VenueModel({
    required super.id,
    required super.name,
    required super.city,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'] ?? -10,
      name: json['name'] ?? StringManager.unKnown,
      city: json['city'] ?? StringManager.unKnown,
    );
  }
}

class StatusModel extends Status {
  const StatusModel({
    required super.long,
    required super.short,
    required super.elapsed,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      long: json['long'],
      short: json['short'],
      elapsed: json['elapsed'] ?? 0,
    );
  }
}

class LeagueModel extends League {
  const LeagueModel({
    required super.id,
    required super.name,
    required super.country,
    required super.logo,
    required super.flag,
    required super.season,
    required super.round,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      id: json['id'] ?? -20,
      name: json['name'],
      country: json['country'] ?? StringManager.unKnown,
      logo: json['logo'] ?? StringManager.unKnown,
      flag: json['flag'] ?? StringManager.unKnown,
      season: json['season'] ?? -1900,
      round: json['round'] ?? StringManager.unKnown,
    );
  }
}

class TeamsModel extends Teams {
  const TeamsModel({
    required super.home,
    required super.away,
  });

  factory TeamsModel.fromJson(Map<String, dynamic> json) {
    return TeamsModel(
      home: HomeModel.fromJson(json['home']),
      away: AwayModel.fromJson(json['away']),
    );
  }
}

class HomeModel extends Home {
  const HomeModel({
    required super.id,
    required super.name,
    required super.logo,
    super.winner,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'] ?? -30,
      name: json['name'],
      logo: json['logo'],
    );
  }
}

class AwayModel extends Away {
  const AwayModel({
    required super.id,
    required super.name,
    required super.logo,
    super.winner,
  });

  factory AwayModel.fromJson(Map<String, dynamic> json) {
    return AwayModel(
      id: json['id'] ?? -40,
      name: json['name'],
      logo: json['logo'],
    );
  }
}

class GoalsModel extends Goals {
  const GoalsModel({
    required super.home,
    required super.away,
  });

  factory GoalsModel.fromJson(Map<String, dynamic> json) {
    return GoalsModel(
      home: json['home'] ?? 0,
      away: json['away'] ?? 0,
    );
  }
}

class ScoreModel extends Score {
  const ScoreModel({
    required super.halftime,
    required super.fullTime,
    required super.extraTime,
    required super.penalty,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    return ScoreModel(
      halftime: HalfTimeModel.fromJson(json['halftime']),
      fullTime: FullTimeModel.fromJson(json['fulltime']),
      extraTime: ExtraTimeModel.fromJson(json['extratime']),
      penalty: PenaltyModel.fromJson(json['penalty']),
    );
  }
}

class HalfTimeModel extends HalfTime {
  const HalfTimeModel({
    required super.home,
    required super.away,
  });

  factory HalfTimeModel.fromJson(Map<String, dynamic> json) {
    return HalfTimeModel(
      home: json['home'] ?? 0,
      away: json['away'] ?? 0,
    );
  }
}

class FullTimeModel extends FullTime {
  const FullTimeModel({
    required super.home,
    required super.away,
  });

  factory FullTimeModel.fromJson(Map<String, dynamic> json) {
    return FullTimeModel(
      home: json['home'] ?? 0,
      away: json['away'] ?? 0,
    );
  }
}

class ExtraTimeModel extends ExtraTime {
  const ExtraTimeModel({
    required super.home,
    required super.away,
  });

  factory ExtraTimeModel.fromJson(Map<String, dynamic> json) {
    return ExtraTimeModel(
      home: json['home'] ?? 0,
      away: json['away'] ?? 0,
    );
  }
}

class PenaltyModel extends Penalty {
  const PenaltyModel({
    required super.home,
    required super.away,
  });

  factory PenaltyModel.fromJson(Map<String, dynamic> json) {
    return PenaltyModel(
      home: json['home'] ?? 0,
      away: json['away'] ?? 0,
    );
  }
}

class EventsModel extends Events {
  const EventsModel({
    required super.time,
    required super.team,
    required super.player,
    required super.assist,
    required super.type,
    required super.detail,
    required super.comments,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      time: TimeModel.fromJson(json['time']),
      team: TeamModel.fromJson(json['team']),
      player: PlayerModel.fromJson(json['player']),
      assist: AssistModel.fromJson(json['assist']),
      type: json['type'],
      detail: json['detail'],
      comments: json['comments'] ?? '',
    );
  }
}

class TimeModel extends Time {
  const TimeModel({
    required super.elapsed,
    required super.extra,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      elapsed: json['elapsed'],
      extra: json['extra'] ?? 0,
    );
  }
}

class TeamModel extends Team {
  const TeamModel({
    required super.id,
    required super.name,
    required super.logo,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] ?? -50,
      name: json['name'],
      logo: json['logo'] ?? '',
    );
  }
}

class PlayerModel extends Player {
  const PlayerModel({
    super.id,
    required super.name,
    super.number,
    super.pos,
    super.grid,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'] ?? -60,
      name: json['name'] ?? StringManager.unKnown,
      number: json['number'] ?? 0,
      pos: json['pos'] ?? '',
      grid: json['grid'] ?? '',
    );
  }
}

class AssistModel extends Assist {
  const AssistModel({
    required super.id,
    required super.name,
  });

  factory AssistModel.fromJson(Map<String, dynamic> json) {
    return AssistModel(
      id: json['id'] ?? -70,
      name: json['name'] ?? '',
    );
  }
}

class LineupsModel extends Lineups {
  const LineupsModel({
    required super.team,
    required super.coach,
    required super.formation,
    required super.startXI,
    required super.substitutes,
  });

  factory LineupsModel.fromJson(Map<String, dynamic> json) {
    return LineupsModel(
      team: TeamModel.fromJson(json['team']),
      coach: CoachModel.fromJson(json['coach']),
      formation: json['formation'],
      startXI: List.from(json['startXI'])
          .map((e) => StartXIModel.fromJson(e))
          .toList(),
      substitutes: List.from(json['substitutes'])
          .map((e) => SubstitutesModel.fromJson(e))
          .toList(),
    );
  }
}

class CoachModel extends Coach {
  const CoachModel({
    required super.id,
    required super.name,
    required super.photo,
  });

  factory CoachModel.fromJson(Map<String, dynamic> json) {
    return CoachModel(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
    );
  }
}

class StartXIModel extends StartXI {
  const StartXIModel({
    required super.player,
  });

  factory StartXIModel.fromJson(Map<String, dynamic> json) {
    return StartXIModel(
      player: PlayerModel.fromJson(json['player']),
    );
  }
}

class SubstitutesModel extends Substitutes {
  const SubstitutesModel({
    required super.player,
  });

  factory SubstitutesModel.fromJson(Map<String, dynamic> json) {
    return SubstitutesModel(
      player: PlayerModel.fromJson(json['player']),
    );
  }
}

class StatisticsModel extends Statistics {
  const StatisticsModel({
    required super.team,
    required super.statistics,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      team: TeamModel.fromJson(json['team']),
      statistics: List.from(json['statistics'])
          .map((e) => StatisticssModel.fromJson(e))
          .toList(),
    );
  }
}

class StatisticssModel extends Statisticss {
  const StatisticssModel({
    required super.type,
    required super.value,
  });

  factory StatisticssModel.fromJson(Map<String, dynamic> json) {
    return StatisticssModel(
      type: json['type'],
      value: json['value'] ?? 0,
    );
  }
}

class PlayersModel extends Players {
  const PlayersModel({
    required super.team,
    required super.playerss,
  });

  factory PlayersModel.fromJson(Map<String, dynamic> json) {
    return PlayersModel(
      team: TeamModel.fromJson(json['team']),
      playerss: List.from(json['players'])
          .map((e) => PlayerssModel.fromJson(e))
          .toList(),
    );
  }
}

class PlayerssModel extends Playerss {
  const PlayerssModel({
    required super.player,
  });

  factory PlayerssModel.fromJson(Map<String, dynamic> json) {
    return PlayerssModel(
      player: PlayerModel.fromJson(json['player']),
    );
  }
}
