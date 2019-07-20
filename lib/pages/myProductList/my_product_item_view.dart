import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../model/product_detail.dart';
import 'package:intl/intl.dart';
import 'package:it_resource_exchange_app/utils/net_image_cache_manager.dart';


class MyProductItemView extends StatelessWidget {
  const MyProductItemView({Key key, this.product, this.onPressed})
      : assert(product != null),
        super(key: key);

  final ProductDetail product;

  final VoidCallback onPressed;


  String productStatusDesc(int status) {
    var desc;
    switch (status) {
      case 1000:
        desc = '待审核';
        break;
      case 1001:
        desc = '已拒绝';
        break;
      case 1002:
      case 2000:
        desc = '已通过';
        break;
      case 2001:
        desc = '已下架';
        break;
      default:
         desc = '未知';
    }
    return desc;
  }

   Color productStatusColor(int status) {
    var color;
    switch (status) {
      case 1000:
        color = Colors.yellow;
        break;
      case 1001:
        color = Colors.red;
        break;
      case 1002:
      case 2000:
        color = Colors.green;
        break;
      case 2001:
         color = Colors.grey;
        break;
      default:
         color = null;
    }
    return color;
  }

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
                        product.productTitle,
                        style: TextStyle(fontSize: 15.0, color: AppColors.DarkTextColor),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(product.cateTitle,
                              style: TextStyle(
                                  color: AppColors.LightTextColor,
                                  fontSize: 14.0)),
                          Text(productStatusDesc(product.productStatus),
                              style: TextStyle(
                                  color:  productStatusColor(product.productStatus),
                                  fontSize: 14.0)),
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
                  imageUrl: product.coverUrl,
                  placeholder: (context, url) => Image.asset('./assets/imgs/img_default.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )),
    );
  }
}
