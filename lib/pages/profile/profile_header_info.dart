import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/global_config.dart' show AppColors, Constant;

class ProfileHeaderInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () {
                print("点击了头部登录");
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('请先登录', style: Theme.of(context).textTheme.title.copyWith(fontSize: 20),),
                  Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: Text(
                      '此人很懒，什么都没写~',
                      style: Theme.of(context).textTheme.body1.copyWith(fontSize: 12, color: Color(0xff818181)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: ClipOval(
              child: Icon(
                IconData(
                  0xe642,
                  fontFamily: Constant.IconFontFamily,
                ),
                size: 60.0, 
                color: Color(AppColors.ArrowNormalColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}