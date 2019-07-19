import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './full_width_button.dart';
import './profile_header_info.dart';
import '../login/login_page.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import '../../net/network_utils.dart';
import '../../model/user_info.dart';
import '../../utils/user_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:it_resource_exchange_app/pages/create/new_goods_page.dart';
import '../../pages/myProductList/my_product_list_page.dart';

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
        Navigator.pushReplacement(
            this.context, MaterialPageRoute(builder: (context) => LoginPage()));
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
        disabledColor: AppColors.PrimaryColor[100],
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
      SizedBox(height: SEPARATE_SIZE),
      ProfileHeaderInfoView(onPressed: () {
        //跳转到个人信息页面
      }),
      SizedBox(height: SEPARATE_SIZE),
      FullWidthButton(
        iconPath: 'assets/imgs/ic_cards_wallet.png',
        title: '资源列表',
        showDivider: true,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MyProductListPage()));
        },
      ),
      FullWidthButton(
        iconPath: 'assets/imgs/ic_collections.png',
        title: '发布资源',
        showDivider: false,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewGoodsPage()));
        },
      ),
      SizedBox(height: SEPARATE_SIZE),
      FullWidthButton(
        iconPath: 'assets/imgs/ic_settings.png',
        title: '设置',
        showDivider: false,
        onPressed: () {},
      ),
      SizedBox(height: 50),
      _buildLogoutBtn()
    ]);
  }
}
