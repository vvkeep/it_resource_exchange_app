import 'dart:io';
import 'dart:async';
import 'package:it_resource_exchange_app/common/constant.dart' show APPConfig;
import 'http_manager.dart';
import 'package:it_resource_exchange_app/model/base_result.dart';
import 'dart:typed_data';

class NetworkUtils {
  static requestHomeAdvertisementsAndRecommendProductsData() async {
    String url = APPConfig.Server + "/home/index";
    BaseResult result = await httpManager.request(HttpMethod.GET, url, null);
    return result;
  }

  static Future<BaseResult> requestCategoryListData() async {
    String url = APPConfig.Server + "/category/list";
    BaseResult result = await httpManager.request(HttpMethod.GET, url, null);
    return result;
  }

  static requestProductListByCateId(int cateId, int currentPage) async {
    String url = APPConfig.Server + "/product/pageListByCateId";

    var params = {"currentPage": currentPage, "pageSize": 20};
    if (cateId != null) {
      params["cateId"] = cateId;
    }
    BaseResult result = await httpManager.request(HttpMethod.GET, url, params);
    return result;
  }

  static Future<BaseResult> requestProductDetailByProductId(
      int productId) async {
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

  static register(String account, String password, String code) async {
    String url = APPConfig.Server + "/user/verifyRegister";
    var params = {"account": account, "password": password, "code": code};
    BaseResult result = await httpManager.request(HttpMethod.POST, url, params);
    return result;
  }

  static logout(String userId) async {
    String url = APPConfig.Server + "/user/logout";
    var params = {"userId": userId};
    BaseResult result = await httpManager.request(HttpMethod.POST, url, params);
    return result;
  }

  static Future<BaseResult> uploadToken() async {
    String url = APPConfig.Server + "/upload/token";
    BaseResult result = await httpManager.request(HttpMethod.GET, url, null);
    return result;
  }

  static Future<BaseResult> onUpload(Uint8List data) async {
    String url = APPConfig.Server + "/upload/qiniu";
    BaseResult result = await httpManager.upload(url, data);
    return result;
  }

  static submitProduct(Map<String, dynamic> params) async {
    String url = APPConfig.Server + "/product/submit";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, params,
        contentType: ContentType.json);
    return result;
  }

  static requestMyProductListData(int userId) async {
    String url = APPConfig.Server + "/product/pageListByCreateUserId";
    var params = {"userId": userId};
    BaseResult result = await httpManager.request(HttpMethod.GET, url, params);
    return result;
  }

  static sendCodeForRegister(String account) async {
    String url = APPConfig.Server + "/user/sendCodeForRegister";
    var params = {"account": account};
    BaseResult result = await httpManager.request(HttpMethod.POST, url, params);
    return result;
  }

  static sendCodeForReset(String account) async {
    String url = APPConfig.Server + "/user/sendCodeForReset";
    var params = {"account": account};
    BaseResult result = await httpManager.request(HttpMethod.POST, url, params);
    return result;
  }

  static resetPassword(String account, String password, String code) async {
    String url = APPConfig.Server + "/user/verifyReset";
    var params = {"account": account, "password": password, "code": code};
    BaseResult result = await httpManager.request(HttpMethod.POST, url, params);
    return result;
  }

  static remarkProduct(int productId, int parentCommentId, String content) async {
    String url = APPConfig.Server + "/productComment/remark";
    var params = {"productId": productId, "parentCommentId": parentCommentId ?? 0, "content": content};
    BaseResult result = await httpManager.request(HttpMethod.POST, url, params);
    return result;
  }

  static Future<BaseResult> requstProductCommentList(int productId, int startCommentId) async {
    String url = APPConfig.Server + "/productComment/getList";
    var params = {"productId": productId, "startCommentId": startCommentId, "parentCommentId":0, "count": 20};
    BaseResult result = await httpManager.request(HttpMethod.GET, url, params);
    return result;
  }

}
