import 'package:dartz/dartz.dart';

import '../../app/failure/Failure.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/use_cases/fixture_by_id_use_case.dart';
import '../../domain/use_cases/standing_use_case.dart';
import '../../domain/use_cases/team_info_use_case.dart';
import '../models/leagues_response/league_standing_model.dart';
import '../models/team_response/team_model.dart';
import '../network/remote/remote_data_source/remote_data_source.dart';

class RepositoriesImplementation implements Repositories {
  RepositoriesImplementation(this._baseRemoteDataSource);

  final BaseRemoteDataSource _baseRemoteDataSource;

  @override
  Future<Either<Failure, List<FixtureLiveResponse>>> getLiveFixture() async {
    final response = await _baseRemoteDataSource.getLiveFixture();
    try {
      return Right(response);
    } on RemoteErrorHandlerException catch (e) {
      return Left(
        RemoteErrorImplement(
          e.remoteError.statusCode,
          e.remoteError.statusMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<FixtureResponse>>> getFixtureById(
      FixtureByIdInputs inputs) async {
    final response = await _baseRemoteDataSource.getFixtureBuId(inputs);
    try {
      return Right(response);
    } on RemoteErrorHandlerException catch (e) {
      return Left(
        RemoteErrorImplement(
          e.remoteError.statusCode,
          e.remoteError.statusMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<FixtureTodayResponse>>> getTodayMatches() async {
    final response = await _baseRemoteDataSource.getTodayMatches();
    try {
      return Right(response);
    } on RemoteErrorHandlerException catch (e) {
      return Left(
        RemoteErrorImplement(
          e.remoteError.statusCode,
          e.remoteError.statusMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<LeagueResponse>>> getAllLeague() async {
    final response = await _baseRemoteDataSource.getAllLeague();
    try {
      return Right(response);
    } on RemoteErrorHandlerException catch (e) {
      return Left(
        RemoteErrorImplement(
          e.remoteError.statusCode,
          e.remoteError.statusMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<LeagueStandingResponseModel>>> getStanding(
      GetLeagueStandingInputs inputs) async {
    final response = await _baseRemoteDataSource.getStanding(inputs);

    try {
      return Right(response);
    } on RemoteErrorHandlerException catch (e) {
      return Left(
        RemoteErrorImplement(
          e.remoteError.statusCode,
          e.remoteError.statusMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<TeamInfoModel>>> getTeamInfo(
      GetTeamInfoInput inputs) async {
    final response = await _baseRemoteDataSource.getTeamInfo(inputs);
    try {
      return Right(response);
    } on RemoteErrorHandlerException catch (e) {
      return Left(
        RemoteErrorImplement(
          e.remoteError.statusCode,
          e.remoteError.statusMessage,
        ),
      );
    }
  }
}
