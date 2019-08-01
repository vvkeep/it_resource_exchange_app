// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeInfo _$HomeInfoFromJson(Map<String, dynamic> json) {
  return HomeInfo(
      (json['advertiseList'] as List)
          ?.map((e) => e == null
              ? null
              : AdvertiseList.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['recommendProductList'] as List)
          ?.map((e) => e == null
              ? null
              : RecommendProductList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$HomeInfoToJson(HomeInfo instance) => <String, dynamic>{
      'advertiseList': instance.advertiseList,
      'recommendProductList': instance.recommendProductList
    };

AdvertiseList _$AdvertiseListFromJson(Map<String, dynamic> json) {
  return AdvertiseList(
      json['adId'] as int,
      json['adTitle'] as String,
      json['adDetailUrl'] as String,
      json['adProductId'] as String,
      json['adType'] as int,
      json['adCoverUrl'] as String);
}

Map<String, dynamic> _$AdvertiseListToJson(AdvertiseList instance) =>
    <String, dynamic>{
      'adId': instance.adId,
      'adTitle': instance.adTitle,
      'adDetailUrl': instance.adDetailUrl,
      'adProductId': instance.adProductId,
      'adType': instance.adType,
      'adCoverUrl': instance.adCoverUrl
    };

RecommendProductList _$RecommendProductListFromJson(Map<String, dynamic> json) {
  return RecommendProductList(
      json['coverUrl'] as String,
      json['cateId'] as String,
      json['productAddressPassword'] as String,
      json['imgUrls'] as String,
      json['keywords'] as String,
      (json['price'] as num)?.toDouble(),
      json['productTitle'] as String,
      json['revision'] as String,
      json['productStatus'] as int,
      json['productDesc'] as String,
      json['recommendId'] as int,
      json['cateTitle'] as String,
      json['isDelete'] as bool,
      json['productId'] as int,
      json['productAddressUrl'] as String,
      json['updateBy'] as String,
      json['updateTime'] as int,
      json['tradeCount'] as int,
      json['createdBy'] as String,
      json['createdTime'] as int);
}

Map<String, dynamic> _$RecommendProductListToJson(
        RecommendProductList instance) =>
    <String, dynamic>{
      'coverUrl': instance.coverUrl,
      'cateId': instance.cateId,
      'productAddressPassword': instance.productAddressPassword,
      'imgUrls': instance.imgUrls,
      'keywords': instance.keywords,
      'price': instance.price,
      'productTitle': instance.productTitle,
      'revision': instance.revision,
      'productStatus': instance.productStatus,
      'productDesc': instance.productDesc,
      'recommendId': instance.recommendId,
      'cateTitle': instance.cateTitle,
      'isDelete': instance.isDelete,
      'productId': instance.productId,
      'productAddressUrl': instance.productAddressUrl,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
      'tradeCount': instance.tradeCount,
      'createdBy': instance.createdBy,
      'createdTime': instance.createdTime
    };
