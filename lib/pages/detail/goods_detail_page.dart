import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/pages/home/goods_item_view.dart';
import '../../model/product_detail.dart';
import 'package:oktoast/oktoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:it_resource_exchange_app/widgets/load_state_layout_widget.dart';
import 'comment_view/goods_comment_content_view.dart';
import 'comment_view/goods_comment_end_tip_view.dart';
import 'goods_detail_bottom_bar.dart';
import 'goods_detail_content_view.dart';
import 'comment_view/goods_comment_header_view.dart';
import 'input_dialog/bottom_input_dialog.dart';
import 'input_dialog/pop_bottom_input_dialog_route.dart';

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
        successWidget: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: GoodsDetailContentView(
                productDetail: productDetail,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: AppColors.DividerColor,
                height: 5,
              ),
            ),
            SliverToBoxAdapter(
              child: GoodsCommentHeaderView(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, int index) {
                  return GoodsCommentContentView();
                },
                childCount: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: GoodsCommentEndTipView(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GoodsCommentBottomBar(
        btnActionCallback: ((tag) {
          if (tag == 100) { //喜欢
            
          }else if (tag == 200) { //评论
            print("评论了~");
            Navigator.push(context, PopBottomInputDialogRoute(child: BottomInputDialog()));
          }
        }),
      ),
    );
  }
}
