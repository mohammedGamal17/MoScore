import 'package:equatable/equatable.dart';

import '../../../../domain/entities/entities.dart';

abstract class TeamState extends Equatable {
  const TeamState();
}

class TeamInitial extends TeamState {
  @override
  List<Object> get props => [];
}

class TeamInfoLoading extends TeamState {
  @override
  List<Object> get props => [];
}

class TeamInfoSuccess extends TeamState {

  final List<TeamInfo> teamInfo ;


  const TeamInfoSuccess(this.teamInfo);

  @override
  List<Object> get props => [teamInfo];
}

class TeamInfoFail extends TeamState {
  final String message;

  const TeamInfoFail(this.message);

  @override
  List<Object> get props => [message];
}