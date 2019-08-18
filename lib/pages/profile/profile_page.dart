import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:it_resource_exchange_app/route/it_router.dart';
import 'package:it_resource_exchange_app/route/routes.dart';

import './full_width_button.dart';
import './profile_header_info.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import '../../net/network_utils.dart';
import '../../model/user_info.dart';
import '../../utils/user_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:it_resource_exchange_app/pages/create/new_goods_page.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show APPIcons;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const SEPARATE_SIZE = 20.0;
  logout() {
    UserInfo userInfo = UserUtils.getUserInfo();
    NetworkUtils.logout(userInfo.userId.toString()).then((res) {
      if (res.status == 200) {
        UserUtils.removeUserInfo();
        // 保存成功，跳转到登录页面
        ITRouter.push(context, Routes.loginPage, {}, clearStack: true, transition: TransitionType.nativeModal);
      } else {
        showToast(res.message, duration: Duration(milliseconds: 1500));
      }
    });
  }

  Widget _buildLogoutBtn() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 12),
        color: AppColors.PrimaryColor,
        textColor: Colors.white,
        disabledColor: AppColors.DisableTextColor,
        onPressed: () {
          showDialog<Null>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text('提示'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('确定要退出登录吗?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('确定'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      logout();
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text('取消'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Text(
          '退出登录',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      ProfileHeaderInfoView(onPressed: () {
        //跳转到个人信息页面
      }),
      SizedBox(height: SEPARATE_SIZE),
      FullWidthButton(
        iconData: APPIcons.ProfileListImgData,
        title: '资源列表',
        showDivider: true,
        onPressed: () {
          ITRouter.push(context, Routes.myProductListPage, {});
        },
      ),
      FullWidthButton(
        iconData: APPIcons.ProfileAddImgData,
        title: '发布资源',
        showDivider: false,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewGoodsPage()));
        },
      ),
      // SizedBox(height: SEPARATE_SIZE),
      // FullWidthButton(
      //   iconData: APPIcons.ProfileSettingImgData,
      //   title: '设置',
      //   showDivider: false,
      //   onPressed: () {},
      // ),
      SizedBox(height: 100),
      _buildLogoutBtn()
    ]);
  }
}
