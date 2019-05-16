import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/widgets/swiper_banner.dart';
import './goods_item_view.dart';
import 'package:it_resource_exchange_app/pages/detail/goods_detail_page.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/model/home_info.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppColors;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeInfo homeInfo;
  List<SwiperDataInfo> bannerInfoList = [];

  void initState() {
    super.initState();
    requestHomePageData();
  }
  
  requestHomePageData() async {
    NetworkUtils.requestHomeAdvertisementsAndRecommendProductsData().then((res) {
      if (res.status == 200) {
        homeInfo = HomeInfo.fromJson(res.data);
        bannerInfoList = homeInfo.advertiseList.map((advertise) =>
          SwiperDataInfo(coverImgUrl: advertise.adCoverUrl,title: advertise.adTitle,id: advertise.adId)
        ).toList();

        setState(() {
        });
      }
    });
  }

  // banner 的占位图
  Widget _buildSwiperBannerPlaceHolderView() {
    return Container(
      height: 200.0,
      color: AppColors.PrimaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(1.0),
      itemCount: 10,
      itemBuilder: (context, i) {
        if (i == 0) {
           return bannerInfoList.length > 0 ? SwiperBanner(200.0, bannerInfoList) : _buildSwiperBannerPlaceHolderView();
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