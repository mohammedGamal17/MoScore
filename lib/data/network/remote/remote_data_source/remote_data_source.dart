import 'package:dio/dio.dart';

import '../../../../app/failure/Failure.dart';
import '../../../../domain/use_cases/fixture_by_id_use_case.dart';
import '../../../../domain/use_cases/get_standing_use_case.dart';
import '../../../models/fixture_response/fixture_response_model.dart';
import '../../../models/leagues_response/league_standing_model.dart';
import '../../../models/leagues_response/leagues_response_model.dart';
import '../api_url/api_constants.dart';
import '../remote_error/remote_error.dart';

abstract class BaseRemoteDataSource {
  Future<List<FixtureLiveResponseModel>> getLiveFixture();

  Future<List<FixtureResponseModel>> getFixtureBuId(FixtureByIdInputs inputs);

  Future<List<FixtureTodayResponseModel>> getTodayMatches();

  Future<List<LeagueResponseModel>> getAllLeague();

  Future<List<LeagueStandingResponseModel>> getStanding(
      GetLeagueStandingInputs inputs);
}

class RemoteDataSourceImplement extends BaseRemoteDataSource {
  RemoteDataSourceImplement();

  @override
  Future<List<FixtureLiveResponseModel>> getLiveFixture() async {
    final response = await Dio(
      BaseOptions(headers: APIConstants.header),
    ).get(APIConstants.fixturesLive);
    if (response.statusCode == 200) {
      return List<FixtureLiveResponseModel>.from(
        (response.data['response'] as List).map(
          (e) => FixtureLiveResponseModel.fromJson(e),
        ),
      );
    } else {
      throw RemoteErrorHandlerException(RemoteError.fromJson(response.data));
    }
  }

  @override
  Future<List<FixtureResponseModel>> getFixtureBuId(
      FixtureByIdInputs inputs) async {
    final response = await Dio(
      BaseOptions(headers: APIConstants.header),
    ).get(
      APIConstants.getFixturesByID(id: inputs.id),
    );

    if (response.statusCode == 200) {
      return List<FixtureResponseModel>.from(
        (response.data['response'] as List).map(
          (e) => FixtureResponseModel.fromJson(e),
        ),
      );
    } else {
      throw RemoteErrorHandlerException(RemoteError.fromJson(response.data));
    }
  }

  @override
  Future<List<FixtureTodayResponseModel>> getTodayMatches() async {
    final response = await Dio(
      BaseOptions(
        headers: APIConstants.header,
      ),
    ).get(APIConstants.getTodayMatch);
    if (response.statusCode == 200) {
      return List<FixtureTodayResponseModel>.from(
        (response.data['response'] as List).map(
          (e) => FixtureTodayResponseModel.fromJson(e),
        ),
      );
    } else {
      throw RemoteErrorHandlerException(RemoteError.fromJson(response.data));
    }
  }

  @override
  Future<List<LeagueResponseModel>> getAllLeague() async {
    final response = await Dio(
      BaseOptions(
        headers: APIConstants.header,
      ),
    ).get(APIConstants.leagues);
    if (response.statusCode == 200) {
      return List<LeagueResponseModel>.from(
        (response.data['response'] as List).map(
          (e) => LeagueResponseModel.fromJson(e),
        ),
      );
    } else {
      throw RemoteErrorHandlerException(RemoteError.fromJson(response.data));
    }
  }

  @override
  Future<List<LeagueStandingResponseModel>> getStanding(
      GetLeagueStandingInputs inputs) async {
    final response = await Dio(
      BaseOptions(headers: APIConstants.header),
    ).get(
      APIConstants.getLeagueByIdAndSeason(
        season: inputs.year,
        leagueId: inputs.id,
      ),
    );

    if (response.statusCode == 200) {
      return List<LeagueStandingResponseModel>.from(
        (response.data['response'] as List).map(
          (e) => LeagueStandingResponseModel.fromJson(e),
        ),
      );
    } else {
      throw RemoteErrorHandlerException(RemoteError.fromJson(response.data));
    }
  }
}
