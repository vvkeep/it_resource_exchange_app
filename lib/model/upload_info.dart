import 'package:json_annotation/json_annotation.dart'; 
  
part 'upload_info.g.dart';


@JsonSerializable()
  class UploadInfo extends Object {

  @JsonKey(name: 'fileName')
  String fileName;

  @JsonKey(name: 'downloadUrl')
  String downloadUrl;

  @JsonKey(name: 'token')
  String token;

  UploadInfo(this.fileName,this.downloadUrl,this.token,);

  factory UploadInfo.fromJson(Map<String, dynamic> srcJson) => _$UploadInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UploadInfoToJson(this);

}
