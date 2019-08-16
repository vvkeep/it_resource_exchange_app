import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './goods_item_view.dart';
import 'package:it_resource_exchange_app/pages/detail/goods_detail_page.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/model/home_info.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppColors, AppSize, APPIcons;
import 'package:it_resource_exchange_app/pages/web/webview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:it_resource_exchange_app/widgets/load_state_layout_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  HomeInfo homeInfo;
  List<AdvertiseList> bannerInfoList = [];

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  void initState() {
    super.initState();
    loadData();
  }

  @override
  bool get wantKeepAlive => true;

  loadData() async {
    NetworkUtils.requestHomeAdvertisementsAndRecommendProductsData()
        .then((res) {
      if (res.status == 200) {
        homeInfo = HomeInfo.fromJson(res.data);
        setState(() {
          _layoutState = LoadState.State_Success;
        });
      } else  {
         setState(() {
          _layoutState = loadStateByErrorCode(res.status);
        });
      }
    });
  }

  Widget _buildListView() {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(1.0),
      itemCount: homeInfo == null ? 0 : (1 + homeInfo.recommendProductList.length),
      itemBuilder: (context, i) {
        if (i == 0) {
          return Container(
            height: 220,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return CachedNetworkImage(
                  imageUrl: homeInfo.advertiseList[index].adCoverUrl,
                  placeholder: (context, url) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.BackgroundColor,
                            width: AppSize.DividerWidth),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: Icon(
                          APPIcons.AddImgData,
                          color: AppColors.PrimaryColor,
                          size: 40,
                        ),
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              itemCount: homeInfo.advertiseList.length,
              pagination: SwiperPagination(builder: SwiperPagination.dots),
              control: null,
              onTap: (index) {
                AdvertiseList asvertise = homeInfo.advertiseList[index];
                if (asvertise.adType == 1) {
                  String productId = homeInfo.advertiseList[index].adProductId;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GoodsDetailPage(
                              productId: int.parse(productId))));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WebviewPage(
                          title: asvertise.adTitle,
                          url: asvertise.adDetailUrl)));
                }
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
                  MaterialPageRoute(
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
    return LoadStateLayout(
      state: _layoutState,
      errorRetry: () {
        setState(() {
          _layoutState = LoadState.State_Loading;
        });
        this.loadData();
      },
      successWidget: _buildListView(),
    );
  }
}
