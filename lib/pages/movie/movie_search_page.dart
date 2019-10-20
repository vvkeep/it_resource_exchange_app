import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:it_resource_exchange_app/model/movie_info.dart';
import 'package:it_resource_exchange_app/model/page_result.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/routes/it_router.dart';
import 'package:it_resource_exchange_app/routes/routes.dart';
import 'package:it_resource_exchange_app/widgets/indicator_factory.dart';
import 'package:it_resource_exchange_app/widgets/load_state_layout_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'movie_list_item_view.dart';

class MovieSearchPage extends StatefulWidget {
  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  RefreshController _refreshController;

  PageResult pageResult;
  List<MovieInfo> movieList = [];

  var _keywords;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
  }

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
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return MovieListItemView(
            moive: movieList[index],
            onPressed: () {
              int movieId = movieList[index].movieId;
              ITRouter.push(context, Routes.moviePlayerPage, {'movieId': movieId});
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            height: 44,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(22)),
            child: TextField(
              focusNode: _focusNode,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                this._keywords = value;
                _focusNode.unfocus();
                _layoutState = LoadState.State_Loading;
                loadData(loadMore: false);
              },
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                height: 44,
                width: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text('退出', style: TextStyle(color: Colors.white, fontSize: 16),)],
                ),
              ),
              onTap: () {
                ITRouter.pop(context);
              },
            )
          ],
        ),
        body: _buildRefreshListView()
        );
  }

   void loadData({bool loadMore = false}) {
    int page = (pageResult == null || loadMore == false)
        ? 1
        : pageResult.currentPage + 1;
    NetworkUtils.searchMovieListByKeywords(this._keywords, page)
        .then((res) {
      if (res.status == 200) {
        pageResult = PageResult.fromJson(res.data);
        if (!this.mounted) {
          return;
        }
        if (loadMore) {
          if (pageResult.items.length > 0) {
            var tempList =
                pageResult.items.map((m) => MovieInfo.fromJson(m)).toList();
            movieList.addAll(tempList);
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
            movieList =
                pageResult.items.map((m) => MovieInfo.fromJson(m)).toList();
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
