import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:it_resource_exchange_app/model/movie_info.dart';

class MovieListItemView extends StatelessWidget {
 const MovieListItemView({Key key, this.moive, this.onPressed})
      : assert(moive != null),
        super(key: key);

  final MovieInfo moive;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      child: Container(
          height: 100.0,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            width: AppSize.DividerWidth,
            color: AppColors.DividerColor,
          ))),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        moive.movieName ?? "",
                        style: TextStyle(fontSize: 15.0, color: AppColors.DarkTextColor),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('上映日期:${moive.releaseYear}',
                              style: TextStyle(
                                  color: AppColors.LightTextColor,
                                  fontSize: 12.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              // Text(
                              //   '0',
                              //   style: TextStyle(
                              //       color: AppColors.LightTextColor,
                              //       fontSize: 12.0),
                              // ),
                              // SizedBox(width: 5.0),
                              Image.asset('./assets/imgs/ic_comment.png',
                                  width: 16.0, height: 16.0),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 6.0),
                width: 120.0,
                height: 80.0,
                child: CachedNetworkImage(
                  imageUrl: moive.coverUrl,
                  placeholder: (context, url) => Image.asset('./assets/imgs/img_default.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )),
    );
  }
}
