import 'package:flutter/material.dart';
import './full_width_button.dart';
import './profile_header_info.dart';
import '../login/login_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const SEPARATE_SIZE = 20.0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: SEPARATE_SIZE),
        ProfileHeaderInfoView(onPressed: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) => LoginPage()));
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
          ]
    );
  }
}