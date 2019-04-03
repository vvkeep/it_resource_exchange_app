import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart';

class GoodsDetailPage extends StatefulWidget {
  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {

Widget _buildTagView(@required String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    margin: EdgeInsets.only(left: 8),
    child: Text(text, style: TextStyle(fontSize:10)),
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(3)
    ),
  );
}

  Widget _buildPriceView() {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("￥", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
              Text("100", style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          _buildTagView("价格便宜"),
          _buildTagView("讲解透彻"),
        ],
      ),
    );
  }

  Widget _buildTopInfoView() {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 16, 8, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "中关村第一教学视频", 
            maxLines:1, 
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
            ),
          SizedBox(height: 5),
          Text(
            "发布时间:2014-12-12", 
            maxLines:1, 
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey, fontSize: 12)
            ),
          Divider(color: Color(AppColors.DividerColor)),
          _buildPriceView()  
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("教程详情", style:TextStyle(fontWeight:FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildTopInfoView()
          ],
        ),
      ),
    );
  }
}