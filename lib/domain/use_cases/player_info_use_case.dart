import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../app/failure/Failure.dart';
import '../entities/player_entities.dart';
import '../repositories/repositories.dart';
import 'base_use_case.dart';

class PlayerInfoUseCase
    extends BaseUseCase<List<PlayerInfo>, GetPlayerInfoInputs> {
  final Repositories _repositories;

  PlayerInfoUseCase(this._repositories);

  @override
  Future<Either<Failure, List<PlayerInfo>>> call(
      GetPlayerInfoInputs inputs) async {
    return await _repositories.getPlayerInfo(inputs);
  }
}

class GetPlayerInfoInputs extends Equatable {
  final int id;
  final int season;

  const GetPlayerInfoInputs({required this.id, required this.season});

  @override
  List<Object> get props => [id, season];
}
