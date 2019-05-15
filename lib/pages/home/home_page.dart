import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/widgets/swiper_banner.dart';
import 'package:it_resource_exchange_app/common/mock.dart';
import './goods_item_view.dart';
import 'package:it_resource_exchange_app/pages/detail/goods_detail_page.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/model/home_info.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeInfo homeInfo;

  void initState() {
    super.initState();
    requestHomePageData();
  }
  
  requestHomePageData() async {
    NetworkUtils.requestHomeAdvertisementsAndRecommendProductsData().then((res) {
      if (res.status == 200) {
        homeInfo = HomeInfo.fromJson(res.data);
        print(homeInfo);
      }
      print("请求回调到Page $res.data");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(2.0),
      itemCount: 10,
      itemBuilder: (context, i) {
        if (i == 0) {
          return SwiperBanner(200.0, Mock.homeBannerInfoList);
        }else {
          return GoodsItemView(
            index: i-1, 
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) => GoodsDetailPage()));
            },
          );
        }
      },
    );
  }
}