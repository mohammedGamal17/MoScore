import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final String name;
  final String email;
  final String image;
  final String uId;

  const Users({
    required this.name,
    required this.email,
    required this.image,
    required this.uId,
  });

  @override
  List<Object> get props => [name, email, image, uId];
}

class FixtureResponse extends Equatable {
  final Fixture fixture;
  final League league;
  final Teams teams;
  final Goals goals;
  final Score score;
  final List<Events> events;

  const FixtureResponse({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
    required this.events,
  });

  @override
  List<Object> get props => [fixture, league, teams, goals, score, events];
}

class Fixture extends Equatable {
  final int id;
  final String date;
  final int timestamp;
  final Venue venue;
  final Status status;
  final String? referee;

  const Fixture({
    required this.id,
    this.referee,
    required this.date,
    required this.timestamp,
    required this.venue,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        referee,
        date,
        timestamp,
        venue,
        status,
      ];
}

/// Venue = Stadium
class Venue extends Equatable {
  final int id;
  final String name;
  final String city;

  const Venue({
    required this.id,
    required this.name,
    required this.city,
  });

  @override
  List<Object> get props => [id, name, city];
}

class Status extends Equatable {
  final String long;
  final String short;
  final int elapsed;

  const Status({
    required this.long,
    required this.short,
    required this.elapsed,
  });

  @override
  List<Object> get props => [long, short, elapsed];
}

class League extends Equatable {
  final int id;
  final String name;
  final String country;
  final String logo;
  final String flag;
  final int season;
  final String round;

  const League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    required this.round,
  });

  @override
  List<Object> get props => [id, name, country, logo, flag, season, round];
}

class Teams extends Equatable {
  final Home home;
  final Away away;

  const Teams({
    required this.home,
    required this.away,
  });

  @override
  List<Object> get props => [home, away];
}

class Home extends Equatable {
  final int id;
  final String name;
  final String logo;
  final bool? winner;

  const Home({
    required this.id,
    required this.name,
    required this.logo,
    this.winner,
  });

  @override
  List<Object?> get props => [id, name, logo, winner];
}

class Away extends Equatable {
  final int id;
  final String name;
  final String logo;
  final bool? winner;

  const Away({
    required this.id,
    required this.name,
    required this.logo,
    this.winner,
  });

  @override
  List<Object?> get props => [id, name, logo, winner];
}

class Goals extends Equatable {
  final int home;
  final int away;

  const Goals({
    required this.home,
    required this.away,
  });

  @override
  List<Object> get props => [home, away];
}

class Score extends Equatable {
  final HalfTime halftime;
  final FullTime fullTime;
  final ExtraTime extraTime;
  final Penalty penalty;

  const Score({
    required this.halftime,
    required this.fullTime,
    required this.extraTime,
    required this.penalty,
  });

  @override
  List<Object> get props => [halftime, fullTime, extraTime, penalty];
}

class HalfTime extends Equatable {
  final int home;
  final int away;

  const HalfTime({
    required this.home,
    required this.away,
  });

  @override
  List<Object> get props => [home, away];
}

class FullTime extends Equatable {
  final int? home;
  final int ?away;

  const FullTime({
    required this.home,
    required this.away,
  });

  @override
  List<Object?> get props => [home, away];
}

class ExtraTime extends Equatable {
  final int? home;
  final int ?away;

  const ExtraTime({
    required this.home,
    required this.away,
  });

  @override
  List<Object?> get props => [home, away];
}

class Penalty extends Equatable {
  final int home;
  final int away;

  const Penalty({
    required this.home,
    required this.away,
  });

  @override
  List<Object?> get props => [home, away];
}

class Events extends Equatable {
  final Time time;
  final Team team;
  final Player player;
  final Assist assist;
  final String type;
  final String detail;
  final String? comments;

  const Events({
    required this.time,
    required this.team,
    required this.player,
    required this.assist,
    required this.type,
    required this.detail,
    this.comments,
  });

  @override
  List<Object?> get props => [
        time,
        team,
        player,
        assist,
        type,
        detail,
        comments,
      ];
}

class Time extends Equatable {
  final int elapsed;
  final int? extra;

  const Time({
    required this.elapsed,
    this.extra,
  });

  @override
  List<Object?> get props => [elapsed, extra];
}

class Team extends Equatable {
  final int id;
  final String name;
  final String logo;

  const Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  @override
  List<Object> get props => [id, name, logo];
}

class Player extends Equatable {
  final int? id;
  final String name;

  const Player({
    this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class Assist extends Equatable {
  final int? id;
  final String? name;

  const Assist({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
