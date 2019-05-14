import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import '../result_data.dart';
import '../code.dart';
class ErrorInterceptor extends InterceptorsWrapper {
  final Dio _dio;
  ErrorInterceptor(this._dio);

  @override
  onRequest(RequestOptions options) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(ResultData(Code.errorHandle(Code.NETWORK_ERROR, "网络错误", false), Code.NETWORK_ERROR, "网络错误"));
    }
    return super.onRequest(options);
  }
}