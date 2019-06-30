import 'package:flutter/material.dart';

/// 颜色
class AppColors {
  static const PrimaryColor = Colors.cyan;
  static const DividerColor = Color(0xffd9d9d9);
  static const ArrowNormalColor = 0xff999999;
  static const BackgroundColor = 0xffebebeb;
  static const DarkTextColor = Color(0xFF333333);
  static const MidTextColor = Color(0xFF666666);
  static const LightTextColor = Color(0xFF999999);
}

class AppSize {
  static const DividerWidth = 0.5;
}

class Constant {
  static const IconFontFamily = "appIconFont";
}

class APPConfig {
  static const DEBUG = true;
  static const Server = "http://47.107.231.54:8090";
  // static const Server = "http://localhost:8090";
}

class APPIcons {
  static const PlaceHolderAvatar = Icon(
    IconData(
      0xe642,
      fontFamily: Constant.IconFontFamily,
    ),
    size: 60.0,
    color: Color(AppColors.ArrowNormalColor),
  );

  static const AddImgData = IconData(
      0xe70a,
      fontFamily: Constant.IconFontFamily,
    );

}
