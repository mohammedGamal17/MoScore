import 'package:flutter_bloc/flutter_bloc.dart';
import 'team_state.dart';

class TeamCubit extends Cubit<TeamState> {
  TeamCubit() : super(TeamInitial());

  static TeamCubit get(context) => BlocProvider.of(context);
}
