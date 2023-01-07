import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quickalert/models/quickalert_type.dart';

import '../../../../app/no_input.dart';
import '../../../../data/network/remote/info/network_info.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/use_cases/all_leagues_use_case.dart';
import '../../../../domain/use_cases/get_standing_use_case.dart';
import '../../../resources/colors/color_manager.dart';
import '../../../resources/components/components.dart';
import '../../../resources/string/string_manager.dart';
import 'leagues_state.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  LeaguesCubit(
      this._networkInfo, this._allLeaguesUseCase, this._getStandingUseCase)
      : super(LeaguesInitial());

  static LeaguesCubit get(context) => BlocProvider.of(context);

  final NetworkInfo _networkInfo;
  final AllLeaguesUseCase _allLeaguesUseCase;
  final GetStandingUseCase _getStandingUseCase;

  final List<LeagueResponse> leagues = [];

  getAllLeague(context) async {
    if (await _networkInfo.isConnected) {
      emit(GetLeaguesLoading());
      final response = await _allLeaguesUseCase.call(const NoInput());
      response.fold(
        (l) => {
          emit(GetLeaguesFail(l.message)),
        },
        (r) => {
          leagues.clear(),
          emit(GetLeaguesSuccess(allLeagues: r)),
          leagues.addAll(r),
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

  List<LeagueResponse> searchResult = [];

  onSearchTextChanged(String text) async {
    emit(LeaguesSearch());
    searchResult = [];
    if (text.isEmpty) {
      emit(LeaguesSearchEmpty());
      return searchResult = [];
    }

    for (LeagueResponse userDetail in leagues) {
      if (userDetail.league.name.contains(text)) {
        searchResult.add(userDetail);
        emit(LeaguesSearch());
      }
    }
  }

  int year = 2022;

  LeagueResponse? leagueResponse;

  LeagueResponse setLeague(LeagueResponse leagueRes) {
    leagueResponse = leagueRes;
    return leagueRes;
  }

  List<Standing> standing = [];

  getStandingLeague(context, {required int leagueId, required int year}) async {
    if (await _networkInfo.isConnected) {
      emit(GetLeaguesLoading());
      final response = await _getStandingUseCase.call(
        GetLeagueStandingInputs(id: leagueId, year: year),
      );

      response.fold(
        (l) => {
          emit(GetStandingLeagueFail(l.message)),
        },
        (r) => {
          emit(GetStandingLeagueSuccess(league: r)),

          standing = [],
          r.forEach((element) {
            for (Standing? e in element.league.standings!.first!) {
              standing.add(e!);
            }
            year = element.league.season!;
          }),
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

  changeYear(int value) {
    year = value;
    emit(DropDownYearChanged());
  }
}
