import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/network/remote/info/network_info.dart';
import '../../../../domain/use_cases/team_info_use_case.dart';
import '../../../resources/components/components.dart';
import 'team_state.dart';

class TeamCubit extends Cubit<TeamState> {
  TeamCubit(this._networkInfo, this._teamInfoUseCase) : super(TeamInitial());
  final NetworkInfo _networkInfo;

  final TeamInfoUseCase _teamInfoUseCase;

  static TeamCubit get(context) => BlocProvider.of(context);

  Future getTeamInfo(
    context, {
    required int id,
  }) async {
    if (await _networkInfo.isConnected) {
      emit(TeamInfoLoading());
      final response = await _teamInfoUseCase.call(GetTeamInfoInput(id: id));

      response.fold(
        (l) => emit(TeamInfoFail(l.message)),
        (r) => emit(TeamInfoSuccess(r)),
      );
    } else {
      noInternet(context);
    }
  }
}
