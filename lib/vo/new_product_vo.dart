import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:it_resource_exchange_app/model/cate_info.dart';

class NewProductImgVo extends Object {
  String url;
  String path;
  Asset asset;

  NewProductImgVo({this.url, this.asset});
}

class NewProductVo extends Object {
  String productId;
  String title;
  String price;
  String resourceUrl;
  String resourcePassword;
  String desc;
  CateInfo cateInfo;

  List<NewProductImgVo> imgVoList = [];

  static NewProductVo init({String productId, String cateId, String title, String price, String resourceUrl, String resourcePassword, String desc, List<String> imgUrlList}) {
    CateInfo info;
    if (null != cateId) {
      info = CateInfo(int.parse(cateId), null, null, null);
    }
    imgUrlList = imgUrlList == null ? [] : imgUrlList;
    List<NewProductImgVo> imgVoList = imgUrlList.map((url) {
      return NewProductImgVo(url: url);
    }).toList();
    return NewProductVo._(productId: productId, title: title, price: price, resourceUrl: resourceUrl, resourcePassword: resourcePassword, desc: desc, cateInfo: info, imgVoList: imgVoList);
  }

  NewProductVo._({this.productId, this.title, this.price, this.resourceUrl, this.resourcePassword, this.desc, this.cateInfo, this.imgVoList});
}