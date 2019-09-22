import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:it_resource_exchange_app/common/constant.dart';

class GoodsCommentBottomBar extends StatelessWidget {

  final ValueChanged<int> btnActionCallback;
  final isCollect;

  const GoodsCommentBottomBar({Key key, this.isCollect,this.btnActionCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var collectIcon;
    if (isCollect) {
     collectIcon = Icon(
        APPIcons.CollectSelectData,
        color: AppColors.PrimaryColor,
      );
    } else {
      collectIcon = Icon(
        APPIcons.CollectionData,
        color: AppColors.ArrowNormalColor,
      );
    }

    FlatButton favoriteBtn = FlatButton.icon(
      icon: collectIcon,
      label: Text("收藏"),
      onPressed: () {
        this.btnActionCallback(100);
      },
    );

    Widget commentBtn = GestureDetector(
      onTap: () {
        this.btnActionCallback(200);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 220,
          height: 40,
          color: AppColors.DividerColor,
          child: Row(
            children: <Widget>[
              SizedBox(width: 20,),
              Text('说点什么吧',
                  style:
                      TextStyle(fontSize: 13, color: AppColors.LightTextColor)),
            ],
          ),
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: AppSize.DividerWidth,
            color: AppColors.DividerColor,
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).padding.bottom + 50,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          favoriteBtn,
          Expanded(child: SizedBox()),
          commentBtn
        ],
      ),
    );
  }
}
