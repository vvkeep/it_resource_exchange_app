import 'package:json_annotation/json_annotation.dart'; 
  
part 'product_detail.g.dart';


@JsonSerializable()
  class ProductDetail extends Object {

  @JsonKey(name: 'productId')
  int productId;

  @JsonKey(name: 'cateId')
  String cateId;

  @JsonKey(name: 'cateTitle')
  String cateTitle;

  @JsonKey(name: 'keywords')
  String keywords;

  @JsonKey(name: 'imgUrls')
  String imgUrls;

  @JsonKey(name: 'coverUrl')
  String coverUrl;

  @JsonKey(name: 'price')
  double price;

  @JsonKey(name: 'productTitle')
  String productTitle;

  @JsonKey(name: 'productDesc')
  String productDesc;

  @JsonKey(name: 'productStatus')
  int productStatus;

  @JsonKey(name: 'tradeCount')
  int tradeCount;

  @JsonKey(name: 'productAddressUrl')
  String productAddressUrl;

  @JsonKey(name: 'productAddressPassword')
  String productAddressPassword;

  @JsonKey(name: 'createdTime')
  String createdTime;

  ProductDetail(this.productId,this.cateId,this.cateTitle, this.keywords,this.imgUrls,this.coverUrl,this.price,this.productTitle,this.productDesc,this.productStatus,this.tradeCount,this.productAddressUrl,this.productAddressPassword,this.createdTime,);

  factory ProductDetail.fromJson(Map<String, dynamic> srcJson) => _$ProductDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);

}