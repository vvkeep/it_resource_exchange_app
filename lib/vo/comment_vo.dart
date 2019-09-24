import 'package:it_resource_exchange_app/model/comment_model.dart';

class CommentVO extends Object {
  int index = -1; // -1 点击的是评论， 其他值为回复
  CommentModel commentModel;

  CommentVO({this.index, this.commentModel});
}