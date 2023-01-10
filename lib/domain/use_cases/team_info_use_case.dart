import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../app/failure/Failure.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';
import 'base_use_case.dart';

class TeamInfoUseCase extends BaseUseCase<List<TeamInfo>, GetTeamInfoInput> {
  final Repositories _repositories;

  TeamInfoUseCase(this._repositories);

  @override
  Future<Either<Failure, List<TeamInfo>>> call(GetTeamInfoInput inputs) async {
    return await _repositories.getTeamInfo(inputs);
  }
}

class GetTeamInfoInput extends Equatable {
  final int id;

  const GetTeamInfoInput({required this.id});

  @override
  List<Object> get props => [id];
}
