
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
  final List<Lineups> lineups;
  final List<Statistics> statistics;
  final List<Players> players;

  const FixtureResponse({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
    required this.events,
    required this.lineups,
    required this.statistics,
    required this.players,
  });

  @override
  List<Object?> get props => [
        fixture,
        league,
        teams,
        goals,
        score,
        events,
        lineups,
        statistics,
        players,
      ];
}

class FixtureLiveResponse extends Equatable {
  final Fixture fixture;
  final League league;
  final Teams teams;
  final Goals goals;
  final Score score;
  final List<Events> events;

  const FixtureLiveResponse({
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

class FixtureTodayResponse extends Equatable {
  final Fixture fixture;
  final League league;
  final Teams teams;
  final Goals goals;
  final Score score;

  const FixtureTodayResponse({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
  });

  @override
  List<Object> get props => [fixture, league, teams, goals, score];
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
  final int? away;

  const FullTime({
    required this.home,
    required this.away,
  });

  @override
  List<Object?> get props => [home, away];
}

class ExtraTime extends Equatable {
  final int? home;
  final int? away;

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
  final int? number;
  final String? pos;
  final String? grid;

  const Player({
    this.id,
    required this.name,
    this.number,
    this.pos,
    this.grid,
  });

  @override
  List<Object?> get props => [id, name, number, pos];
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

class Lineups extends Equatable {
  final Team team;
  final Coach coach;
  final String formation;
  final List<StartXI> startXI;
  final List<Substitutes> substitutes;

  const Lineups({
    required this.team,
    required this.coach,
    required this.formation,
    required this.startXI,
    required this.substitutes,
  });

  @override
  List<Object> get props => [team, coach, formation, startXI, substitutes];
}

class Coach extends Equatable {
  final int id;
  final String name;
  final String photo;

  const Coach({
    required this.id,
    required this.name,
    required this.photo,
  });

  @override
  List<Object> get props => [id, name, photo];
}

class StartXI extends Equatable {
  final Player player;

  const StartXI({
    required this.player,
  });

  @override
  List<Object> get props => [player];
}

class Substitutes extends Equatable {
  final Player player;

  const Substitutes({
    required this.player,
  });

  @override
  List<Object> get props => [player];
}

class Statistics extends Equatable {
  final Team team;
  final List<Statisticss> statistics;

  const Statistics({
    required this.team,
    required this.statistics,
  });

  @override
  List<Object> get props => [team, statistics];
}

class Statisticss extends Equatable {
  final String type;
  final dynamic value;

  const Statisticss({
    required this.type,
    required this.value,
  });

  @override
  List<Object?> get props => [type, value];
}

class Players extends Equatable {
  final Team team;
  final List<Playerss> playerss;

  const Players({
    required this.team,
    required this.playerss,
  });

  @override
  List<Object> get props => [team, playerss];
}

class Playerss extends Equatable {
  final Player player;

  const Playerss({
    required this.player,
  });

  @override
  List<Object> get props => [player];
}

class LeagueResponse extends Equatable {
  final League league;
  final Country country;
  final List<Seasons> seasons;

  const LeagueResponse({
    required this.league,
    required this.country,
    required this.seasons,
  });

  @override
  List<Object> get props => [league, country, seasons];
}

class Country extends Equatable {
  final String name;
  final String flag;

  const Country({
    required this.name,
    required this.flag,
  });

  @override
  List<Object> get props => [name, flag];
}

class Seasons extends Equatable {
  final int year;
  final String start;
  final String end;
  final bool current;

  const Seasons({
    required this.year,
    required this.start,
    required this.end,
    required this.current,
  });

  @override
  List<Object> get props => [year, start, end, current];
}
