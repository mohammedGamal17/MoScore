

import 'package:equatable/equatable.dart';

abstract class LeaguesState extends Equatable {
  const LeaguesState();
}

class LeaguesInitial extends LeaguesState {
  @override
  List<Object> get props => [];
}

class GetLeaguesLoading extends LeaguesState {
  @override
  List<Object> get props => [];
}

class GetLeaguesSuccess extends LeaguesState {
  @override
  List<Object> get props => [];
}

class GetLeaguesFail extends LeaguesState {
  @override
  List<Object> get props => [];
}