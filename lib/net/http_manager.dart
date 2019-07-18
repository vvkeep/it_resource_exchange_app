import 'dart:io';

import 'package:dio/dio.dart';
import 'package:it_resource_exchange_app/model/base_result.dart';
import 'interceptors/logs_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/response_Interceptor.dart';
import './code.dart';
import 'dart:typed_data';

enum HttpMethod { GET, POST }

const HTTPMethodValues = ['GET', 'POST'];
const ContentTypeURLEncoded = 'application/x-www-form-urlencoded';

class HttpManager {
  Dio _dio = Dio();

  HttpManager() {
    _dio.interceptors.add(LogsInterceptor());
    _dio.interceptors.add(ErrorInterceptor(_dio));
    _dio.interceptors.add(ResponseInterceptor());
  }

  request(HttpMethod method, String url, Map<String, dynamic> params,
      {ContentType contentType}) async {
    Options _options;
    var type = contentType == null
        ? ContentType.parse(ContentTypeURLEncoded)
        : contentType;
    if (method == HttpMethod.GET) {
      _options =
          Options(method: HTTPMethodValues[method.index], contentType: type);
    } else {
      _options =
          Options(method: HTTPMethodValues[method.index], contentType: type);
    }

    Response response;
    try {
      if (method == HttpMethod.GET) {
        response = await _dio.get(url, queryParameters: params, options: _options);
      } else {
        response = await _dio.post(url, data: params, options: _options);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      } else {
        response = Response(statusCode: 999, statusMessage: "请求失败,稍后再试！");
      }

      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        response.statusCode = Code.NETWOEK_TIMEROUT;
        response.statusMessage = "请求超时,请稍后再试!";
      }
      response.data =
          BaseResult(null, response.statusCode, response.statusMessage);
    }

    return response.data;
  }

  upload(String url, Uint8List data) async {
    UploadFileInfo file = UploadFileInfo.fromBytes(data, 'fileName');
    FormData formData = FormData.from({'file': file});

    Response response;
    try {
      response = await _dio.put(url, data: formData);
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      } else {
        response = Response(statusCode: 999, statusMessage: "请求失败,稍后再试！");
      }

      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        response.statusCode = Code.NETWOEK_TIMEROUT;
        response.statusMessage = "请求超时,请稍后再试!";
      }
      response.data =
          BaseResult(null, response.statusCode, response.statusMessage);
    }

    return response.data;
  }
}

final HttpManager httpManager = HttpManager();
