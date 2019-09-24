import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/model/comment_model.dart';
import 'package:it_resource_exchange_app/utils/user_utils.dart';
import 'package:it_resource_exchange_app/vo/comment_vo.dart';

import 'goods_comment_item_view.dart';
import 'goods_comment_reply_view.dart';

class GoodsCommentContentView extends StatelessWidget {
  final CommentModel commentModel;

  final ValueChanged<CommentVO> tapCallback;

  const GoodsCommentContentView({Key key, this.commentModel, this.tapCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: GestureDetector(
            child: GoodsCommentItemView(
              commentModel: commentModel,
            ),
            onTap: UserUtils.getUserInfo().userId != this.commentModel.createUserId ?  () {
              this.tapCallback(CommentVO(index: -1, commentModel: commentModel));
            } : null,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, int index) {
              return GestureDetector(
                child: GoodsCommentReplyView(commentModel: this.commentModel.commentList[index],),
                onTap: UserUtils.getUserInfo().userId != this.commentModel.commentList[index].createUserId ? () {
                  this.tapCallback(CommentVO(index: index, commentModel: commentModel));
                } : null,
              );
            },
            childCount: commentModel.commentList?.length ?? 0,
          ),
        )
      ],
    );
  }
}
