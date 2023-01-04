import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quickalert/models/quickalert_type.dart';

import '../../../../app/no_input.dart';
import '../../../../data/network/remote/info/network_info.dart';
import '../../../../domain/use_cases/all_leagues_use_case.dart';
import '../../../resources/colors/color_manager.dart';
import '../../../resources/components/components.dart';
import '../../../resources/string/string_manager.dart';
import 'leagues_state.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  LeaguesCubit(this._networkInfo, this._allLeaguesUseCase)
      : super(LeaguesInitial());

  static LeaguesCubit get(context) => BlocProvider.of(context);

  final NetworkInfo _networkInfo;
  final AllLeaguesUseCase _allLeaguesUseCase;

  getAllLeague(context) async {
    if (await _networkInfo.isConnected) {
      emit(GetLeaguesLoading());
      final response = await _allLeaguesUseCase.call(const NoInput());
      response.fold(
        (l) => {
          emit(GetLeaguesFail(l.message)),
        },
        (r) => {
          emit(GetLeaguesSuccess(allLeagues: r)),
        },
      );
    } else {
      alert(
        context,
        quickAlertType: QuickAlertType.error,
        text: StringManager.noInternetError,
        textColor: ColorManager.error,
      );
    }
  }
}
