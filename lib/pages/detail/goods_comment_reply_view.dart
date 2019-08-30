import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:it_resource_exchange_app/common/constant.dart';

class GoodsCommentReplyView extends StatelessWidget {
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
      
    );
  }
}