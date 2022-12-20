import 'package:dartz/dartz.dart';

import 'package:moscore/app/failure/Failure.dart';

import '../../app/no_input.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';
import 'base_use_case.dart';

class LiveFixtureUseCase extends BaseUseCase<List<FixtureResponse>, NoInput> {
  final Repositories _repositories;

  LiveFixtureUseCase(this._repositories);

  @override
  Future<Either<Failure, List<FixtureResponse>>> call(NoInput inputs) async {
    return await _repositories.getLiveFixture();
  }
}