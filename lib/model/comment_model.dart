import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends Object {

	@JsonKey(name: 'content')
	String content;

	@JsonKey(name: 'createdTime')
	int createdTime;

	@JsonKey(name: 'createUserId')
	int createUserId;

  @JsonKey(name: 'createUserName')
	String createUserName;

  @JsonKey(name: 'createUserAvatar')
	String createUserAvatar;

	@JsonKey(name: 'parentUserId')
	int parentUserId;

  @JsonKey(name: 'parentUserName')
	String parentUserName;

  @JsonKey(name: 'parentUserAvatar')
	String parentUserAvatar;

	@JsonKey(name: 'productId')
	int productId;

	@JsonKey(name: 'commentList')
	List<CommentModel> commentList;

	@JsonKey(name: 'commentId')
	int commentId;

	@JsonKey(name: 'parentCommentId')
	int parentCommentId;

	CommentModel(this.content,this.createdTime,this.createUserId,this.createUserName,this.createUserAvatar,this.parentUserId,this.parentUserName,this.parentUserAvatar,this.productId,this.commentList,this.commentId,this.parentCommentId,);

	factory CommentModel.fromJson(Map<String, dynamic> srcJson) => _$CommentModelFromJson(srcJson);

	Map<String, dynamic> toJson() => _$CommentModelToJson(this);

}