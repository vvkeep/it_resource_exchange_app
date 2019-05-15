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
      json['productId'] as int,
      json['cateId'] as String,
      json['imgUrls'] as String,
      json['productDesc'] as String,
      json['tradeCount'] as int,
      json['productAddressUrl'] as String);
}

Map<String, dynamic> _$RecommendProductListToJson(
        RecommendProductList instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'cateId': instance.cateId,
      'imgUrls': instance.imgUrls,
      'productDesc': instance.productDesc,
      'tradeCount': instance.tradeCount,
      'productAddressUrl': instance.productAddressUrl
    };

AdvertiseList _$AdvertiseListFromJson(Map<String, dynamic> json) {
  return AdvertiseList(
      json['adId'] as int,
      json['adTitle'] as String,
      json['adCoverUrl'] as String,
      json['adType'] as int,
      json['adProductId'] as String);
}

Map<String, dynamic> _$AdvertiseListToJson(AdvertiseList instance) =>
    <String, dynamic>{
      'adId': instance.adId,
      'adTitle': instance.adTitle,
      'adCoverUrl': instance.adCoverUrl,
      'adType': instance.adType,
      'adProductId': instance.adProductId
    };
