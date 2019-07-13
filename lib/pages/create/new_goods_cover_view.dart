
import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors, APPIcons, Constant;
import 'package:cached_network_image/cached_network_image.dart';

class NewGoodsCoverView extends StatefulWidget {
  NewGoodsCoverView({Key key, this.imgUrl, this.localImg, this.onPressed, this.removePressd})
      : super(key: key);

  final String imgUrl;
  final Image localImg;
  final VoidCallback onPressed;
  final VoidCallback removePressd;

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
    Positioned removeBtn = Positioned(
      right: 5,
      top: 0,
      child: IconButton(
        icon: Icon(IconData(
          0xe622,
          fontFamily: Constant.IconFontFamily,
        )),
        onPressed: this.widget.removePressd,
      ),
    );

    Widget coverWidget;
    if (this.widget.imgUrl != null) {
      coverWidget = Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: this.widget.imgUrl,
            placeholder: (context, url) => APPIcons.PlaceHolderAvatar,
            fit: BoxFit.cover,
          ),
          removeBtn
        ],
      );
    } else if (this.widget.localImg != null) {
      coverWidget = Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          this.widget.localImg,
          removeBtn
        ],
      );
    } else {
      coverWidget = Column(
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
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.DividerColor, width: AppSize.DividerWidth),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 220,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: coverWidget,
        ),
      ),
    );
  }
}
