import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors, APPIcons;
import 'package:cached_network_image/cached_network_image.dart';

class NewGoodsPage extends StatefulWidget {
  @override
  _NewGoodsPageState createState() => _NewGoodsPageState();
}

class _NewGoodsPageState extends State<NewGoodsPage> {
  List _fruits = ["Apple", "Banana", "Pineapple", "Mango", "Grapes"];
  String _selectedFruit;

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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: AppSize.DividerWidth,
            color: AppColors.DividerColor,
          ),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: '请输入标题',
          border: InputBorder.none
        ),
        onChanged: (str) {},
      ),
    );
  }

  Widget _buildPriceField() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: AppSize.DividerWidth,
            color: AppColors.DividerColor,
          ),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '请输入价格',
        ),
        onChanged: (str) {},
      ),
    );
  }

  Widget _buildResourceUrlField() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: AppSize.DividerWidth,
            color: AppColors.DividerColor,
          ),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '请输入资源地址',
        ),
        onChanged: (str) {},
      ),
    );
  }

  Widget _buildResourcePasswordField() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: AppSize.DividerWidth,
            color: AppColors.DividerColor,
          ),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '请输入资源密码',
        ),
        onChanged: (str) {},
      ),
    );
  }

  Widget _buildDescField() {
    return TextField(
      decoration: InputDecoration(
        hintText: '请输入产品描述',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10)
          ),
          borderSide: BorderSide(
            color: AppColors.DividerColor,
            width: AppSize.DividerWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.PrimaryColor,
            width: AppSize.DividerWidth,
          )
        )
      ),
      maxLines: 5,
    );
  }

  Widget _chooseCoverView() {
    Widget coverView;
    coverView = Icon(APPIcons.AddImgData, size: 80, color: AppColors.PrimaryColor,);
    // coverView = CachedNetworkImage(
    //               imageUrl: '',
    //               placeholder: APPIcons.PlaceHolderAvatar,
    //               fit: BoxFit.cover,
    //             );
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.DividerColor,
            width: AppSize.DividerWidth
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 300,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            coverView,
            SizedBox(height: 10),
            Text('添加封面', style: TextStyle(fontSize: 18, color: AppColors.DarkTextColor),)
          ],
        ),
      ),
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
          Text("请选择",style: TextStyle(fontSize: 17, color: AppColors.MidTextColor),),
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

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              SizedBox(height: 5),
              _buildChooseCategoryView(),
              SizedBox(height: 5),
              _buildTitleField(),
              SizedBox(height: 5),
              _buildPriceField(),
              SizedBox(height: 5),
              _buildResourceUrlField(),
              SizedBox(height: 5),
              _buildResourcePasswordField(),
              SizedBox(height: 5),
              _buildDescField(),
              SizedBox(height: 5),
              _chooseCoverView()
            ],
          ),
        ),
      ),
    );
  }
}
