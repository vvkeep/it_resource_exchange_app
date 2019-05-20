import 'package:json_annotation/json_annotation.dart'; 
  
part 'page_result.g.dart';

@JsonSerializable()
  class PageResult extends Object {

  @JsonKey(name: 'currentPage')
  int currentPage;

  @JsonKey(name: 'pageSize')
  int pageSize;

  @JsonKey(name: 'totalNum')
  int totalNum;

  @JsonKey(name: 'isMore')
  int isMore;

  @JsonKey(name: 'totalPage')
  int totalPage;

  @JsonKey(name: 'startIndex')
  int startIndex;

  @JsonKey(name: 'items')
  List<Map> items;

  PageResult(this.currentPage,this.pageSize,this.totalNum,this.isMore,this.totalPage,this.startIndex,this.items,);

  factory PageResult.fromJson(Map<String, dynamic> srcJson) => _$PageResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PageResultToJson(this);

}