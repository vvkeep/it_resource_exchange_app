import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors, APPIcons;

class NewGoodsPreviewWidget extends StatefulWidget {
  const NewGoodsPreviewWidget(
      {Key key, this.imgUrls, this.assets, this.onPressed, this.removePressd})
      : super(key: key);

  final List<Asset> imgUrls;
  final List<Asset> assets;
  final VoidCallback onPressed;
  final VoidCallback removePressd;
  final VoidCallback addPressd;

  @override
  _NewGoodsPreviewWidgetState createState() => _NewGoodsPreviewWidgetState();
}

class _NewGoodsPreviewWidgetState extends State<NewGoodsPreviewWidget> {
  @override
  Widget build(BuildContext context) {

    final ScreenWidth = MediaQuery.of(context).size.width;

    Widget addWidget = GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.DividerColor, width: AppSize.DividerWidth),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          APPIcons.AddImgData,
          size: 80,
          color: AppColors.PrimaryColor,
        ),
      ),
      onTap: () {
        this.widget.addPressd();
      },
    );

    return Container();
  }
}
