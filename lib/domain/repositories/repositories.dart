import 'package:dartz/dartz.dart';

import '../../app/failure/Failure.dart';
import '../entities/entities.dart';
import '../use_cases/fixture_by_id_use_case.dart';

abstract class Repositories {
  Future<Either<Failure, List<FixtureResponse>>> getLiveFixture();

  Future<Either<Failure, List<FixtureResponse>>> getFixtureById(
      FixtureByIdInputs inputs);
}
