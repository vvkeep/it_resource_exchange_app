import 'package:flutter/material.dart';
import './full_width_button.dart';
import './profile_header_info.dart';
import '../login/login_page.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import '../../net/network_utils.dart';
import '../../model/user_info.dart';
import '../../utils/user_utils.dart';
import '../home/home_page.dart';
import 'package:oktoast/oktoast.dart';

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
        Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context) => LoginPage()));
      }else {
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
          logout();
        },
        child: new Text(
          '退出登录',
          style: new TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      SizedBox(height: SEPARATE_SIZE),
      ProfileHeaderInfoView(onPressed: () { //跳转到个人信息页面

      }),
      SizedBox(height: SEPARATE_SIZE),
      FullWidthButton(
        iconPath: 'assets/imgs/ic_cards_wallet.png',
        title: '订单',
        showDivider: true,
        onPressed: () {},
      ),
      FullWidthButton(
        iconPath: 'assets/imgs/ic_collections.png',
        title: '收藏',
        showDivider: true,
        onPressed: () {},
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
