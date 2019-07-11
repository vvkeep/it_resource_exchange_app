import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors, APPIcons;
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'new_goods_cover_view.dart';
import 'new_goods_text_field.dart';
import 'new_goods_preview_widget.dart';
// import 'package:sy_flutter_qiniu_storage/sy_flutter_qiniu_storage.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/model/page_result.dart';
import '../../widgets/choose_img_modal_sheet.dart';

class NewGoodsPage extends StatefulWidget {
  @override
  _NewGoodsPageState createState() => _NewGoodsPageState();
}

class _NewGoodsPageState extends State<NewGoodsPage> {
  List _fruits = ["Apple", "Banana", "Pineapple", "Mango", "Grapes"];
  String _selectedFruit;

  Image coverImg;

  List<Asset> assetList = [];

  @override
  void initState() {
    super.initState();
  }

  List<DropdownMenuItem> _dropDownMenuItems() {
    return _fruits.map((fruit) {
      return DropdownMenuItem(value: fruit, child: Text(fruit));
    }).toList();
  }

  Widget _buildTitleField() {
    return NewGoodsTextField(
      hintText: "请输入标题",
      onChanged: (string) {},
    );
  }

  Widget _buildPriceField() {
    return NewGoodsTextField(
      hintText: "请输入价格",
      onChanged: (string) {},
    );
  }

  Widget _buildResourceUrlField() {
    return NewGoodsTextField(
      hintText: "请输入资源地址",
      onChanged: (string) {},
    );
  }

  Widget _buildResourcePasswordField() {
    return NewGoodsTextField(
      hintText: "请输入资源密码",
      onChanged: (string) {},
    );
  }

  Widget _buildDescField() {
    return TextField(
      decoration: InputDecoration(
          hintText: '请输入产品描述',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: AppColors.DividerColor,
              width: AppSize.DividerWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: AppColors.PrimaryColor,
            width: AppSize.DividerWidth,
          ))),
      maxLines: 6,
    );
  }

  Widget _buildChooseCategoryView() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: AppSize.DividerWidth,
            color: AppColors.DividerColor,
          ),
        ),
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "请选择",
            style: TextStyle(fontSize: 17, color: AppColors.MidTextColor),
          ),
          DropdownButton(
              hint: Text('产品分类'),
              iconSize: 35,
              value: _selectedFruit,
              items: _dropDownMenuItems(),
              onChanged: (selectedFruit) {
                setState(() {
                  _selectedFruit = selectedFruit;
                });
              })
        ],
      ),
    );
  }

  Widget _buildPreviewWidget() {
    return NewGoodsPreviewWidget(
      imgUrls: null,
      assets: this.assetList,
      onPressed: () {},
      removePressd: (index) {
        assetList.removeAt(index);
        setState(() {});
      },
      addPressd: () {
        this.addPrewImgs();
      },
    );
  }

  void addPrewImgs() async {
    String error;

    try {
      List<Asset> tempList = await MultiImagePicker.pickImages(
          maxImages: 6 - this.assetList.length);
      assetList.insertAll(0, tempList);
    } on PlatformException catch (e) {
      error = e.message;
      print(error);
    }

    if (!mounted) return;

    setState(() {});
  }

  void uploadImg(Asset asset) async {
    NetworkUtils.uploadToken().then((res) {
      if (res.status == 200) {
        var pageResult = PageResult.fromJson(res.data);
      }
    });
  }

  void showChoosePhotoAlertSheet() {
    showChooseImgModalSheet(context, ((file) {
      if (file != null) {
        setState(() {
          this.coverImg = Image.file(file,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity);
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    var coverView = NewGoodsCoverView(
        imgUrl: null,
        localImg: coverImg,
        onPressed: () {
          showChoosePhotoAlertSheet();
        },
        removePressd: () {
          setState(() {
            this.coverImg = null;
          });
        });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "发布资源",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                coverView,
                SizedBox(height: 8),
                _buildChooseCategoryView(),
                _buildTitleField(),
                _buildPriceField(),
                _buildResourceUrlField(),
                _buildResourcePasswordField(),
                SizedBox(height: 10),
                _buildDescField(),
                SizedBox(height: 10),
                _buildPreviewWidget(),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
