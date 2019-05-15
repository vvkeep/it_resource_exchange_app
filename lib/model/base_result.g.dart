// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResult _$BaseResultFromJson(Map<String, dynamic> json) {
  return BaseResult(
      json['data'], json['status'] as int, json['message'] as String);
}

Map<String, dynamic> _$BaseResultToJson(BaseResult instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message
    };
