import 'dart:io';

import 'package:it_resource_exchange_app/common/constant.dart' show APPConfig;
import 'http_manager.dart';
import 'package:it_resource_exchange_app/model/base_result.dart';

class NetworkUtils {
    static requestHomeAdvertisementsAndRecommendProductsData() async {
      String url = APPConfig.Server + "/home/index";
      BaseResult result = await httpManager.request(HttpMethod.GET ,url, null);
      return result;
    }

    static requestCategoryListData() async {
      String url = APPConfig.Server + "/category/list";
      BaseResult result = await httpManager.request(HttpMethod.GET, url, null);
      return result;
    }

    static requestProductListByCateId(int cateId, int currentPage) async {
      String url = APPConfig.Server + "/product/pageListByCateId";
      var params = {"cateId": cateId, "currentPage": currentPage, "pageSize": 20};
      BaseResult result = await httpManager.request(HttpMethod.GET, url, params);
      return result;
    }

    static requestProductDetailByProductId(int productId) async {
      String url = APPConfig.Server + "/product/detail";
      var params = {"productId": productId};
      BaseResult result = await httpManager.request(HttpMethod.GET, url, params);
      return result;
    }

    static login(String account, String password) async {
      String url = APPConfig.Server + "/user/login";
      var params = {"account": account, "password": password};
      BaseResult result = await httpManager.request(HttpMethod.POST, url, params);
      return result;
    }

    static register(String account, String password) async {
      String url = APPConfig.Server + "/user/register";
      var params = {"account": account, "password": password};
      BaseResult result = await httpManager.request(HttpMethod.POST, url, params);
      return result;
    }

     static logout(String userId) async {
      String url = APPConfig.Server + "/user/logout";
      var params = {"userId": userId};
      BaseResult result = await httpManager.request(HttpMethod.POST, url, params);
      return result;
    }
}