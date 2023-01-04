import 'package:equatable/equatable.dart';

import '../../../../domain/entities/entities.dart';

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
  final List<LeagueResponse> allLeagues;

  const GetLeaguesSuccess({required this.allLeagues});

  @override
  List<Object> get props => [allLeagues];
}

class GetLeaguesFail extends LeaguesState {
  final String message;


  const GetLeaguesFail(this.message);

  @override
  List<Object> get props => [message];
}
