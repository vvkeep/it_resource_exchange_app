import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:it_resource_exchange_app/model/base_result.dart';
import '../code.dart';
class ErrorInterceptor extends InterceptorsWrapper {
  final Dio _dio;
  ErrorInterceptor(this._dio);

  @override
  onRequest(RequestOptions options) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(BaseResult(null, Code.NETWORK_ERROR, "网络错误"));
    }
    return super.onRequest(options);
  }
}