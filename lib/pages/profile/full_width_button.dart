import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppColors, AppSize, Constant;

class FullWidthButton extends StatelessWidget {
  static const HORIZONTAL_PADDING= 20.0;
  static const VERTICAL_PADDING = 13.0;

  const FullWidthButton({
    @required this.title,
    @required this.iconData,
    @required this.onPressed,
    this.showDivider: false,
  }) : assert(iconData != null),
       assert(title != null),
       assert(onPressed != null);

  final String title;
  final IconData iconData;
  final bool showDivider;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final pureButton = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
            iconData,
            size: 24.0, 
            color: AppColors.PrimaryColor,
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
            color: AppColors.ArrowNormalColor,
        ),
      ],
    );

    final borderButton = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.DividerColor, width: AppSize.DividerWidth)
        ),
      ),
      padding: EdgeInsets.only(bottom: VERTICAL_PADDING),
      child: pureButton,
    );

    return FlatButton(
      onPressed: this.onPressed,
      padding: EdgeInsets.only(
        left: HORIZONTAL_PADDING, 
        right: HORIZONTAL_PADDING, 
        top: VERTICAL_PADDING, bottom: showDivider ? 0.0 : VERTICAL_PADDING),
      color: Colors.white,
      child: showDivider ? borderButton : pureButton,
    );
  }
}