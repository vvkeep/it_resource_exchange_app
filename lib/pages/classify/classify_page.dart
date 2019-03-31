import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show Constant;
import 'classify_list_view.dart';
class ClassifyPage extends StatefulWidget {
  @override
  _ClassifyPageState createState() => _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: Constant.CategoryTitles.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            border: Border(
              bottom: BorderSide(
                width: 0.0,
                color: Theme.of(context).dividerColor,
              )
            )
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Theme.of(context).primaryColor,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: Constant.CategoryTitles.map<Widget>((title){
              return Tab(text: title);
            }).toList()
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: Constant.CategoryTitles.map<Widget>((String page) {
              return ClassifyListView(page);
            }).toList()
          ),
        )
      ],
    );
  }
}