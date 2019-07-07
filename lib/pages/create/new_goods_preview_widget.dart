import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors, APPIcons;

class NewGoodsPreviewWidget extends StatefulWidget {
  const NewGoodsPreviewWidget(
      {Key key, this.imgUrls, this.assets, this.onPressed, this.removePressd, this.addPressd})
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

    var itemSpace = 8.0;

    var itemWidth = ((ScreenWidth - 2 * 30.0) - 2 * itemSpace)/3.0;

    Widget addWidget = GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.DividerColor, width: AppSize.DividerWidth),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          APPIcons.AddImgData,
          size: itemWidth,
          color: AppColors.PrimaryColor,
        ),
      ),
      onTap: () {
        this.widget.addPressd();
      },
    );


    var previewList = [addWidget];

    var itemList = this.widget.assets.map((asset) {
      return AssetThumb(asset: asset, width: itemWidth.toInt(), height: itemWidth.toInt());
    }).toList();

    previewList.insertAll(0, itemList);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.DividerColor, width: AppSize.DividerWidth),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      width: double.infinity,
      height: 200,
      child: Wrap(
        spacing: itemSpace,
        runSpacing: itemSpace,
        children: previewList,
      ),
    );
  }
}
