import 'package:flutter/material.dart';
import 'classify_list_view.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/model/cate_info.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppColors;
import 'package:it_resource_exchange_app/widgets/load_state_layout_widget.dart';

class ClassifyPage extends StatefulWidget {
  @override
  _ClassifyPageState createState() => _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  TabController _tabController;

  List<CateInfo> cateList = [];

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  loadData() {
    NetworkUtils.requestCategoryListData().then((res)  {
      if (res.status == 200) {
       cateList = (res.data as List).map((m) =>CateInfo.fromJson(m)).toList();
      //添加全部分类
      cateList.insert(0, CateInfo(null, 0, "全部", 0));
       _tabController = TabController(vsync: this, length: cateList.length);
       setState(() {
          _layoutState = LoadState.State_Success;
       });
      }else {
        setState(() {
          _layoutState = loadStateByErrorCode(res.status);
        });
      }
    });
  }

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
            tabs: cateList.map<Widget>((cate){
              return Tab(text: cate.cateTitle);
            }).toList()
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: cateList.map<Widget>((CateInfo cate) {
              return ClassifyListView(cate);
            }).toList()
          ),
        )
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadStateLayout(
      state: _layoutState,
      errorRetry: () {
        setState(() {
          _layoutState = LoadState.State_Loading;
        });
        this.loadData();
      },
      successWidget: _buildTabPageView(),
    );
  }
}