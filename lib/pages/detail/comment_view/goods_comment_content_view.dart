import 'package:flutter/material.dart';

import 'goods_comment_item_view.dart';
import 'goods_comment_reply_view.dart';

class GoodsCommentContentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: GoodsCommentItemView(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, int index) {
              return GoodsCommentReplyView();
            },
            childCount: 3,
          ),
        )
      ],
    );
  }
}
