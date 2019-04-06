import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GoodsDetailPage extends StatefulWidget {
  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {

Widget _buildTagView(String text) {
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

  Widget _buildGoodsDescTextView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          "本课程将带你从入门到进阶，全面掌握Flutter开发核心技术。【课程分为2部分,第1部分:Flutter理论知识入门，老师会带大家快速过一遍Flutter核心API，快速建立Flutter知识印象。第2部分：Flutter技术进阶与项目实战，老师会讲一些Flutter高级技术，并带大家实战完成一个携程网APP的核心功能，提升大家的Flutter实战能力。】具体收获：Flutter入门，AI语音，网络编程，数据存储，异步编程，自定义组件， 原生模块封装调用 ，混合开发，Flutter升级适配指南，项目案例实战。总之通过本课程的学习，可以让你的Fluter技术能力和项目经验得到前所未有的提升",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16), 
        ),
      ),
    );
  }

  Widget _buildImgsView() {
    var img_widgets = List<Widget>.generate(4, (gi){
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top:8, left: 8, right: 8),
        child: GestureDetector(
          onTap: () {
            print("gi = $gi");
          },
          child: CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
            placeholder: CircularProgressIndicator(),
            imageUrl: 'https://picsum.photos/350/500?image=${gi+1}',
            errorWidget: Icon(Icons.error),
          ),
        ),
      );
    }).toList();

    return new Column(
      children: img_widgets,
    );
  }

  Widget _buildBottomBar() {
    FlatButton favoriteBtn = FlatButton.icon(
      icon: Icon(
        Icons.favorite_border,
        color: Colors.grey[800],
      ),
      label: Text("喜欢"),
      onPressed: () {
        print("喜欢");
      },
    );

    Widget buyView = Container(
        child: RaisedButton(
        textColor: Colors.white,
        color: Colors.red[500],
        child: Text("立即换购"),
        onPressed: (){
        },
      ),
    );

    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            favoriteBtn,
            Expanded(child: SizedBox()),
            buyView
          ],
        ),
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
            _buildTopInfoView(),
            _buildGoodsDescTextView(),
            _buildImgsView()
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}