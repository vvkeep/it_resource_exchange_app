import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import '../../model/product_detail.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:it_resource_exchange_app/common/constant.dart';

class GoodsDetailPage extends StatefulWidget {
  GoodsDetailPage({Key key, this.productId}) : super(key: key);
  final int productId;
  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  bool _showLoading = true;

  ProductDetail productDetail;

  void initState() {
    super.initState();
    requestGoodsDetailData();
  }

  requestGoodsDetailData() async {
    NetworkUtils.requestProductDetailByProductId(this.widget.productId)
        .then((res) {
      if (res.status == 200) {
        productDetail = ProductDetail.fromJson(res.data);
        setState(() {
          _showLoading = false;
        });
      }
    });
  }

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

  Widget _buildTagView(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      margin: EdgeInsets.only(left: 8),
      child: Text(text, style: TextStyle(fontSize: 10)),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(3)),
    );
  }

  Widget _buildPriceView() {
    // 保留两位小数
    String price = productDetail.price.toStringAsFixed(2);
    Row priceRow = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("￥",
            style: TextStyle(
                color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
        Text(price,
            style: TextStyle(
                color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );

    List<Widget> widgets = [priceRow];
    if (productDetail.keywords != null && productDetail.keywords.isNotEmpty) {
      List<String> tags = productDetail.keywords.split(',');
      List<Widget> tagWidgets = tags.map((tag) => _buildTagView(tag)).toList();
      widgets.addAll(tagWidgets);
    }

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: widgets,
      ),
    );
  }

  Widget _buildTopInfoView() {
    var createDateStr = "未知";
    if (productDetail.createdTime != null &&
        productDetail.createdTime.isNotEmpty) {
      var format = new DateFormat('yyyy-MM-dd HH:mm');
      int timeStamp = int.parse(productDetail.createdTime);
      var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
      createDateStr = format.format(date);
    }

    return Container(
      padding: EdgeInsets.fromLTRB(8, 16, 8, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(productDetail.productTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 5),
          Text("发布时间: $createDateStr",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          Divider(color: AppColors.DividerColor),
          _buildPriceView()
        ],
      ),
    );
  }

  Widget _buildGoodsDescTextView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          productDetail.productDesc,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildImgsView() {
    List<Widget> imgWidgets = [];

    if (productDetail.imgUrls != null && productDetail.imgUrls.isNotEmpty) {
      List<String> imgUrls = productDetail.imgUrls.split(',');
      imgWidgets = imgUrls.map((imgUrl) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 8, left: 8, right: 8),
          child: GestureDetector(
            onTap: () {
              print("URL = $imgUrl");
            },
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              placeholder: (context, url) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.BackgroundColor,
                        width: AppSize.DividerWidth),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  width: double.infinity,
                  height: 250,
                  child: Center(
                    child: Icon(
                      APPIcons.AddImgData,
                      color: AppColors.PrimaryColor,
                      size: 40,
                    ),
                  ),
                );
              },
              imageUrl: imgUrl,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        );
      }).toList();
    }

    return new Column(
      children: imgWidgets,
    );
  }

  Widget _buildResourceItemView(String title, String value) {
    var descWidget =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Text(title, style: TextStyle(color: Colors.black, fontSize: 16)),
      Text(value ?? "",
          style: TextStyle(
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold)),
    ]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: descWidget),
        SizedBox(width: 12),
        IconButton(
          icon: Icon(IconData(
            0xe6e6,
            fontFamily: Constant.IconFontFamily,
          )),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            showToast("已复制到系统剪贴板");
          },
        )
      ],
    );
  }

  Widget _buildResourceView() {
    List<Widget> itemWidgets = [Divider(color: AppColors.DividerColor)];
    if (productDetail.productAddressUrl != null &&
        productDetail.productAddressUrl.isNotEmpty) {
      itemWidgets.add(
          _buildResourceItemView("资源地址:", productDetail.productAddressUrl));
      itemWidgets.add(SizedBox(height: 10));
    }

    if (productDetail.productAddressPassword != null &&
        productDetail.productAddressPassword.isNotEmpty) {
      itemWidgets.add(_buildResourceItemView(
          "资源密码:", productDetail.productAddressPassword));
      itemWidgets.add(SizedBox(height: 6));
    }

    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: itemWidgets,
      ),
    );
  }

  Widget _buildBottomBar() {
    FlatButton favoriteBtn = FlatButton.icon(
      icon: Icon(
        Icons.favorite_border,
        color: Colors.grey[800],
      ),
      label: Text("喜欢"),
      onPressed: () {
        print("喜欢");
      },
    );

    Widget buyView = Container(
      child: RaisedButton(
        textColor: Colors.white,
        color: Colors.red[500],
        child: Text("立即换购"),
        onPressed: () {},
      ),
    );

    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[favoriteBtn, Expanded(child: SizedBox()), buyView],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget contentBody;
    if (_showLoading) {
      contentBody = _loadingContainer;
    } else {
      contentBody = SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildTopInfoView(),
            _buildGoodsDescTextView(),
            _buildImgsView(),
            _buildResourceView(),
            SizedBox(height: MediaQuery.of(context).padding.bottom)
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "教程详情",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: contentBody,
      // bottomNavigationBar: _buildBottomBar(),
    );
  }
}
