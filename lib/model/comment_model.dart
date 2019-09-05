import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends Object {

	@JsonKey(name: 'content')
	String content;

	@JsonKey(name: 'createdTime')
	int createdTime;

	@JsonKey(name: 'userId')
	int userId;

	@JsonKey(name: 'nickname')
	String nickname;

	@JsonKey(name: 'productId')
	int productId;

	@JsonKey(name: 'commentList')
	List<CommentModel> commentList;

	@JsonKey(name: 'commentId')
	int commentId;

	@JsonKey(name: 'parentCommentId')
	int parentCommentId;

	CommentModel(this.content,this.createdTime,this.userId,this.nickname,this.productId,this.commentList,this.commentId,this.parentCommentId,);

	factory CommentModel.fromJson(Map<String, dynamic> srcJson) => _$CommentModelFromJson(srcJson);

	Map<String, dynamic> toJson() => _$CommentModelToJson(this);

}