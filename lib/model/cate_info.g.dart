// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cate_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CateInfo _$CateInfoFromJson(Map<String, dynamic> json) {
  return CateInfo(json['cateId'] as int, json['orderIndex'] as int,
      json['cateTitle'] as String, json['cateStatus'] as int);
}

Map<String, dynamic> _$CateInfoToJson(CateInfo instance) => <String, dynamic>{
      'cateId': instance.cateId,
      'orderIndex': instance.orderIndex,
      'cateTitle': instance.cateTitle,
      'cateStatus': instance.cateStatus
    };
