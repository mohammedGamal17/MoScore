import '../../../domain/entities/player_entities.dart';
import '../../../presentation/resources/assets/assets.dart';

class PlayerInfoModel extends PlayerInfo {
  const PlayerInfoModel({
    required super.player,
    required super.statistics,
  });

  factory PlayerInfoModel.fromJson(Map<String, dynamic> json) =>
      PlayerInfoModel(
        player: PlayerModel.fromJson(json['player']),
        statistics: json['statistics'] == null
            ? []
            : List<Statistic?>.from(
                json['statistics']!.map(
                  (x) => StatisticModel.fromJson(x),
                ),
              ),
      );
}

class PlayerModel extends Player {
  const PlayerModel({
    required super.id,
    required super.name,
    required super.firstname,
    required super.lastname,
    required super.age,
    required super.birth,
    required super.nationality,
    required super.height,
    required super.weight,
    required super.injured,
    required super.photo,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        id: json['id'],
        name: json['name'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        age: json['age'],
        birth: BirthModel.fromJson(json['birth']),
        nationality: json['nationality'],
        height: json['height'],
        weight: json['weight'],
        injured: json['injured'],
        photo: json['photo'],
      );
}

class BirthModel extends Birth {
  const BirthModel({
    required super.date,
    required super.place,
    required super.country,
  });

  factory BirthModel.fromJson(Map<String, dynamic> json) => BirthModel(
        date: DateTime.parse(json['date']),
        place: json['place'],
        country: json['country'],
      );
}

class StatisticModel extends Statistic {
  const StatisticModel({
    required super.team,
    required super.league,
    required super.games,
    required super.substitutes,
    required super.shots,
    required super.goals,
    required super.passes,
    required super.tackles,
    required super.duels,
    required super.dribbles,
    required super.fouls,
    required super.cards,
    required super.penalty,
  });

  factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
        team: TeamModel.fromJson(json['team']),
        league: LeagueModel.fromJson(json['league']),
        games: GamesModel.fromJson(json['games']),
        substitutes: SubstitutesModel.fromJson(json['substitutes']),
        shots: ShotsModel.fromJson(json['shots']),
        goals: GoalsModel.fromJson(json['goals']),
        passes: PassesModel.fromJson(json['passes']),
        tackles: TacklesModel.fromJson(json['tackles']),
        duels: DuelsModel.fromJson(json['duels']),
        dribbles: DribblesModel.fromJson(json['dribbles']),
        fouls: FoulsModel.fromJson(json['fouls']),
        cards: CardsModel.fromJson(json['cards']),
        penalty: PenaltyModel.fromJson(json['penalty']),
      );
}

class CardsModel extends Cards {
  const CardsModel({
    required super.yellow,
    required super.yellowRed,
    required super.red,
  });

  factory CardsModel.fromJson(Map<String, dynamic> json) => CardsModel(
        yellow: json['yellow']?? 0,
        yellowRed: json['yellowred']?? 0,
        red: json['red']?? 0,
      );
}

class DribblesModel extends Dribbles {
  const DribblesModel({
    required super.attempts,
    required super.success,
    required super.past,
  });

  factory DribblesModel.fromJson(Map<String, dynamic> json) => DribblesModel(
        attempts: json['attempts']?? 0,
        success: json['success']?? 0,
        past: json['past']?? 0,
      );
}

class DuelsModel extends Duels {
  const DuelsModel({
    required super.total,
    required super.won,
  });

  factory DuelsModel.fromJson(Map<String, dynamic> json) => DuelsModel(
        total: json['total'] ?? 0,
        won: json['won']?? 0,
      );
}

class FoulsModel extends Fouls {
  const FoulsModel({
    required super.drawn,
    required super.committed,
  });

  factory FoulsModel.fromJson(Map<String, dynamic> json) => FoulsModel(
        drawn: json['drawn']?? 0,
        committed: json['committed']?? 0,
      );
}

class GamesModel extends Games {
  const GamesModel({
    required super.appearances,
    required super.lineups,
    required super.minutes,
    required super.number,
    required super.position,
    required super.rating,
    required super.captain,
  });

  factory GamesModel.fromJson(Map<String, dynamic> json) => GamesModel(
        appearances: json['appearences'],
        lineups: json['lineups'],
        minutes: json['minutes'],
        number: json['number'],
        position: json['position'],
        rating: json['rating'],
        captain: json['captain'],
      );
}

class GoalsModel extends Goals {
  const GoalsModel({
    required super.total,
    required super.conceded,
    required super.assists,
    required super.saves,
  });

  factory GoalsModel.fromJson(Map<String, dynamic> json) => GoalsModel(
        total: json['total'] ?? 0,
        conceded: json['conceded'] ?? 0,
        assists: json['assists'] ?? 0,
        saves: json['saves'] ?? 0,
      );
}

class LeagueModel extends League {
  const LeagueModel({
    required super.id,
    required super.name,
    required super.country,
    required super.logo,
    required super.flag,
    required super.season,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
        id: json['id'],
        name: json['name'],
        country: json['country'] ?? '',
        logo: json['logo'] ?? AssetsResources.logoURL,
        flag: json['flag'],
        season: json['season'],
      );
}

class PassesModel extends Passes {
  const PassesModel({
    required super.total,
    required super.key,
    required super.accuracy,
  });

  factory PassesModel.fromJson(Map<String, dynamic> json) => PassesModel(
        total: json['total'] ?? 0,
        key: json['key'] ?? 0,
        accuracy: json['accuracy'] ??0,
      );
}

class PenaltyModel extends Penalty {
  const PenaltyModel({
    required super.won,
    required super.committed,
    required super.scored,
    required super.missed,
    required super.saved,
  });

  factory PenaltyModel.fromJson(Map<String, dynamic> json) => PenaltyModel(
        won: json['won'] ?? 0,
        committed: json['commited']?? 0,
        scored: json['scored']?? 0,
        missed: json['missed']?? 0,
        saved: json['saved']?? 0,
      );
}

class ShotsModel extends Shots {
  const ShotsModel({
    required super.total,
    required super.on,
  });

  factory ShotsModel.fromJson(Map<String, dynamic> json) => ShotsModel(
        total: json['total']?? 0,
        on: json['on']?? 0,
      );
}

class SubstitutesModel extends Substitutes {
  const SubstitutesModel({
    required super.substitutesIn,
    required super.out,
    required super.bench,
  });

  factory SubstitutesModel.fromJson(Map<String, dynamic> json) =>
      SubstitutesModel(
        substitutesIn: json['in']?? 0,
        out: json['out']?? 0,
        bench: json['bench']?? 0,
      );
}

class TacklesModel extends Tackles {
  const TacklesModel({
    required super.total,
    required super.blocks,
    required super.interceptions,
  });

  factory TacklesModel.fromJson(Map<String, dynamic> json) => TacklesModel(
        total: json['total']?? 0,
        blocks: json['blocks']?? 0,
        interceptions: json['interceptions']?? 0,
      );
}

class TeamModel extends Team {
  const TeamModel({
    required super.id,
    required super.name,
    required super.logo,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
    id: json['id'],
    name: json['name'],
    logo: json['logo'],
  );
}
