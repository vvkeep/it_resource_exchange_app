import 'package:json_annotation/json_annotation.dart'; 

part 'cate_info.g.dart';


@JsonSerializable()
  class CateInfo extends Object {

  @JsonKey(name: 'cateId')
  int cateId;

  @JsonKey(name: 'orderIndex')
  int orderIndex;

  @JsonKey(name: 'cateTitle')
  String cateTitle;

  @JsonKey(name: 'cateStatus')
  int cateStatus;


  CateInfo(this.cateId,this.orderIndex,this.cateTitle,this.cateStatus,);

  factory CateInfo.fromJson(Map<String, dynamic> srcJson) => _$CateInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CateInfoToJson(this);

}