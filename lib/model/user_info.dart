import 'package:json_annotation/json_annotation.dart'; 
  
part 'user_info.g.dart';


@JsonSerializable()
  class UserInfo extends Object {

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'account')
  String account;

  @JsonKey(name: 'intro')
  String intro;

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'expireTime')
  int expireTime;

  @JsonKey(name: 'userRole')
  int userRole;

  @JsonKey(name: 'avatar')
  String avatar;

  UserInfo(this.userId,this.nickname,this.account,this.intro,this.token,this.expireTime,this.userRole,this.avatar,);

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) => _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

}

  
