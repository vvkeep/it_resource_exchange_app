import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:it_resource_exchange_app/model/base_result.dart';
import 'package:it_resource_exchange_app/model/comment_model.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/utils/user_utils.dart';
import 'package:it_resource_exchange_app/vo/comment_vo.dart';
import 'package:it_resource_exchange_app/widgets/indicator_factory.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../model/product_detail.dart';
import 'package:oktoast/oktoast.dart';
import 'package:it_resource_exchange_app/widgets/load_state_layout_widget.dart';
import 'comment_view/goods_comment_content_view.dart';
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
  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  ProductDetail productDetail;

  List<CommentModel> commentList = [];

  CommentVO _commentVO;

  RefreshController _refreshController;

  void initState() {
    super.initState();
    _refreshController = RefreshController();
    loadData();
  }

  loadData() async {
    Future.wait([
      NetworkUtils.requestProductDetailByProductId(this.widget.productId),
      NetworkUtils.requstProductCommentList(this.widget.productId, 0)
    ]).then((res) {
      BaseResult productDetailRes = res[0];
      BaseResult commentListRes = res[1];
      if (productDetailRes.status == 200 && commentListRes.status == 200) {
        productDetail = ProductDetail.fromJson(productDetailRes.data);
        commentList = (commentListRes.data as List)
            .map((m) => CommentModel.fromJson(m))
            .toList();
        if (commentList.length < 20) {
          this._refreshController.loadNoData();
        } else {
          this._refreshController.loadComplete();
        }
        setState(() {
          _layoutState = LoadState.State_Success;
        });
      } else {
        BaseResult res =
            productDetailRes.status != 200 ? productDetailRes : commentListRes;
        setState(() {
          _layoutState = loadStateByErrorCode(res.status);
        });
      }
    }).catchError((error) {
      print('${error.toString()}');
    });
  }

  loadProductCommentListData() async {
    int startCommentId = this.commentList.last?.commentList ?? 0;
    NetworkUtils.requstProductCommentList(this.widget.productId, startCommentId)
        .then((res) {
      if (res.status == 200) {
        var tempList =
            (res.data as List).map((m) => CommentModel.fromJson(m)).toList();

        if (tempList.length < 20) {
          this._refreshController.loadNoData();
        } else {
          this._refreshController.loadComplete();
        }
        if (tempList.length > 0) {
          this.commentList.addAll(tempList);
        }
        setState(() {});
      }
    });
  }

  remarkProduct(String content) async {
    var parentCommentId;
    var parentUserId;

    // 点击的是评论
    if (_commentVO != null && _commentVO.index == -1) {
      CommentModel parentComment = _commentVO.commentModel;
      parentCommentId = parentComment.commentId;
      parentUserId = parentComment.createUserId;
    }

    if (_commentVO != null && _commentVO.index != -1) {
      CommentModel parentComment =
          _commentVO.commentModel.commentList[_commentVO.index];
      parentCommentId = parentComment.parentCommentId;
      parentUserId = parentComment.createUserId;
    }

    NetworkUtils.remarkProduct(this.widget.productId, content,
            parentCommentId: parentCommentId, parentUserId: parentUserId)
        .then((res) {
      if (res.status == 200) {
       CommentModel temp = CommentModel.fromJson(res.data);
        // 构建一个评论模型
        if (parentCommentId == null) {
          //添加评论
          showToast('评论成功', duration: Duration(milliseconds: 1500));
          this.commentList.add(temp);
          this.productDetail.commentCount += 1;
        } else {
          showToast('回复成功', duration: Duration(milliseconds: 1500));
          this._commentVO.commentModel.commentList.add(temp);
        }
        setState(() {});
      } else {
        showToast('发送失败');
      }
    });
  }

  addCollectProduct() {
    int cateId =  int.parse(this.productDetail.cateId);
    NetworkUtils.addCollectProduct(cateId, this.productDetail.productId).then((res) {
      if (res.status == 200) {
        var collectId = (res.data as Map)['collectId'];
        setState(() {
          this.productDetail.collectId = collectId;
        });
        showToast('收藏成功');
      }else {
        showToast('收藏失败');
      }
    });
  }

  deleteCollect() {
    NetworkUtils.deleteCollectProcut(this.productDetail.collectId)..then((res) {
      if (res.status == 200) {
        setState(() {
          this.productDetail.collectId = null;
        });
        showToast('取消收藏成功');
      }else {
        showToast('取消收藏失败');
      }
    });
  }

  showCommentDialog() {
    Navigator.push(
      context,
      PopBottomInputDialogRoute(
        child: BottomInputDialog(
          callback: (text) {
            this.remarkProduct(text);
          },
        ),
      ),
    );
  }

  _buildBodyView() {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      enablePullDown: false,
      footer: buildDefaultFooter(),
      onLoading: () {
        this.loadProductCommentListData();
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: GoodsDetailContentView(
              productDetail: productDetail,
            ),
          ),
          SliverToBoxAdapter(
            child: GoodsCommentHeaderView(commentCount: this.productDetail?.commentCount ?? 0,),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, int index) {
                return GoodsCommentContentView(
                  commentModel: this.commentList[index],
                  tapCallback: ((commentVO) {
                    this._commentVO = commentVO;
                    //评论
                    this.showCommentDialog();
                  }),
                );
              },
              childCount: this.commentList.length,
            ),
          ),
        ],
      ),
    );
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
          successWidget: _buildBodyView()),
      bottomNavigationBar: GoodsCommentBottomBar(
        isCollect: this.productDetail?.collectId == null ? false : true,
        btnActionCallback: ((tag) {
          if (tag == 100) {
            //收藏
            if (this.productDetail.collectId == null) {
              this.addCollectProduct();
            } else {
              this.deleteCollect();
            }
          } else if (tag == 200) {
            this._commentVO = null;
            //评论
            this.showCommentDialog();
          }
        }),
      ),
    );
  }
}
