// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) {
  return ProductDetail(
      json['productId'] as int,
      json['cateId'] as String,
      json['keywords'] as String,
      json['imgUrls'] as String,
      json['coverUrl'] as String,
      (json['price'] as num)?.toDouble(),
      json['productTitle'] as String,
      json['productDesc'] as String,
      json['productStatus'] as int,
      json['tradeCount'] as int,
      json['productAddressUrl'] as String,
      json['productAddressPassword'] as String,
      json['createdTime'] as String);
}

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'cateId': instance.cateId,
      'keywords': instance.keywords,
      'imgUrls': instance.imgUrls,
      'coverUrl': instance.coverUrl,
      'price': instance.price,
      'productTitle': instance.productTitle,
      'productDesc': instance.productDesc,
      'productStatus': instance.productStatus,
      'tradeCount': instance.tradeCount,
      'productAddressUrl': instance.productAddressUrl,
      'productAddressPassword': instance.productAddressPassword,
      'createdTime': instance.createdTime
    };
