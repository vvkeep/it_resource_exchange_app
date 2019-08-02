import 'package:flutter/material.dart';
import 'classify_list_view.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/model/cate_info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppColors;
import 'package:it_resource_exchange_app/pages/login/login_page.dart';
import 'package:it_resource_exchange_app/pages/max_api_times_tip/max_api_times_tip_page.dart';

class ClassifyPage extends StatefulWidget {
  @override
  _ClassifyPageState createState() => _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  TabController _tabController;

  List<CateInfo> cateList;

  bool _showLoading = true;

  final _loadingContainer = Container(
    color:Colors.white,
    constraints: BoxConstraints.expand(),
    child: Center(
        child: Opacity(
            opacity: 0.9,
            child: SpinKitRing(
              color: AppColors.PrimaryColor,
              size: 50.0,
            ),
        ),
    )
);


  @override
  void initState() {
    super.initState();
    requsetCateListData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  requsetCateListData() {
    NetworkUtils.requestCategoryListData().then((res)  {
      if (res.status == 200) {
       cateList = (res.data as List).map((m) =>CateInfo.fromJson(m)).toList();
      //添加全部分类
      cateList.insert(0, CateInfo(null, 0, "全部", 0));
       _tabController = TabController(vsync: this, length: cateList.length);
       setState(() {
          _showLoading = false;
       });
      }else if (res.status == 401) { // token 过期 重新登录
                Navigator.pushReplacement(
            this.context, MaterialPageRoute(builder: (context) => LoginPage()));
      }else if (res.status == 403) { // 请求次数超过限制
                        Navigator.pushReplacement(
            this.context, MaterialPageRoute(builder: (context) => MaxApiTimesTipPage()));
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
    return _showLoading ? _loadingContainer : _buildTabPageView();
  }
}