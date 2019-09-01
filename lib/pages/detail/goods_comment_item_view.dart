import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:it_resource_exchange_app/common/constant.dart';

class GoodsCommentItemView extends StatelessWidget {
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
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(10.0), child: avatar),
          Expanded(
            child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '小魔王',
                        style: TextStyle(color: const Color(0xFF63CA6C)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Text(
                        '08.12 15:49',
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
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                  child: Text(
                    '按实际发ddd建安费肯德基房卡的荆防颗粒打卡了房间；打客服大开发了；阿达开始的放假啊；离开的房间啊',
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
