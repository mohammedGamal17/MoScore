import 'package:dartz/dartz.dart';
import 'package:moscore/data/network/remote/remote_data_source/remote_data_source.dart';
import 'package:moscore/domain/use_cases/fixture_by_id_use_case.dart';

import '../../app/failure/Failure.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';

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
}
