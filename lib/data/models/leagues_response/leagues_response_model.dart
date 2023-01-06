import '../../../domain/entities/entities.dart';
import '../../../presentation/resources/string/string_manager.dart';
import '../fixture_response/fixture_response_model.dart';

class LeagueResponseModel extends LeagueResponse {
  const LeagueResponseModel({
    required super.league,
    required super.country,
    required super.seasons,
  });

  factory LeagueResponseModel.fromJson(Map<String, dynamic> json) {
    return LeagueResponseModel(
      league: LeagueModel.fromJson(json['league']),
      country: CountryModel.fromJson(json['country']),
      seasons: List.from(json['seasons'])
          .map((e) => SeasonsModel.fromJson(e))
          .toList(),
    );
  }
}

class LeagueStandingModel extends LeagueStanding {
  const LeagueStandingModel({
    required super.id,
    required super.name,
    required super.country,
    required super.logo,
    required super.flag,
    required super.season,
    required super.round,
    // required super.standings,
  });

  factory LeagueStandingModel.fromJson(Map<String, dynamic> json) {
    return LeagueStandingModel(
      id: json['id'] ?? -20,
      name: json['name'] ?? '',
      country: json['country'] ?? StringManager.unKnown,
      logo: json['logo'] ?? StringManager.unKnown,
      flag: json['flag'] ?? StringManager.unKnown,
      season: json['season'] ?? -1900,
      round: json['round'] ?? StringManager.unKnown,
      // standings: List.from(json['standings'][0])
      //     .map((e) => StandingModel.fromJson(e))
      //     .toList(),
    );
  }
}

///
/// (json["standings"] as List).map((i) => StandingModel.fromJson(i)).toList(),
///

// NESTED LOOP BECAUSE TO LIST<LIST<StandingModel>>
// List.from(json['seasons'])
// .map(
//    (e) => List.from(e)
//      .map(
//        (i) => StandingModel.fromJson(i)
//          )
//          .toList()
//      )
// .toList(),

class CountryModel extends Country {
  const CountryModel({
    required super.name,
    required super.flag,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'],
      flag: json['flag'] ?? '',
    );
  }
}

class SeasonsModel extends Seasons {
  const SeasonsModel({
    required super.year,
    required super.start,
    required super.end,
    required super.current,
  });

  factory SeasonsModel.fromJson(Map<String, dynamic> json) {
    return SeasonsModel(
      year: json['year'],
      start: json['start'],
      end: json['end'],
      current: json['current'],
    );
  }
}

class StandingModel extends Standing {
  const StandingModel({
    required super.rank,
    required super.team,
    required super.all,
    required super.description,
    required super.points,
    required super.goalsDiff,
    required super.group,
  });

  factory StandingModel.fromJson(Map<String, dynamic> json) {
    return StandingModel(
      rank: json['rank'],
      team: TeamModel.fromJson(json['team']),
      all: AllModel.fromJson(json['all']),
      description: json['description'],
      points: json['points'],
      goalsDiff: json['goalsDiff'],
      group: json['group'],
    );
  }
}

class AllModel extends All {
  const AllModel({
    required super.draw,
    required super.goals,
    required super.lose,
    required super.played,
    required super.win,
  });

  factory AllModel.fromJson(Map<String, dynamic> json) {
    return AllModel(
      played: json['played'],
      win: json['win'],
      draw: json['draw'],
      lose: json['lose'],
      goals: GoalsForStandingModel.fromJson(json['goals']),
    );
  }
}

class GoalsForStandingModel extends GoalsForStanding {
  const GoalsForStandingModel({
    required super.against,
    required super.forTeam,
  });

  factory GoalsForStandingModel.fromJson(Map<String, dynamic> json) {
    return GoalsForStandingModel(
      against: json['against'],
      forTeam: json['for'],
    );
  }
}
