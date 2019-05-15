import 'package:dio/dio.dart';
import 'package:it_resource_exchange_app/model/base_result.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show APPConfig;

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    // RequestOptions options = response.request;
    try {
      if (response.statusCode == 200 || response.statusCode == 201) { //http code
        BaseResult result = BaseResult.fromJson(response.data);
        return result;
      }else {
        if (APPConfig.DEBUG) {
          print("ResponseInterceptor: $response.statusCode");
        }
      }
    } catch(e) {
       if (APPConfig.DEBUG) {
          print("ResponseInterceptor: $e.toString() + options.path");
        }
        return BaseResult(response.data, response.statusCode, e.toString());
    }
  }
}