import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:it_resource_exchange_app/model/comment_model.dart';

class GoodsCommentItemView extends StatelessWidget {

  final CommentModel commentModel;

  const GoodsCommentItemView({Key key, this.commentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String avatarUrl;

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
      avatar = Icon(
        APPIcons.AvatarData,
        size: 35.0,
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
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: AppSize.DividerWidth,
            color: AppColors.DividerColor,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(10.0), child: avatar),
          Expanded(
            child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        commentModel.nickname ?? "未知",
                        style: TextStyle(color: const Color(0xFF63CA6C)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Text(
                        createDateStr,
                        style: TextStyle(
                            fontSize: 12.0, color: const Color(0xFFB5BDC0)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    commentModel.content ?? '',
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
