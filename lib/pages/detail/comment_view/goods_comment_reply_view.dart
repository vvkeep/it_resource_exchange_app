import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:it_resource_exchange_app/model/comment_model.dart';

class GoodsCommentReplyView extends StatelessWidget {
  final CommentModel commentModel;

  const GoodsCommentReplyView({Key key, this.commentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String avatarUrl;

    Widget avatar;
    if (avatarUrl != null) {
      avatar = CachedNetworkImage(
        imageUrl: avatarUrl,
        placeholder: (context, url) => APPIcons.PlaceHolderAvatar,
        fit: BoxFit.cover,
        height: 20.0,
        width: 20.0,
        errorWidget: (context, url, error) => new Icon(Icons.error),
      );
    } else {
      avatar = Icon(
        APPIcons.AvatarData,
        size: 20.0,
        color: AppColors.ArrowNormalColor,
      );
    }

    var createDateStr = "未知";
    if (commentModel?.createdTime != null) {
      var format = new DateFormat('yyyy-MM-dd HH:mm');
      var date = DateTime.fromMillisecondsSinceEpoch(commentModel.createdTime);
      createDateStr = format.format(date);
    }

    return Container(
      margin: EdgeInsets.fromLTRB(55.0, 0, 0, 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: AppSize.DividerWidth,
            color: AppColors.DividerColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              avatar,
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  this.commentModel?.createUserName ?? "未知",
                  style: TextStyle(color: const Color(0xFF63CA6C)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  createDateStr,
                  style:
                      TextStyle(fontSize: 12.0, color: const Color(0xFFB5BDC0)),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 5.0, 10.0, 0.0),
            child: Text(
              this.commentModel.content ?? '',
              style: TextStyle(fontSize: 15.0, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
