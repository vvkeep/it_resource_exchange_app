import 'package:json_annotation/json_annotation.dart'; 
  
part 'home_info.g.dart';


@JsonSerializable()
  class HomeInfo extends Object {

  @JsonKey(name: 'recommendProductList')
  List<RecommendProductList> recommendProductList;

  @JsonKey(name: 'advertiseList')
  List<AdvertiseList> advertiseList;

  HomeInfo(this.recommendProductList,this.advertiseList,);

  factory HomeInfo.fromJson(Map<String, dynamic> srcJson) => _$HomeInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeInfoToJson(this);

}
  
@JsonSerializable()
  class RecommendProductList extends Object {

  @JsonKey(name: 'recommedId')
  int recommedId;

  @JsonKey(name: 'productId')
  int productId;

  @JsonKey(name: 'cateId')
  String cateId;

  @JsonKey(name: 'keywords')
  String keywords;

  @JsonKey(name: 'imgUrls')
  String imgUrls;

  @JsonKey(name: 'price')
  double price;

  @JsonKey(name: 'productTitle')
  String productTitle;

  @JsonKey(name: 'productDesc')
  String productDesc;

  @JsonKey(name: 'tradeCount')
  int tradeCount;

  @JsonKey(name: 'productAddressUrl')
  String productAddressUrl;

  @JsonKey(name: 'createdTime')
  String createdTime;

  @JsonKey(name: 'productStatus')
  int productStatus;

  RecommendProductList(this.recommedId,this.productId,this.cateId,this.keywords,this.imgUrls,this.price,this.productTitle,this.productDesc,this.tradeCount,this.productAddressUrl,this.createdTime,this.productStatus);

  factory RecommendProductList.fromJson(Map<String, dynamic> srcJson) => _$RecommendProductListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendProductListToJson(this);

}

  
@JsonSerializable()
  class AdvertiseList extends Object {

  @JsonKey(name: 'adId')
  int adId;

  @JsonKey(name: 'adTitle')
  String adTitle;

  @JsonKey(name: 'adCoverUrl')
  String adCoverUrl;

  @JsonKey(name: 'adType')
  int adType;

  @JsonKey(name: 'adProductId')
  String adProductId;

  @JsonKey(name: 'adDetailUrl')
  String adDetailUrl;

  AdvertiseList(this.adId,this.adTitle,this.adCoverUrl,this.adType,this.adProductId,this.adDetailUrl);

  factory AdvertiseList.fromJson(Map<String, dynamic> srcJson) => _$AdvertiseListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AdvertiseListToJson(this);

}

  
