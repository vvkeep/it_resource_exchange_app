import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/model/movie_info.dart';
import 'package:it_resource_exchange_app/pages/movie/rating_bar.dart';

class MovieItemView extends StatelessWidget {
  final MovieInfo movieInfo;

  final VoidCallback onPressed;

  const MovieItemView({Key key, this.movieInfo, this.onPressed}) : super(key: key);


  @override
  Widget build(BuildContext context) {
        var itemW = (MediaQuery.of(context).size.width - 30.0 - 20.0) / 3;

    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: CachedNetworkImage(
                imageUrl: this.movieInfo.coverUrl,
                placeholder: (context, url) =>
                    Image.asset('./assets/imgs/img_default.png'),
                fadeInDuration: const Duration(milliseconds: 80),
                fadeOutDuration: const Duration(milliseconds: 80),
                fit: BoxFit.fill,
                width: itemW,
                // height: itemW * 1.4,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  movieInfo.movieName,

                  ///文本只显示一行
                  softWrap: false,

                  ///多出的文本渐隐方式
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            RatingBar(
              2.5,
              size: 12.0,
            )
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}
