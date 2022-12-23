import 'package:dartz/dartz.dart';

import '../../app/failure/Failure.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';
import 'base_use_case.dart';

class FixtureByIdUseCase
    extends BaseUseCase<List<FixtureResponse>, FixtureByIdInputs> {
  final Repositories _repositories;

  FixtureByIdUseCase(this._repositories);

  @override
  Future<Either<Failure, List<FixtureResponse>>> call(
      FixtureByIdInputs inputs) async {
    return await _repositories.getFixtureById(inputs);
  }
}

class FixtureByIdInputs {
  final int id;

  FixtureByIdInputs({required this.id});
}
