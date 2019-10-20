import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:it_resource_exchange_app/model/movie_info.dart';
import 'package:it_resource_exchange_app/pages/movie/rating_bar.dart';

class MovieItemView extends StatelessWidget {
  final MovieInfo movieInfo;

  final VoidCallback onPressed;

  const MovieItemView({Key key, this.movieInfo, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemW = (MediaQuery.of(context).size.width - 30.0 - 20.0) / 3;

    return GestureDetector(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 8,),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: CachedNetworkImage(
                imageUrl: this.movieInfo.coverUrl,
                placeholder: (context, url) => Image.asset(
                  './assets/imgs/img_default.png',
                  width: itemW,
                  height: itemW * 1.4,
                  fit: BoxFit.fill,
                ),
                fadeInDuration: const Duration(milliseconds: 80),
                fadeOutDuration: const Duration(milliseconds: 80),
                fit: BoxFit.fill,
                width: itemW,
                height: itemW * 1.4,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
              child: Container(
                // width: double.infinity,
                child: Text(
                  movieInfo.movieName,
                  ///文本只显示一行
                  softWrap: false,
                  ///多出的文本渐隐方式
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.DarkTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}
