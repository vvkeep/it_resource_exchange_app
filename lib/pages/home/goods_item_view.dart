import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppSize, AppColors;
import 'package:cached_network_image/cached_network_image.dart';
import '../../model/home_info.dart';
class GoodsItemView extends StatelessWidget {

  const GoodsItemView({Key key, 
    this.recomendProduct,  
    this.onPressed
  }): assert(recomendProduct != null),
      super(key: key);

  final RecommendProductList recomendProduct;
  
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var titleRow = Row(
      children: <Widget>[
        Expanded(
          child: Text(
            recomendProduct.productTitle,
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      ],
    );

    var timeRow = Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: Text(
            recomendProduct.createdTime,
            style: TextStyle(
              color: Color(0xFFB5BDC0),
              fontSize: 12.0
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '12',
                style: TextStyle(
                  color: Color(0xFFB5BDC0),
                  fontSize: 12.0
                 ),
              ),
              SizedBox(width: 5.0),
              Image.asset('./assets/imgs/ic_comment.png', width:16.0, height:16.0),
            ],
          ),
        )
      ],
    );

    
   var thumbImg = Container(
      margin: EdgeInsets.all(10.0),
      width: 60.0,
      height: 60.0,
      child: CachedNetworkImage(
        imageUrl: recomendProduct.imgUrls,
        placeholder: Image.asset('./assets/imgs/img_default.png'),
        fit: BoxFit.cover,
        ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFECECEC),
          width: 2.0,
        )
      ),
    );
    
    var row = Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                titleRow,
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                  child: timeRow,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Container(
            width: 100.0,
            height: 80.0,
            color: Color(0xFfECECEC),
            child: Center(
              child: thumbImg,
            ),
          ),
        )
      ],
    );

    return GestureDetector(
      onTap: this.onPressed,
      child: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: AppSize.DividerWidth,
            color: Color(AppColors.DividerColor),
          )
        )
      ),
      child: row,
    ),
    );
  }
}