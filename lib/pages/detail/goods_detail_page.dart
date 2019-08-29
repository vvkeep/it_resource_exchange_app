import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import '../../model/product_detail.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:it_resource_exchange_app/widgets/load_state_layout_widget.dart';

class GoodsDetailPage extends StatefulWidget {
  GoodsDetailPage({Key key, this.productId}) : super(key: key);
  final int productId;
  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  ScrollController _commentController = ScrollController();
  TextEditingController _inputController = TextEditingController();

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  ProductDetail productDetail;

  TextStyle subtitleStyle =
      TextStyle(fontSize: 12.0, color: const Color(0xFFB5BDC0));
  TextStyle contentStyle = TextStyle(fontSize: 15.0, color: Colors.black);

  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    NetworkUtils.requestProductDetailByProductId(this.widget.productId)
        .then((res) {
      if (res.status == 200) {
        productDetail = ProductDetail.fromJson(res.data);
        setState(() {
          _layoutState = LoadState.State_Success;
        });
      } else {
        setState(() {
          _layoutState = loadStateByErrorCode(res.status);
        });
      }
    });
  }

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
    String price = productDetail?.price?.toStringAsFixed(2) ?? "";
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
    if (productDetail?.keywords != null && productDetail.keywords.isNotEmpty) {
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
    if (productDetail?.createdTime != null) {
      var format = new DateFormat('yyyy-MM-dd HH:mm');
      var date = DateTime.fromMillisecondsSinceEpoch(productDetail.createdTime);
      createDateStr = format.format(date);
    }

    return Container(
      padding: EdgeInsets.fromLTRB(8, 16, 8, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(productDetail?.productTitle ?? "",
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
          productDetail?.productDesc?.trim() ?? "",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildImgsView() {
    List<Widget> imgWidgets = [];

    if (productDetail?.imgUrls != null) {
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
    if (productDetail?.productAddressUrl != null) {
      itemWidgets.add(_buildResourceItemView(
          "资源地址:", productDetail?.productAddressUrl ?? ""));
      itemWidgets.add(SizedBox(height: 10));
    }

    if (productDetail?.productAddressPassword != null) {
      itemWidgets.add(_buildResourceItemView(
          "资源密码:", productDetail?.productAddressPassword ?? ""));
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

  Widget _commentView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: renderListItem,
      controller: _commentController,
    );
  }

  Widget renderListItem(BuildContext context, int i) {
    String avatarUrl;
    String author = '小恶魔';
    String date = "2018-04-12";
    String content = "这是$i" + "条评论,这条评论不错发送到发神所发生的发家史经风口浪尖哈哈哈哈哈哈哈哈哈哈阿就快放假啊开发就阿卡；发";

    Widget avatar;
    if (avatarUrl != null) {
      avatar = CachedNetworkImage(
        imageUrl: avatarUrl,
        placeholder: (context, url) => APPIcons.PlaceHolderAvatar,
        fit: BoxFit.cover,
        height: 35.0,
        width: 35.0,
        errorWidget: (context, url, error) => new Icon(Icons.error),
      );
    } else {
      avatar = Icon(APPIcons.AvatarData,size: 35.0, color: AppColors.ArrowNormalColor,);
    }

    var row = Row(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: avatar),
        Expanded(
            child: Container(
          margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      author,
                      style: TextStyle(color: const Color(0xFF63CA6C)),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Text(
                        date,
                        style: subtitleStyle,
                      ))
                ],
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        content,
                        style: contentStyle,
                      ))
                    ],
                  ))
            ],
          ),
        ))
      ],
    );
    return Builder(
      builder: (ctx) {
        return InkWell(
          onTap: () {
            showReplyBottomView(ctx, false, data: null);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: AppSize.DividerWidth,
                  color: AppColors.DividerColor,
                ),
              ),
            ),
            child: row,
          ),
        );
      },
    );
  }

  showReplyBottomView(ctx, bool isMainFloor, {data}) {
    String title;
    String authorId;
    if (isMainFloor) {
      title = "什么鬼标题";
      authorId = "${12313}";
    } else {
      title = "@${'小恶魔'}";
      authorId = "${1231231}";
    }
    print("authorId = $authorId");
    showModalBottomSheet(
        context: ctx,
        builder: (sheetCtx) {
          return Container(
              height: 230.0,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(isMainFloor ? "回复楼主" : "回复"),
                      Expanded(
                          child: Text(
                        title,
                        style: TextStyle(color: const Color(0xFF63CA6C)),
                      )),
                      InkWell(
                        child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF63CA6C),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          child: Text(
                            "发送",
                            style: TextStyle(color: const Color(0xFF63CA6C)),
                          ),
                        ),
                        onTap: () {
                          // 发送回复
                          print("发送回复~~~~~~");
                        },
                      )
                    ],
                  ),
                  Container(
                    height: 10.0,
                  ),
                  TextField(
                    maxLines: 5,
                    controller: _inputController,
                    decoration: InputDecoration(
                        hintText: "说点啥～",
                        hintStyle: TextStyle(color: const Color(0xFF808080)),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)),
                        )),
                  )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
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
      body: LoadStateLayout(
        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          this.loadData();
        },
        successWidget: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTopInfoView(),
              _buildGoodsDescTextView(),
              _buildImgsView(),
              _buildResourceView(),
              _commentView(),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomBar(),
    );
  }
}
