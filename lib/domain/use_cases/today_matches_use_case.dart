import 'package:dartz/dartz.dart';

import '../../app/failure/Failure.dart';
import '../../app/no_input.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';
import 'base_use_case.dart';

class TodayMatchesUseCase
    extends BaseUseCase<List<FixtureTodayResponse>, NoInput> {
  final Repositories _repositories;

  TodayMatchesUseCase(this._repositories);

  @override
  Future<Either<Failure, List<FixtureTodayResponse>>> call(
      NoInput inputs) async {
    return await _repositories.getTodayMatches();
  }
}
