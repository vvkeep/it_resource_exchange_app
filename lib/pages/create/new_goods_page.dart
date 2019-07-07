import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors, APPIcons;
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'new_goods_cover_view.dart';
import 'new_goods_text_field.dart';

class NewGoodsPage extends StatefulWidget {
  @override
  _NewGoodsPageState createState() => _NewGoodsPageState();
}

class _NewGoodsPageState extends State<NewGoodsPage> {
  List _fruits = ["Apple", "Banana", "Pineapple", "Mango", "Grapes"];
  String _selectedFruit;

  Image coverImg;

  List<Widget> previewList = [];

  @override
  void initState() {
    super.initState();

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
          addPrewImgs();
        });

    previewList.add(addWidget);

    setState(() {});
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
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
        spacing: 8.0,
        runSpacing: 8.0,
        children: this.previewList,
      ),
    );
  }

  void addPrewImgs() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(maxImages: 4);
    } on PlatformException catch (e) {
      error = e.message;
    }

    if (!mounted) return;

    setState(() {
      var list = resultList.map((asset) {
        return AssetThumb(asset: asset, width: 80, height: 80);
      }).toList();
      this.previewList.addAll(list);
    });
  }

  void showChoosePhotoAlertSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.photo_camera),
                title: new Text("相机"),
                onTap: () async {
                  Navigator.of(context).pop();
                  File coverFile =
                      await ImagePicker.pickImage(source: ImageSource.camera);
                  setState(() {
                    this.coverImg = Image.file(coverFile,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity);
                  });
                },
              ),
              Divider(),
              ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text("相册"),
                onTap: () async {
                  Navigator.of(context).pop();
                  File coverFile =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    this.coverImg = Image.file(coverFile,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity);
                  });
                },
              ),
              Divider(),
              ListTile(
                leading: new Icon(Icons.cancel),
                title: new Text("取消"),
                onTap: () async {
                  Navigator.of(context).pop();
                },
              ),
              Divider(),
            ],
          );
        });
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
                SizedBox(height: 5),
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
