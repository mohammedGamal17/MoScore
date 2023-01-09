

import 'package:equatable/equatable.dart';

abstract class TeamState extends Equatable {
  const TeamState();
}

class TeamInitial extends TeamState {
  @override
  List<Object> get props => [];
}
