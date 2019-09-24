import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:it_resource_exchange_app/routes/it_router.dart';
import 'package:it_resource_exchange_app/routes/routes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:it_resource_exchange_app/widgets/indicator_factory.dart';
import 'package:it_resource_exchange_app/pages/classify/classify_item_view.dart';
import 'package:it_resource_exchange_app/model/cate_info.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/model/page_result.dart';
import "package:it_resource_exchange_app/model/home_info.dart";
import 'package:it_resource_exchange_app/widgets/load_state_layout_widget.dart';

class ClassifyListView extends StatefulWidget {
  final CateInfo cate;

  ClassifyListView(this.cate);

  @override
  _ClassifyListViewState createState() => _ClassifyListViewState();
}

class _ClassifyListViewState extends State<ClassifyListView>
    with AutomaticKeepAliveClientMixin {
  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  RefreshController _refreshController;

  PageResult pageResult;
  List<RecommendProductList> productList = [];

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    loadData();
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
        loadData(loadMore: false);
      },
      onLoading: () {
        loadData(loadMore: true);
      },
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ClassifyItemView(
            recomendProduct: productList[index],
            onPressed: () {
              int productId = productList[index].productId;
              ITRouter.push(context, Routes.productDetailPage, {'productId': productId});
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      child: LoadStateLayout(
        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          this.loadData();
        },
        successWidget: _buildRefreshListView(),
      ),
    );
  }

  void loadData({bool loadMore = false}) {
    int page = (pageResult == null || loadMore == false)
        ? 1
        : pageResult.currentPage + 1;
    NetworkUtils.requestProductListByCateId(this.widget.cate.cateId, page)
        .then((res) {
      if (res.status == 200) {
        pageResult = PageResult.fromJson(res.data);
        if (!this.mounted) {
          return;
        }
        if (loadMore) {
          if (pageResult.items.length > 0) {
            var tempList = pageResult.items
                .map((m) => RecommendProductList.fromJson(m))
                .toList();
            productList.addAll(tempList);
            _refreshController.loadComplete();
          } else {
            _refreshController.loadNoData();
          }
          setState(() {});
        } else {
          if (pageResult.items.length == 0) {
            setState(() {
              _layoutState = LoadState.State_Empty;
            });
          } else {
            productList = pageResult.items
                .map((m) => RecommendProductList.fromJson(m))
                .toList();
            _refreshController.refreshCompleted();
            setState(() {
              _layoutState = LoadState.State_Success;
            });
          }
        }
      } else {
        //请求失败
        if (loadMore) {
          _refreshController.loadComplete();
          setState(() {});
        } else {
          _refreshController.refreshFailed();
          setState(() {
            _layoutState = loadStateByErrorCode(res.status);
          });
        }
      }
    });
  }
}
