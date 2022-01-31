import 'package:dio/dio.dart';
import 'package:practical/constants/common_constants.dart';

import 'api_urls.dart';


class DioClient {
  static Dio? dio;

  static Dio? getDioClient() {
    if (dio == null) {
      dio = Dio();
      dio!.options.baseUrl = ApiUrls.BASE_URL;
      dio!.options.connectTimeout =
          CommonConstants.CONNECTION_TIME_OUT_IN_MILL_SEC;
      dio!.options.receiveTimeout =
          CommonConstants.RECEIVE_TIME_OUT_IN_MILL_SEC;
    }
    return dio;
  }
}
