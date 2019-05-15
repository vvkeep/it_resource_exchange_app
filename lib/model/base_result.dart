import 'package:json_annotation/json_annotation.dart';
part 'base_result.g.dart';

@JsonSerializable()
class BaseResult {
    var data;
    int status;
    String message;

    BaseResult(this.data, this.status, this.message);

    factory BaseResult.fromJson(Map<String,dynamic> json)  => _$BaseResultFromJson(json);
    Map<String,dynamic>  toJson()  => _$BaseResultToJson(this);
}