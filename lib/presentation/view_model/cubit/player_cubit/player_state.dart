import 'package:equatable/equatable.dart';

import '../../../../domain/entities/player_entities.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();
}

class PlayerInitial extends PlayerState {
  @override
  List<Object> get props => [];
}

class GetPlayerInfoLoading extends PlayerState {
  @override
  List<Object> get props => [];
}

class GetPlayerInfoSuccess extends PlayerState {
  final List<PlayerInfo> playerInfo;

  const GetPlayerInfoSuccess(this.playerInfo);

  @override
  List<Object> get props => [playerInfo];
}

class GetPlayerInfoFail extends PlayerState {
  final String message;

  const GetPlayerInfoFail(this.message);

  @override
  List<Object> get props => [message];
}

class PlayerDetailsView extends PlayerState {
  final bool isView;

  const PlayerDetailsView(this.isView);

  @override
  List<Object> get props => [isView];
}
