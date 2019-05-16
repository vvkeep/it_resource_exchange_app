// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeInfo _$HomeInfoFromJson(Map<String, dynamic> json) {
  return HomeInfo(
      (json['recommendProductList'] as List)
          ?.map((e) => e == null
              ? null
              : RecommendProductList.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['advertiseList'] as List)
          ?.map((e) => e == null
              ? null
              : AdvertiseList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$HomeInfoToJson(HomeInfo instance) => <String, dynamic>{
      'recommendProductList': instance.recommendProductList,
      'advertiseList': instance.advertiseList
    };

RecommendProductList _$RecommendProductListFromJson(Map<String, dynamic> json) {
  return RecommendProductList(
      json['recommedId'] as int,
      json['productId'] as int,
      json['cateId'] as String,
      json['keywords'] as String,
      json['imgUrls'] as String,
      (json['price'] as num)?.toDouble(),
      json['productTitle'] as String,
      json['productDesc'] as String,
      json['tradeCount'] as int,
      json['productAddressUrl'] as String,
      json['createdTime'] as String,
      json['productStatus'] as int);
}

Map<String, dynamic> _$RecommendProductListToJson(
        RecommendProductList instance) =>
    <String, dynamic>{
      'recommedId': instance.recommedId,
      'productId': instance.productId,
      'cateId': instance.cateId,
      'keywords': instance.keywords,
      'imgUrls': instance.imgUrls,
      'price': instance.price,
      'productTitle': instance.productTitle,
      'productDesc': instance.productDesc,
      'tradeCount': instance.tradeCount,
      'productAddressUrl': instance.productAddressUrl,
      'createdTime': instance.createdTime,
      'productStatus': instance.productStatus
    };

AdvertiseList _$AdvertiseListFromJson(Map<String, dynamic> json) {
  return AdvertiseList(
      json['adId'] as int,
      json['adTitle'] as String,
      json['adCoverUrl'] as String,
      json['adType'] as int,
      json['adProductId'] as String,
      json['adDetailUrl'] as String);
}

Map<String, dynamic> _$AdvertiseListToJson(AdvertiseList instance) =>
    <String, dynamic>{
      'adId': instance.adId,
      'adTitle': instance.adTitle,
      'adCoverUrl': instance.adCoverUrl,
      'adType': instance.adType,
      'adProductId': instance.adProductId,
      'adDetailUrl': instance.adDetailUrl
    };
