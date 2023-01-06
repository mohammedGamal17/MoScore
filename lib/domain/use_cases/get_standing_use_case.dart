import 'package:dartz/dartz.dart';

import '../../app/failure/Failure.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';
import 'base_use_case.dart';

class GetStandingUseCase
    extends BaseUseCase<List<LeagueStanding>, GetLeagueStandingInputs> {
  final Repositories _repositories;

  GetStandingUseCase(this._repositories);

  @override
  Future<Either<Failure, List<LeagueStanding>>> call(
    GetLeagueStandingInputs inputs,
  ) async {
    return await _repositories.getStanding(inputs);
  }
}

class GetLeagueStandingInputs {
  final int id;
  final int year;

  GetLeagueStandingInputs({required this.id, required this.year});
}
