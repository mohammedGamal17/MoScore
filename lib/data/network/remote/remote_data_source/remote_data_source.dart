import 'package:dio/dio.dart';

import '../../../../app/failure/Failure.dart';
import '../../../models/fixture_response/fixture_response_model.dart';
import '../api_url/api_constants.dart';
import '../remote_error/remote_error.dart';

abstract class BaseRemoteDataSource {
  Future<List<FixtureResponseModel>> getLiveFixture();
}

class RemoteDataSourceImplement extends BaseRemoteDataSource {
  RemoteDataSourceImplement();

  @override
  Future<List<FixtureResponseModel>> getLiveFixture() async {
    final response = await Dio(
      BaseOptions(headers: APIConstants.header),
    ).get(APIConstants.fixturesLive);
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
}
