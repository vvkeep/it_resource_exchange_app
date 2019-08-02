import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
class MaxApiTimesTipPage extends StatefulWidget {
  @override
  _MaxApiTimesTipPageState createState() => _MaxApiTimesTipPageState();
}

class _MaxApiTimesTipPageState extends State<MaxApiTimesTipPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("请求次数已经超过次数限制,请稍后再试~", style: TextStyle(fontSize: 16, color: AppColors.DarkTextColor),),
              Text("为了保证服务器的正产运行，对接口进行了24小时500次的访问限制~", style: TextStyle(fontSize: 12, color: AppColors.LightTextColor),),
            ],
          ),
        ),
    );
  }
}