import 'package:equatable/equatable.dart';

class PlayerInfo extends Equatable {
  const PlayerInfo({
    required this.player,
    required this.statistics,
  });

  final Player player;
  final List<Statistic?>? statistics;

  @override
  List<Object?> get props => [player, statistics];
}

class Player extends Equatable {
  const Player({
    required this.id,
    required this.name,
    required this.firstname,
    required this.lastname,
    required this.age,
    required this.birth,
    required this.nationality,
    required this.height,
    required this.weight,
    required this.injured,
    required this.photo,
  });

  final int? id;
  final String? name;
  final String? firstname;
  final String? lastname;
  final int? age;
  final Birth? birth;
  final String? nationality;
  final String? height;
  final String? weight;
  final bool? injured;
  final String? photo;

  @override
  List<Object?> get props => [
        id,
        name,
        firstname,
        lastname,
        age,
        birth,
        nationality,
        height,
        weight,
        injured,
        photo,
      ];
}

class Birth extends Equatable {
  const Birth({
    required this.date,
    required this.place,
    required this.country,
  });

  final DateTime? date;
  final String? place;
  final String? country;

  @override
  List<Object?> get props => [date, place, country];
}

class Statistic extends Equatable {
  const Statistic({
    required this.team,
    required this.league,
    required this.games,
    required this.substitutes,
    required this.shots,
    required this.goals,
    required this.passes,
    required this.tackles,
    required this.duels,
    required this.dribbles,
    required this.fouls,
    required this.cards,
    required this.penalty,
  });

  final Team? team;
  final League? league;
  final Games? games;
  final Substitutes? substitutes;
  final Shots? shots;
  final Goals? goals;
  final Passes? passes;
  final Tackles? tackles;
  final Duels? duels;
  final Dribbles? dribbles;
  final Fouls? fouls;
  final Cards? cards;
  final Penalty? penalty;

  @override
  List<Object?> get props => [
        team,
        league,
        games,
        substitutes,
        shots,
        goals,
        passes,
        tackles,
        duels,
        dribbles,
        fouls,
        cards,
        penalty,
      ];
}

class Cards extends Equatable {
  const Cards({
    required this.yellow,
    required this.yellowRed,
    required this.red,
  });

  final int? yellow;
  final int? yellowRed;
  final int? red;

  @override
  List<Object?> get props => [yellow, yellowRed, red];

}

class Dribbles extends Equatable {
  const Dribbles({
    required this.attempts,
    required this.success,
    required this.past,
  });

  final int? attempts;
  final int? success;
  final int? past;

  @override
  List<Object?> get props => [attempts, success, past];

}

class Duels extends Equatable {
  const Duels({
    required this.total,
    required this.won,
  });

  final int? total;
  final int? won;

  @override
  List<Object?> get props => [total, won];


}

class Fouls extends Equatable {
  const Fouls({
    required this.drawn,
    required this.committed,
  });

  final int? drawn;
  final int? committed;

  @override
  List<Object?> get props => [drawn, committed];

}

class Games extends Equatable {
  const Games({
    required this.appearances,
    required this.lineups,
    required this.minutes,
    required this.number,
    required this.position,
    required this.rating,
    required this.captain,
  });

  final int? appearances;
  final int? lineups;
  final int? minutes;
  final int? number;
  final String? position;
  final String? rating;
  final bool? captain;

  @override
  List<Object?> get props => [
        appearances,
        lineups,
        minutes,
        number,
        position,
        rating,
        captain,
      ];


}

class Goals extends Equatable {
  const Goals({
    required this.total,
    required this.conceded,
    required this.assists,
    required this.saves,
  });

  final int? total;
  final int? conceded;
  final int? assists;
  final int? saves;

  @override
  List<Object?> get props => [total, conceded, assists, saves];

}

class League extends Equatable {
  const League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
  });

  final int? id;
  final String? name;
  final String? country;
  final String? logo;
  final String? flag;
  final dynamic season;

  @override
  List<Object?> get props => [id, name, country, logo, flag, season];

}

class Passes extends Equatable {
  const Passes({
    required this.total,
    required this.key,
    required this.accuracy,
  });

  final int? total;
  final int? key;
  final int? accuracy;

  @override
  List<Object?> get props => [total, key, accuracy];

}

class Penalty extends Equatable {
  const Penalty({
    required this.won,
    required this.committed,
    required this.scored,
    required this.missed,
    required this.saved,
  });

  final int? won;
  final int? committed;
  final int? scored;
  final int? missed;
  final int? saved;

  @override
  List<Object?> get props => [won, committed, scored, missed, saved];


}

class Shots extends Equatable {
  const Shots({
    required this.total,
    required this.on,
  });

  final int? total;
  final int? on;

  @override
  List<Object?> get props => [total];

}

class Substitutes extends Equatable {
  const Substitutes({
    required this.substitutesIn,
    required this.out,
    required this.bench,
  });

  final int? substitutesIn;
  final int? out;
  final int? bench;

  @override
  List<Object?> get props => [substitutesIn, out, bench];


}

class Tackles extends Equatable {
  const Tackles({
    required this.total,
    required this.blocks,
    required this.interceptions,
  });

  final int? total;
  final int? blocks;
  final int? interceptions;



  @override
  List<Object?> get props => [total, blocks, interceptions];
}

class Team extends Equatable {
  const Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  final int? id;
  final String? name;
  final String? logo;

  @override
  List<Object?> get props => [id, name, logo];

}
