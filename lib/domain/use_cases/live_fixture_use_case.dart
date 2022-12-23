import 'package:dartz/dartz.dart';

import '../../app/failure/Failure.dart';
import '../../app/no_input.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';
import 'base_use_case.dart';

class LiveFixtureUseCase extends BaseUseCase<List<FixtureLiveResponse>, NoInput> {
  final Repositories _repositories;

  LiveFixtureUseCase(this._repositories);

  @override
  Future<Either<Failure, List<FixtureLiveResponse>>> call(NoInput inputs) async {
    return await _repositories.getLiveFixture();
  }
}
