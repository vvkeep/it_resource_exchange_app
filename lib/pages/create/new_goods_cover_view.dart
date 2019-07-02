import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors, APPIcons;

class NewGoodsCoverView extends StatefulWidget {

 NewGoodsCoverView({
   Key key, 
   this.imgUrl, 
   this.localImg,
   this.onPressed 
  }): super(key: key);

  final String imgUrl;
  final Image localImg;
  final VoidCallback onPressed;

  final Widget addTipWiget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 5),
          Icon(
            APPIcons.AddImgData,
            size: 80,
            color: AppColors.PrimaryColor,
          ),
          SizedBox(height: 10),
          Text(
            '添加封面',
            style: TextStyle(fontSize: 18, color: AppColors.DarkTextColor),
          )
        ],
      );

  @override
  _NewGoodsCoverViewState createState() => _NewGoodsCoverViewState();
}

class _NewGoodsCoverViewState extends State<NewGoodsCoverView> {
  @override
  Widget build(BuildContext context) {
    Widget coverView;
    if (this.widget.localImg != null) {
      coverView = localImg;
    } else {
      coverView = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 5),
          Icon(
            APPIcons.AddImgData,
            size: 80,
            color: AppColors.PrimaryColor,
          ),
          SizedBox(height: 10),
          Text(
            '添加封面',
            style: TextStyle(fontSize: 18, color: AppColors.DarkTextColor),
          )
        ],
      );
    }



    return GestureDetector(
      onTap: this.widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.DividerColor, width: AppSize.DividerWidth),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 220,
        width: double.infinity,
        child: coverView,
      ),
    );
  }
}