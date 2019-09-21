// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect_product_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectProductInfo _$CollectProductInfoFromJson(Map<String, dynamic> json) {
  return CollectProductInfo(
      json['price'] as double,
      json['cateId'] as String,
      json['coverUrl'] as String,
      json['updateTime'] as int,
      json['productId'] as int,
      json['productStatus'] as int,
      json['collectId'] as int,
      json['createdBy'] as String,
      json['productTitle'] as String,
      json['imgUrls'] as String,
      json['productAddressUrl'] as String,
      json['keywords'] as String,
      json['createdTime'] as int,
      json['productDesc'] as String,
      json['tradeCount'] as int,
      json['isDelete'] as bool,
      json['cateTitle'] as String);
}

Map<String, dynamic> _$CollectProductInfoToJson(CollectProductInfo instance) =>
    <String, dynamic>{
      'price': instance.price,
      'cateId': instance.cateId,
      'coverUrl': instance.coverUrl,
      'updateTime': instance.updateTime,
      'productId': instance.productId,
      'productStatus': instance.productStatus,
      'collectId': instance.collectId,
      'createdBy': instance.createdBy,
      'productTitle': instance.productTitle,
      'imgUrls': instance.imgUrls,
      'productAddressUrl': instance.productAddressUrl,
      'keywords': instance.keywords,
      'createdTime': instance.createdTime,
      'productDesc': instance.productDesc,
      'tradeCount': instance.tradeCount,
      'isDelete': instance.isDelete,
      'cateTitle': instance.cateTitle
    };
