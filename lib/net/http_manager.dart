import 'package:dio/dio.dart';
import 'dart:collection';
import 'interceptors/logs_interceptor.dart';
import 'interceptors/error_interceptor.dart';
class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio = Dio();

  HttpManager() {
    _dio.interceptors.add(LogsInterceptor());
    _dio.interceptors.add(ErrorInterceptor(_dio));
  }

  request(url, params, Map<String, dynamic> header, Options option, {isTip = false}) async {
    Map<String, dynamic> headers = HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    }else {
      option = Options(method: "get");
      option.headers = headers;
    }

    Response response;
    try {
      response = await _dio.request(url, data:params, options: option);
    } on DioError catch (e) {
      Response errorRespnse;
      if(e.response != null) {
        errorRespnse = e.response;
      }else {
        errorRespnse = Response(statusCode: 666);
      }

      // if

    }


  }
}