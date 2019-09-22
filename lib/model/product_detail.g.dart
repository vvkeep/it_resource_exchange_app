// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) {
  return ProductDetail(
      json['commentCount'] as int,
      json['productDesc'] as String,
      json['tradeCount'] as int,
      json['productTitle'] as String,
      json['productStatus'] as int,
      json['coverUrl'] as String,
      json['productAddressUrl'] as String,
      json['updateTime'] as int,
      json['productAddressPassword'] as String,
      json['keywords'] as String,
      (json['price'] as num)?.toDouble(),
      json['cateTitle'] as String,
      json['isDelete'] as bool,
      json['imgUrls'] as String,
      json['createdTime'] as int,
      json['createdBy'] as String,
      json['productId'] as int,
      json['cateId'] as String,
      json['collectId'] as int);
}

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'commentCount': instance.commentCount,
      'productDesc': instance.productDesc,
      'tradeCount': instance.tradeCount,
      'productTitle': instance.productTitle,
      'productStatus': instance.productStatus,
      'coverUrl': instance.coverUrl,
      'productAddressUrl': instance.productAddressUrl,
      'updateTime': instance.updateTime,
      'productAddressPassword': instance.productAddressPassword,
      'keywords': instance.keywords,
      'price': instance.price,
      'cateTitle': instance.cateTitle,
      'isDelete': instance.isDelete,
      'imgUrls': instance.imgUrls,
      'createdTime': instance.createdTime,
      'createdBy': instance.createdBy,
      'productId': instance.productId,
      'cateId': instance.cateId,
      'collectId': instance.collectId
    };
