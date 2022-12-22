import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moscore/presentation/resources/components/components.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../../../../app/no_input.dart';
import '../../../../data/network/remote/info/network_info.dart';
import '../../../../domain/use_cases/live_fixture_use_case.dart';
import '../../../resources/colors/color_manager.dart';
import '../../../resources/string/string_manager.dart';
import 'fixture_state.dart';

class FixtureCubit extends Cubit<FixtureState> {
  FixtureCubit(this._networkInfo, this._liveFixtureUseCase)
      : super(FixtureInitial());

  static FixtureCubit get(context) => BlocProvider.of(context);

  final NetworkInfo _networkInfo;
  final LiveFixtureUseCase _liveFixtureUseCase;

  Future<void> getLiveFixture(context) async {
    if (await _networkInfo.isConnected) {
      emit(GetLiveFixtureLoading());
      final result = await _liveFixtureUseCase.call(const NoInput());
      result.fold(
        (l) => emit(GetLiveFixtureFail(message: l.message)),
        (r) => {
          emit(GetLiveFixtureSuccess(liveFixture: r)),
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

  Future<void> reload(context) async {
    getLiveFixture(context);
  }
}
