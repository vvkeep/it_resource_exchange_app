import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/widgets/swiper_banner.dart';
import 'package:it_resource_exchange_app/common/mock.dart';
import './goods_item_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          return GoodsItemView();
        }
      },
    );
  }
}