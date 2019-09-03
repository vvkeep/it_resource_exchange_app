import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:it_resource_exchange_app/common/constant.dart';

class GoodsCommentBottomBar extends StatelessWidget {

  final ValueChanged<int> btnActionCallback;

  const GoodsCommentBottomBar({Key key, this.btnActionCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlatButton favoriteBtn = FlatButton.icon(
      icon: Icon(
        Icons.favorite_border,
        color: Colors.grey[800],
      ),
      label: Text("收藏"),
      onPressed: () {
        this.btnActionCallback(100);
        print("喜欢");
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
