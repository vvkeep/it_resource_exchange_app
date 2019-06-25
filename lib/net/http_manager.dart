import 'package:dio/dio.dart';
import 'dart:collection';
import 'interceptors/logs_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/response_Interceptor.dart';
import 'package:it_resource_exchange_app/model/base_result.dart';
import './code.dart';

enum HttpMethod {
  GET, POST
}

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio = Dio();

  HttpManager() {
    _dio.interceptors.add(LogsInterceptor());
    _dio.interceptors.add(ErrorInterceptor(_dio));
    _dio.interceptors.add(ResponseInterceptor());
  }

  resquest(url, params, Map<String, dynamic> header, Options option, {isTip = false}) async {
    Map<String, dynamic> headers = HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    }else {
      option = Options(method: "GET");
      option.headers = headers;
    }

    Response response;
    try {
      response = await _dio.request(url, data:params, queryParameters: params, options: option);
    } on DioError catch (e) {
      Response errorRespnse;
      if(e.response != null) {
        errorRespnse = e.response;
      }else {
        errorRespnse = Response(statusCode: 999);
      }

      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorRespnse.statusCode = Code.NETWOEK_TIMEROUT;
      }
    }

    return response.data;
  }
}

final HttpManager httpManager = HttpManager();
