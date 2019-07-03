import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppColors, Constant, APPIcons;
import 'package:it_resource_exchange_app/model/user_info.dart';
import 'package:it_resource_exchange_app/utils/user_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileHeaderInfoView extends StatelessWidget {
  const ProfileHeaderInfoView({this.onPressed});

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    UserInfo userInfo = UserUtils.getUserInfo();

    Widget avatar;

    if (userInfo.avatar != null) {
      avatar = CachedNetworkImage(
                  imageUrl: userInfo.avatar,
                  placeholder: APPIcons.PlaceHolderAvatar,
                  fit: BoxFit.cover,
                  errorWidget: Icon(Icons.error)
                );
    }else {
      avatar = APPIcons.PlaceHolderAvatar;
    }

    return Container(
      height: 80,
      color: Colors.white,
      child: FlatButton(
        onPressed: this.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    userInfo.account,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: Text(
                      userInfo.intro ?? '此人很懒，什么都没写~',
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(fontSize: 12, color: Color(0xff818181)),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: ClipOval(
                child: avatar,
              ),
            )
          ],
        ),
      ),
    );
  }
}
