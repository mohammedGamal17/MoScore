import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import '../../../../data/network/remote/info/network_info.dart';
import '../../../../domain/use_cases/team_info_use_case.dart';
import '../../../resources/colors/color_manager.dart';
import '../../../resources/components/components.dart';
import '../../../resources/string/string_manager.dart';
import 'team_state.dart';

class TeamCubit extends Cubit<TeamState> {
  TeamCubit(this._networkInfo, this._teamInfoUseCase) : super(TeamInitial());
  final NetworkInfo _networkInfo;

  final TeamInfoUseCase _teamInfoUseCase;

  static TeamCubit get(context) => BlocProvider.of(context);

  Future getTeamInfo(context, {required int id}) async {
    if (await _networkInfo.isConnected) {
      final response = await _teamInfoUseCase.call(GetTeamInfoInput(id: id));

      response.fold(
        (l) => emit(TeamInfoFail(l.message)),
        (r) => {
          emit(TeamInfoSuccess(r)),
          print(r),
        },
      );
    } else {
      alert(
        context,
        quickAlertType: QuickAlertType.error,
        text: StringManager.error,
        textColor: ColorManager.error,
      );
    }
  }
}
