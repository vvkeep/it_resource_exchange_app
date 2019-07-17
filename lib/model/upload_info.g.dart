// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadInfo _$UploadInfoFromJson(Map<String, dynamic> json) {
  return UploadInfo(json['fileName'] as String, json['downloadUrl'] as String,
      json['token'] as String);
}

Map<String, dynamic> _$UploadInfoToJson(UploadInfo instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'downloadUrl': instance.downloadUrl,
      'token': instance.token
    };
