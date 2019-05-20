import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:it_resource_exchange_app/widgets/indicator_factory.dart';
import 'package:it_resource_exchange_app/pages/home/goods_item_view.dart';
import 'package:it_resource_exchange_app/model/cate_info.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/model/page_result.dart';
import "package:it_resource_exchange_app/model/home_info.dart";

class ClassifyListView extends StatefulWidget {

  final CateInfo cate;

  ClassifyListView(this.cate);

  @override
  _ClassifyListViewState createState() => _ClassifyListViewState();
}

class _ClassifyListViewState extends State<ClassifyListView> with AutomaticKeepAliveClientMixin {

  bool _isLoading = true;
  RefreshController _refreshController;

  PageResult pageResult;
  List<RecommendProductList> productList = [];

  
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _getCategoryData();
  }

  @override
  bool get wantKeepAlive => true;

  SmartRefresher _buildRefreshListView() {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      enablePullDown: true,
      header: buildDefaultHeader(),
      footer: buildDefaultFooter(),
      onRefresh: () {
        _getCategoryData(loadMore: true);
      },
      onLoading: () {
       _getCategoryData(loadMore: false);
      },
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return GoodsItemView(recomendProduct: productList[index],);
        },
      ),  
    );
  }

  Center _buildListLoadingView() {
    return Center(
        child: CupertinoActivityIndicator(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _isLoading ? _buildListLoadingView() : _buildRefreshListView(),
    );
  }

  void _getCategoryData({bool loadMore = false}) {
    NetworkUtils.requestProductListByCateId(4, 1).then((res){
        if (res.status == 200) {
          pageResult = PageResult.fromJson(res.data);

         if (loadMore) {
           if (pageResult.items.length > 0) {
            var tempList = pageResult.items.map((m) => RecommendProductList.fromJson(m)).toList();
            productList.addAll(tempList);
          }
          _refreshController.loadComplete();
         }else {
            productList = pageResult.items.map((m) => RecommendProductList.fromJson(m)).toList();
            _refreshController.refreshCompleted();
         }
          
          setState(() {
             _isLoading = false;
          });
        }else {
          if (!loadMore) {
             _refreshController.refreshFailed();
          }
        }
    });
  }
}
