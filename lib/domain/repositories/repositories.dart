import 'package:dartz/dartz.dart';

import '../../app/failure/Failure.dart';
import '../entities/entities.dart';
import '../entities/player_entities.dart';
import '../use_cases/fixture_by_id_use_case.dart';
import '../use_cases/player_info_use_case.dart';
import '../use_cases/standing_use_case.dart';
import '../use_cases/team_info_use_case.dart';

abstract class Repositories {
  Future<Either<Failure, List<FixtureLiveResponse>>> getLiveFixture();

  Future<Either<Failure, List<FixtureResponse>>> getFixtureById(
      FixtureByIdInputs inputs);

  Future<Either<Failure, List<FixtureTodayResponse>>> getTodayMatches();

  Future<Either<Failure, List<LeagueResponse>>> getAllLeague();

  Future<Either<Failure, List<LeagueStandingResponse>>> getStanding(
      GetLeagueStandingInputs inputs);

  Future<Either<Failure, List<TeamInfo>>> getTeamInfo(GetTeamInfoInput inputs);

  Future<Either<Failure,List<PlayerInfo>>> getPlayerInfo(GetPlayerInfoInputs inputs);
}
