import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/global_config.dart' show AppColors;
import 'classify/classify_page.dart';
import 'home/home_page.dart';
import 'profile/profile_page.dart';

class ApplicationPage extends StatefulWidget {
  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> with SingleTickerProviderStateMixin {
  int page = 0;
  String title = '首页';
  PageController pageController;

  //定义底部导航项目
  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem> [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('首页'),
      backgroundColor: AppColors.colorPrimary,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.tune),
      title: Text('分类'),
      backgroundColor: AppColors.colorPrimary,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('我的'),
      backgroundColor: AppColors.colorPrimary,
    ),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: this.page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: AppColors.colorPrimary),
      home: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
          elevation: 0.0,
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(), /// 去除滑动手势
          children: <Widget>[
            HomePage(),
            ClassifyPage(),
            ProfilePage()
          ],
          controller: pageController,
          onPageChanged: (int index){
            onPageChanged(index);
          },
        ),

       bottomNavigationBar: BottomNavigationBar(
         items: _bottomTabs,
         currentIndex: page,
         fixedColor: AppColors.colorPrimary,
         type: BottomNavigationBarType.fixed,
         onTap: (int index) {
           onTap(index);
         },
       ), 
      ),
    );
  }

  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int page) {
    setState(() {
       this.page = page;
       switch (page) {
         case 0:
          title = "首页";
          break;
         case 1:
          title = "分类";
          break;
         case 2:
          title= "我的";
          break;
       } 
    });
  }
}