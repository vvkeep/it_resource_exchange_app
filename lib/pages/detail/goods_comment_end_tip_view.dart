import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart';

class GoodsCommentEndTipView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: AppSize.DividerWidth,
            color: AppColors.DividerColor,
          ),
        ),
      ),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('- End -', style: TextStyle(color: AppColors.LightTextColor),),
        ],
      ),
    );
  }
}