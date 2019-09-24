import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/model/collect_product_info.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/routes/it_router.dart';
import 'package:it_resource_exchange_app/routes/routes.dart';
import 'package:it_resource_exchange_app/model/product_detail.dart';
import '../my_product_list/my_product_item_view.dart';
import 'package:it_resource_exchange_app/widgets/load_state_layout_widget.dart';

import 'my_collection_item_view.dart';

class MyCollectionListPage extends StatefulWidget {
  @override
  _MyCollectionListPageState createState() => _MyCollectionListPageState();
}

class _MyCollectionListPageState extends State<MyCollectionListPage> {
  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;
  List<CollectProductInfo> productList = [];

  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    NetworkUtils.requestMyCollectionListData().then((res) {
      if (res.status == 200) {
        productList = (res.data as List)
            .map((m) => CollectProductInfo.fromJson(m))
            .toList();
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
        return MyCollectionItemView(
          product: productList[index],
          onPressed: () {
            CollectProductInfo product = productList[index];
            int productId = product.productId;
            ITRouter.push(
                context, Routes.productDetailPage, {'productId': productId});
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
          "我的收藏",
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
