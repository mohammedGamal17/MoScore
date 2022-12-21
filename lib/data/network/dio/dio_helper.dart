import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../remote/api_url/api_constants.dart';


class DioHelper {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: APIConstants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    ),
  );

  Future get({
    required String path,
    Map<String, dynamic>? query,
    String token = '19a76979eemshb0337f0256d5a90p1f164bjsn9593cf47fa11',
  }) async {
    _dio.options.headers = {
      'X-RapidAPI-Key': token,
    };
    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
      );
      return response;
    } on DioError catch (e) {
      //RemoteErrorHandlerException(RemoteError.fromJson(e.response!.data));
      if (kDebugMode) {
        print('********** DIO ERROR **********');
        print(e.message);
        print('********** DIO ERROR **********');
      }
      return [];
    }
  }
}
