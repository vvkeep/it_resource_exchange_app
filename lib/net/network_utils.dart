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

    static requestCategoryListData() async {
      String url = APPConfig.Server + "/category/list";
      BaseResult result = await httpManager.resquest(url, null, null, null);
      return result;
    }

    static requestProductListByCateId(int cateId, int currentPage) async {
      String url = APPConfig.Server + "/product/pageListByCateId";
      var params = {"cateId": cateId, "currentPage": currentPage, "pageSize": 20};
      BaseResult result = await httpManager.resquest(url, params, null, null);
      return result;
    }

    static requestProductDetailByProductId(int productId) async {
      String url = APPConfig.Server + "/product/detail";
      var params = {"productId": productId};
      BaseResult result = await httpManager.resquest(url, params, null, null);
      return result;
    }
}