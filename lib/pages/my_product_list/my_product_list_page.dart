import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/route/it_router.dart';
import 'package:it_resource_exchange_app/route/routes.dart';
import 'package:it_resource_exchange_app/utils/user_utils.dart';
import 'package:it_resource_exchange_app/model/product_detail.dart';
import './my_product_item_view.dart';
import 'package:it_resource_exchange_app/widgets/load_state_layout_widget.dart';

class MyProductListPage extends StatefulWidget {
  @override
  _MyProductListPageState createState() => _MyProductListPageState();
}

class _MyProductListPageState extends State<MyProductListPage> {
  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;
  List<ProductDetail> productList = [];

  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    var userId = UserUtils.getUserInfo().userId;
    NetworkUtils.requestMyProductListData(userId).then((res) {
      if (res.status == 200) {
        productList =
            (res.data as List).map((m) => ProductDetail.fromJson(m)).toList();
        setState(() {
          _layoutState = LoadState.State_Success;
        });
      } else {
        setState(() {
          _layoutState = loadStateByErrorCode(res.status);
        });
      }
    });
  }

  _buildListView() {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return MyProductItemView(
          product: productList[index],
          onPressed: () {
            ProductDetail product = productList[index];
            ITRouter.push(context, Routes.newProductPage,{'productId': product.productId}).then((res) {
              if (res) {
                this.loadData();
                setState(() {
                  _layoutState = LoadState.State_Loading;
                });
              }
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "我的资源",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: LoadStateLayout(
        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          this.loadData();
        },
        successWidget: _buildListView(),
      ),
    );
  }
}
