import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors, APPIcons, Constant;

class NewGoodsPreviewWidget extends StatefulWidget {
  const NewGoodsPreviewWidget(
      {Key key, this.imgUrls, this.assets, this.onPressed, this.removePressd, this.addPressd})
      : super(key: key);

  final List<Asset> imgUrls;
  final List<Asset> assets;
  final VoidCallback onPressed;
  final ValueChanged<int> removePressd;
  final VoidCallback addPressd;

  @override
  _NewGoodsPreviewWidgetState createState() => _NewGoodsPreviewWidgetState();
}

class _NewGoodsPreviewWidgetState extends State<NewGoodsPreviewWidget> {
  @override
  Widget build(BuildContext context) {

    final ScreenWidth = MediaQuery.of(context).size.width;

    var itemSpace = 8.0;

    var itemWidth = ((ScreenWidth - 2 * 30.0) - 4 * itemSpace)/3.0;

    Widget addWidget = GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.DividerColor, width: AppSize.DividerWidth),
          borderRadius: BorderRadius.circular(itemSpace),
        ),
        child: Icon(
          APPIcons.AddImgData,
          size: itemWidth.toInt().toDouble() -  2 * AppSize.DividerWidth,
          color: AppColors.PrimaryColor,
        ),
      ),
      onTap: () {
        this.widget.addPressd();
      },
    );

    List<Widget> previewList = [];
    if (this.widget.assets.length < 6) {
      previewList.add(addWidget);
    }

    var itemList = this.widget.assets.map((asset) {
      Positioned removeBtn = Positioned(
      right: -5,
      top: -5,
      child: IconButton(
        icon: Icon(IconData(
          0xe622,
          fontFamily: Constant.IconFontFamily,
        )),
        onPressed: () {
          int index = this.widget.assets.indexOf(asset);
          this.widget.removePressd(index);
        }
      ),
    );

    return Stack(
        overflow: Overflow.clip,
        children: <Widget>[
           AssetThumb(asset: asset, width: itemWidth.toInt(), height: itemWidth.toInt()),
          removeBtn
        ],
      );
    }).toList();

    previewList.insertAll(0, itemList);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.DividerColor, width: AppSize.DividerWidth),
        borderRadius: BorderRadius.circular(itemSpace),
      ),
      padding: EdgeInsets.symmetric(horizontal: itemSpace, vertical: itemSpace),
      width: double.infinity,
      height: 3 * itemSpace + itemWidth * 2,
      child: Wrap(
        spacing: itemSpace,
        runSpacing: itemSpace,
        children: 
        previewList,
      ),
    );
  }
}
