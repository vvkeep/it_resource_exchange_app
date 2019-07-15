import 'package:it_resource_exchange_app/common/constant.dart' show APPConfig;
import 'http_manager.dart';
import 'package:it_resource_exchange_app/model/base_result.dart';
import 'dart:io';
import 'package:flutter_qiniu/flutter_qiniu.dart';

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

    static uploadToken() async {
      String url = APPConfig.Server + "/upload/token";
      BaseResult result = await httpManager.request(HttpMethod.POST, url, null);
      return result;
    }

    /// key: 保存在服务器上的资源唯一标识
  /// token: 服务器分配的 token
  Future<bool> onUpload(File file, String key, String token) async {
      final qiniu = FlutterQiniu(zone: QNFixedZone.zone2);
      bool result = await qiniu.upload(file.path, key, token);
      return result;
  }
}