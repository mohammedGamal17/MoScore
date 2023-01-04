
import 'package:flutter_bloc/flutter_bloc.dart';

import 'leagues_state.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  LeaguesCubit() : super(LeaguesInitial());

  static LeaguesCubit get(context) => BlocProvider.of(context);
}
