import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/global_config.dart' show AppColors, AppSize, Constant;

class FullWidthButton extends StatelessWidget {
  static const HORIZONTAL_PADDING= 20.0;
  static const VERTICAL_PADDING = 13.0;

  const FullWidthButton({
    @required this.title,
    @required this.iconPath,
    @required this.onPressed,
    this.showDivider: false,
  }) : assert(iconPath != null),
       assert(title != null),
       assert(onPressed != null);

  final String title;
  final String iconPath;
  final bool showDivider;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final pureButton = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          iconPath,
          width: 24.0,
          height: 24.0,
        ),
        SizedBox(width: HORIZONTAL_PADDING),
        Expanded(
          child: Text(title, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),),
        ),
        Icon(
            IconData(
              0xe664,
              fontFamily: Constant.IconFontFamily,
            ),
            size: 22.0, 
            color: Color(AppColors.ArrowNormalColor),
          ),
      ],
    );

    final borderButton = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(AppColors.DividerColor), width: AppSize.DividerWidth)
        ),
      ),
      padding: EdgeInsets.only(bottom: VERTICAL_PADDING),
      child: pureButton,
    );

    return FlatButton(
      onPressed: (){

      },
      padding: EdgeInsets.only(
        left: HORIZONTAL_PADDING, 
        right: HORIZONTAL_PADDING, 
        top: VERTICAL_PADDING, bottom: showDivider ? 0.0 : VERTICAL_PADDING),
      color: Colors.white,
      child: showDivider ? borderButton : pureButton,
    );
  }
}