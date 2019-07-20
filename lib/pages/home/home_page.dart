import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './goods_item_view.dart';
import 'package:it_resource_exchange_app/pages/detail/goods_detail_page.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/model/home_info.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppColors;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:it_resource_exchange_app/pages/web/webview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  HomeInfo homeInfo;
  List<AdvertiseList> bannerInfoList = [];

  bool _showLoading = true;

  final _loadingContainer = Container(
      color: Colors.white,
      constraints: BoxConstraints.expand(),
      child: Center(
        child: Opacity(
          opacity: 0.9,
          child: SpinKitRing(
            color: AppColors.PrimaryColor,
            size: 50.0,
          ),
        ),
      ));

  void initState() {
    super.initState();
    requestHomePageData();
  }

  @override
  bool get wantKeepAlive => true;

  requestHomePageData() async {
    NetworkUtils.requestHomeAdvertisementsAndRecommendProductsData()
        .then((res) {
      if (res.status == 200) {
        homeInfo = HomeInfo.fromJson(res.data);
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
      itemCount: 1 + homeInfo.recommendProductList.length,
      itemBuilder: (context, i) {
        if (i == 0) {
          return Container(
            height: 220,
            child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: homeInfo.advertiseList[index].adCoverUrl,
                fit: BoxFit.cover,
              );
            },
            itemCount: 3,
            pagination: new SwiperPagination(),
            control: new SwiperControl(),
            onTap: (index) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WebviewPage(
                        title: '广告标题', url: 'https://www.baidu.com/')));

            },
          ),
          );
        } else {
          return GoodsItemView(
            recomendProduct: homeInfo.recommendProductList[i - 1],
            onPressed: () {
              int productId = homeInfo.recommendProductList[i - 1].productId;
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          GoodsDetailPage(productId: productId)));
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
