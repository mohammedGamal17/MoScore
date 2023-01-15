import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app/no_input.dart';
import '../../../../data/network/remote/info/network_info.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/use_cases/fixture_by_id_use_case.dart';
import '../../../../domain/use_cases/live_fixture_use_case.dart';
import '../../../../domain/use_cases/today_matches_use_case.dart';
import '../../../resources/components/components.dart';
import 'fixture_state.dart';

class FixtureCubit extends Cubit<FixtureState> {
  FixtureCubit(
    this._networkInfo,
    this._liveFixtureUseCase,
    this._fixtureByIdUseCase,
    this._todayMatchesUseCase,
  ) : super(FixtureInitial());

  static FixtureCubit get(context) => BlocProvider.of(context);

  final NetworkInfo _networkInfo;
  final LiveFixtureUseCase _liveFixtureUseCase;
  final FixtureByIdUseCase _fixtureByIdUseCase;
  final TodayMatchesUseCase _todayMatchesUseCase;

  List<FixtureLiveResponse> liveFixture = [];
  List<FixtureTodayResponse> fixtureToday = [];
  List<Statisticss> homeStatistics = [];
  List<Statisticss> awayStatistics = [];
  List<Lineups> lineups = [];
  List<Lineups> homeLineups = [];
  List<StartXI> homeLineupsStartXI = [];
  List<Lineups> awayLineups = [];
  List<StartXI> awayLineupsStartXI = [];
  List<Events> event = [];
  List<Events> homeEvents = [];
  List<Events> awayEvents = [];

  Future<void> reloadHome(context) async {
    _getLiveFixture(context);
    _getTodayMatches(context);
  }

  Future<void> _getLiveFixture(context) async {
    if (await _networkInfo.isConnected) {
      emit(GetLiveFixtureLoading());
      final result = await _liveFixtureUseCase.call(const NoInput());
      result.fold(
        (l) => emit(GetLiveFixtureFail(message: l.message)),
        (r) => {
          liveFixture = [],
          emit(GetLiveFixtureSuccess(liveFixture: r)),
          r.forEach(
            (element) {
              liveFixture.add(element);
            },
          ),
        },
      );
    } else {
      noInternet(context);
    }
  }

  Future<void> _getTodayMatches(context) async {
    if (await _networkInfo.isConnected) {
      emit(GetTodayMatchesLoading());
      final response = await _todayMatchesUseCase.call(const NoInput());
      response.fold(
        (l) => emit(GetTodayMatchesFail(message: l.message)),
        (r) => {
          fixtureToday = [],
          emit(GetTodayMatchesSuccess(fixtureToday: r)),
          r.forEach(
            (element) {
              fixtureToday.add(element);
            },
          ),
        },
      );
    } else {
      noInternet(context);
    }
  }

  Future<void> getFixtureById(
    context, {
    required int id,
  }) async {
    if (await _networkInfo.isConnected) {
      emit(GetFixtureByIdLoading());
      final result = await _fixtureByIdUseCase.call(FixtureByIdInputs(id: id));
      result.fold(
        (l) => emit(GetFixtureByIdFail(message: l.message)),
        (r) => {
          emit(GetFixtureByIdSuccess(liveFixture: r)),
          r.forEach((element) {
            _insertEvents(element: element);
            _insertLineups(element: element);
            _insertStatistics(element: element);
          }),
        },
      );
    } else {
      noInternet(context);
    }
  }

  _insertEvents({
    required FixtureResponse element,
  }) {
    event = [];
    homeEvents = [];
    awayEvents = [];
    for (Events events in element.events) {
      event.add(events);
      if (element.teams.home.id == events.team.id) {
        homeEvents.add(events);
      } else {
        awayEvents.add(events);
      }
    }
  }

  _insertLineups({
    required FixtureResponse element,
  }) {
    lineups = [];
    homeLineups = [];
    homeLineupsStartXI = [];
    awayLineups = [];
    awayLineupsStartXI = [];
    for (Lineups lineup in element.lineups) {
      lineups.add(lineup);
      if (element.teams.home.id == lineup.team.id) {
        homeLineups.add(lineup);
        for (StartXI e in lineup.startXI) {
          homeLineupsStartXI.add(e);
        }
      } else {
        awayLineups.add(lineup);
        for (StartXI e in lineup.startXI) {
          awayLineupsStartXI.add(e);
        }
      }
    }
  }

  _insertStatistics({
    required FixtureResponse element,
  }) {
    homeStatistics = [];
    awayStatistics = [];
    for (Statistics statistic in element.statistics) {
      if (element.teams.home.id == statistic.team.id) {
        for (var e in statistic.statistics) {
          homeStatistics.add(e);
        }
      } else {
        for (var e in statistic.statistics) {
          awayStatistics.add(e);
        }
      }
    }
  }

  Future<void> reloadFixture(context, {required int id}) async {
    getFixtureById(context, id: id);
  }



  String convertTimeStamp({
    required int timeStamp,
  }) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    String formattedTime = DateFormat('hh:mm a').format(date.toLocal());

    return formattedTime;
  }

  String convertData() {
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('MMM dd').format(date);
    return formattedDate;
  }
}
