import 'package:it_resource_exchange_app/common/constant.dart' show APPConfig;
import 'package:dio/dio.dart';
import 'http_manager.dart';
import 'package:it_resource_exchange_app/model/base_result.dart';
import './code.dart';

class NetworkUtils {
    static requestHomeAdvertisementsAndRecommendProductsData() async {
      String url = APPConfig.Server + "/home/index";
      BaseResult result = await httpManager.resquest(url, null, null, null);
      return result;
    }
}