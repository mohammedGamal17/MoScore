import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/network/remote/info/network_info.dart';
import '../../../../domain/use_cases/player_info_use_case.dart';
import '../../../resources/components/components.dart';
import 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit(this._networkInfo, this._playerInfoUseCase)
      : super(PlayerInitial());

  static PlayerCubit get(context) => BlocProvider.of(context);

  final NetworkInfo _networkInfo;
  final PlayerInfoUseCase _playerInfoUseCase;

  Future getPlayer(
    context, {
    required int id,
    required int season,
  }) async {
    if (await _networkInfo.isConnected) {
      final response = await _playerInfoUseCase.call(
        GetPlayerInfoInputs(
          id: id,
          season: season,
        ),
      );

      response.fold(
        (l) => emit(GetPlayerInfoFail(l.message)),
        (r) => emit(GetPlayerInfoSuccess(r)),
      );
    } else {
      noInternet(context);
    }
  }




  bool isView = false;

  bool isDetailsViewed({required int index}) {
    isView = !isView;
    emit(PlayerDetailsView(isView));
    return isView;
  }
}
