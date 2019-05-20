// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResult _$PageResultFromJson(Map<String, dynamic> json) {
  return PageResult(
      json['currentPage'] as int,
      json['pageSize'] as int,
      json['totalNum'] as int,
      json['isMore'] as int,
      json['totalPage'] as int,
      json['startIndex'] as int,
      (json['items'] as List)?.map((e) => e as Map<String, dynamic>)?.toList());
}

Map<String, dynamic> _$PageResultToJson(PageResult instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'totalNum': instance.totalNum,
      'isMore': instance.isMore,
      'totalPage': instance.totalPage,
      'startIndex': instance.startIndex,
      'items': instance.items
    };
