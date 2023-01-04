import 'package:dartz/dartz.dart';
import 'package:moscore/app/failure/Failure.dart';
import 'package:moscore/app/no_input.dart';
import 'package:moscore/domain/repositories/repositories.dart';
import 'package:moscore/domain/use_cases/base_use_case.dart';

import '../entities/entities.dart';

class AllLeaguesUseCase extends BaseUseCase<List<LeagueResponse>, NoInput> {
  final Repositories _repositories;

  AllLeaguesUseCase(this._repositories);

  @override
  Future<Either<Failure, List<LeagueResponse>>> call(NoInput inputs) async {
    return await _repositories.getAllLeague();
  }
}
