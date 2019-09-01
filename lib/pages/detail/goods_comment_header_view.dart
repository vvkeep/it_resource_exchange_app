import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart';

class GoodsCommentHeaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '共 888 条评论',
              style: TextStyle(
                  color: AppColors.DarkTextColor, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
