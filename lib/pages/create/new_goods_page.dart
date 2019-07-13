import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'new_goods_cover_view.dart';
import 'new_goods_text_field.dart';
import 'new_goods_preview_widget.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/model/page_result.dart';
import '../../widgets/choose_img_modal_sheet.dart';
import 'package:it_resource_exchange_app/model/cate_info.dart';

class NewGoodsPage extends StatefulWidget {
  @override
  _NewGoodsPageState createState() => _NewGoodsPageState();
}

class _NewGoodsPageState extends State<NewGoodsPage> {
  List<CateInfo> cateList;
  List<DropdownMenuItem> menuItemList = [];

  CateInfo _selectedCateInfo;

  Image coverImg;

  List<Asset> assetList = [];

  @override
  void initState() {
    super.initState();
    requsetCateListData();
  }

  requsetCateListData() {
    NetworkUtils.requestCategoryListData().then((res) {
      if (res.status == 200) {
        cateList = (res.data as List).map((m) => CateInfo.fromJson(m)).toList();
        setState(() {
          menuItemList = cateList.map((cateInfo) {
            return DropdownMenuItem(
                value: cateInfo, child: Text(cateInfo.cateTitle));
          }).toList();
        });
      }
    });
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
              value: _selectedCateInfo,
              items: menuItemList,
              onChanged: (selectedCateInfo) {
                setState(() {
                  _selectedCateInfo = selectedCateInfo;
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
      assetList.addAll(tempList);
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
