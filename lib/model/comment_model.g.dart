// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return CommentModel(
      json['content'] as String,
      json['createdTime'] as int,
      json['userId'] as int,
      json['nickname'] as String,
      json['productId'] as int,
      (json['commentList'] as List)
          ?.map((e) => e == null
              ? null
              : CommentModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['commentId'] as int,
      json['parentCommentId'] as int);
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'createdTime': instance.createdTime,
      'userId': instance.userId,
      'nickname': instance.nickname,
      'productId': instance.productId,
      'commentList': instance.commentList,
      'commentId': instance.commentId,
      'parentCommentId': instance.parentCommentId
    };
