import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:it_resource_exchange_app/model/cate_info.dart';

class NewProductImgVo extends Object {
  String url;
  Asset asset;
}

class NewProductVo extends Object {
  String title;
  String price;
  String resourceUrl;
  String resourcePassword;
  String desc;
  CateInfo cateInfo;

  List<NewProductImgVo> imgVoList = [];

  static NewProductVo init({int cateId}) {
    CateInfo info = CateInfo(cateId, null, null, null);
    return NewProductVo._(cateInfo: info);
  }

  NewProductVo._({this.title, this.price, this.resourceUrl, this.resourcePassword, this.desc, this.cateInfo, this.imgVoList});
}