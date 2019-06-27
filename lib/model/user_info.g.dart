// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
      json['userId'] as int,
      json['nickname'] as String,
      json['account'] as String,
      json['intro'] as String,
      json['token'] as String,
      json['expireTime'] as int,
      json['userRole'] as int,
      json['avatar'] as String);
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'account': instance.account,
      'intro': instance.intro,
      'token': instance.token,
      'expireTime': instance.expireTime,
      'userRole': instance.userRole,
      'avatar': instance.avatar
    };
