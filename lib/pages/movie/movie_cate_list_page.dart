import 'package:flutter/material.dart';
import 'movie_cate_list_view.dart';
import 'package:it_resource_exchange_app/model/cate_info.dart';
import 'package:it_resource_exchange_app/common/constant.dart';

class MovieCateListPage extends StatefulWidget {
  @override
  _MovieCateListPageState createState() => _MovieCateListPageState();
}

class _MovieCateListPageState extends State<MovieCateListPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  TabController _tabController;

  List<CateInfo> cateList = Constant.movieCateInfoList;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: cateList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildTabPageView() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            border: Border(
              bottom: BorderSide(
                width: 0.0,
                color: AppColors.DividerColor,
              )
            )
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: AppColors.PrimaryColor,
            indicatorColor: AppColors.PrimaryColor,
            tabs: Constant.movieCateInfoList.map<Widget>((cate){
              return Tab(text: cate.cateTitle);
            }).toList()
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: cateList.map<Widget>((CateInfo cate) {
              return MovieCateListView(cate);
            }).toList()
          ),
        )
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildTabPageView();
  }
}