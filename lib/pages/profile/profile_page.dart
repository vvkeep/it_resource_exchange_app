import 'package:flutter/material.dart';
import './full_width_button.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppColors, AppSize, Constant;
import './profile_header_info.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const SEPARATE_SIZE = 20.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(AppColors.BackgroundColor),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: SEPARATE_SIZE),
            ProfileHeaderInfoView(),
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
          ],
        ),
      ),
    );
  }
}