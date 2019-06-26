import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/widgets/swiper_banner.dart';
import './goods_item_view.dart';
import 'package:it_resource_exchange_app/pages/detail/goods_detail_page.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/model/home_info.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppColors;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  HomeInfo homeInfo;
  List<SwiperDataInfo> bannerInfoList = [];

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

  void initState() {
    super.initState();
    requestHomePageData();
  }
  
  @override
  bool get wantKeepAlive => true;
  
  requestHomePageData() async {
    NetworkUtils.requestHomeAdvertisementsAndRecommendProductsData().then((res) {
      if (res.status == 200) {
        homeInfo = HomeInfo.fromJson(res.data);
        bannerInfoList = homeInfo.advertiseList.map((advertise) =>
          SwiperDataInfo(coverImgUrl: advertise.adCoverUrl,title: advertise.adTitle,id: advertise.adId)
        ).toList();
        setState(() {
           _showLoading = false;
        });
      }
    });
  }

  Widget _buildListView() {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(1.0),
      itemCount: 1 +homeInfo.recommendProductList.length,
      itemBuilder: (context, i) {
        if (i == 0) {
           return SwiperBanner(200.0, bannerInfoList);
        }else {
          return GoodsItemView(
            recomendProduct: homeInfo.recommendProductList[i-1], 
            onPressed: () {
              int productId = homeInfo.recommendProductList[i-1].productId;
              Navigator.push(context, new MaterialPageRoute(builder: (context) => GoodsDetailPage(productId: productId)));
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _showLoading ? _loadingContainer : _buildListView();
  }
}