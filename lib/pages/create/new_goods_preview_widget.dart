import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors, APPIcons, Constant;
import 'package:it_resource_exchange_app/vo/new_product_vo.dart'
    show NewProductImgVo;
import 'package:cached_network_image/cached_network_image.dart';

class NewGoodsPreviewWidget extends StatefulWidget {
  const NewGoodsPreviewWidget(
      {Key key,
      this.imgVoList,
      this.onPressed,
      this.removePressd,
      this.addPressd})
      : super(key: key);

  final List<NewProductImgVo> imgVoList;
  final VoidCallback onPressed;
  final ValueChanged<int> removePressd;
  final VoidCallback addPressd;

  @override
  _NewGoodsPreviewWidgetState createState() => _NewGoodsPreviewWidgetState();
}

class _NewGoodsPreviewWidgetState extends State<NewGoodsPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    var itemSpace = 8.0;

    var itemWidth = ((screenWidth - 2 * 30.0) - 4 * itemSpace) / 3.0;

    Widget addWidget = GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.DividerColor, width: AppSize.DividerWidth),
          borderRadius: BorderRadius.circular(itemSpace),
        ),
        child: Icon(
          APPIcons.AddImgData,
          size: itemWidth.toInt().toDouble() - 2 * AppSize.DividerWidth,
          color: AppColors.PrimaryColor,
        ),
      ),
      onTap: () {
        this.widget.addPressd();
      },
    );

    List<Widget> previewList = [];
    if (this.widget.imgVoList.length < 6) {
      previewList.add(addWidget);
    }

    var itemList = this.widget.imgVoList.map((imgVo) {
      // 删除按钮
      Positioned removeBtn = Positioned(
        right: -5,
        top: -5,
        child: IconButton(
            icon: Icon(IconData(
              0xe622,
              fontFamily: Constant.IconFontFamily,
            )),
            onPressed: () {
              int index = this.widget.imgVoList.indexOf(imgVo);
              this.widget.removePressd(index);
            }),
      );

      Widget imgWidget;
      if (imgVo.url == null) {
        imgWidget = AssetThumb(
            asset: imgVo.asset,
            width: itemWidth.toInt(),
            height: itemWidth.toInt());
      } else {
        imgWidget = CachedNetworkImage(
          imageUrl: imgVo.url,
          placeholder: (context, url) {
            return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.BackgroundColor,
                        width: AppSize.DividerWidth),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  width: itemWidth.toInt().toDouble(),
                  height: itemWidth.toInt().toDouble(),
                  child: Center(
                    child: Icon(
                      APPIcons.AddImgData,
                      color: AppColors.PrimaryColor,
                      size: 25,
                    ),
                  ),
                );
          },
          fit: BoxFit.cover,
          height: itemWidth.toInt().toDouble(),
          width: itemWidth.toInt().toDouble(),
          errorWidget: (context, url, error) => new Icon(Icons.error),
        );
      }

      return Stack(
        overflow: Overflow.clip,
        children: <Widget>[imgWidget, removeBtn],
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
        children: previewList,
      ),
    );
  }
}
