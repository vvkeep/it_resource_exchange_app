import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/model/cate_info.dart';

/// 颜色
class AppColors {
  static const PrimaryColor = Color(0xff2944CC);
  static const DividerColor = Color(0xffd9d9d9);
  static const ArrowNormalColor = Color(0xff999999);
  static const BackgroundColor = Color(0xffebebeb);
  static const DarkTextColor = Color(0xFF333333);
  static const MidTextColor = Color(0xFF666666);
  static const LightTextColor = Color(0xFF999999);
  static const DisableTextColor = Color(0xFFDCDCDC);
}

class AppSize {
  static const DividerWidth = 0.5;
}

class Constant {
  static const IconFontFamily = "appIconFont";
  static final movieCateInfoList = [
    CateInfo(1, 0, '动作', 0),
    CateInfo(2, 0, '喜剧', 0),
    CateInfo(3, 0, '爱情', 0),
    CateInfo(4, 0, '科幻', 0),
    CateInfo(5, 0, '恐怖', 0),
    CateInfo(6, 0, '剧情', 0),
    CateInfo(7, 0, '战争', 0),
    CateInfo(8, 0, '伦理', 0),
    CateInfo(9, 0, '奇幻', 0)
  ];
}

class APPConfig {
  static const DEBUG = false;
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
    color: AppColors.ArrowNormalColor,
  );

  static const AvatarData = IconData(
    0xe642,
    fontFamily: Constant.IconFontFamily,
  );

  static const AddImgData = IconData(
    0xe70a,
    fontFamily: Constant.IconFontFamily,
  );

  static const ProfileListImgData = IconData(
    0xe64d,
    fontFamily: Constant.IconFontFamily,
  );

  static const ProfileAddImgData = IconData(
    0xe60c,
    fontFamily: Constant.IconFontFamily,
  );

  static const ProfileSettingImgData = IconData(
    0xe615,
    fontFamily: Constant.IconFontFamily,
  );

  static const EmptyData = IconData(
    0xe643,
    fontFamily: Constant.IconFontFamily,
  );

  static const NetworkErrorData = IconData(
    0xe86e,
    fontFamily: Constant.IconFontFamily,
  );

  static const CollectionData = IconData(
    0xe616,
    fontFamily: Constant.IconFontFamily,
  );

  static const CollectSelectData = IconData(
    0xe600,
    fontFamily: Constant.IconFontFamily,
  );

  static const VideoData = IconData(
    0xe60d,
    fontFamily: Constant.IconFontFamily,
  );
}
