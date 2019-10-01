import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart';

class PerfectInfoPage extends StatefulWidget {
  @override
  _PerfectInfoPageState createState() => _PerfectInfoPageState();
}

class _PerfectInfoPageState extends State<PerfectInfoPage> {
  String _avatarURL;

  String _nickName;

  _buildIconView() {
    Widget avatar;
    if (_avatarURL != null) {
      avatar = CachedNetworkImage(
        imageUrl: _avatarURL,
        placeholder: (context, url) => APPIcons.PlaceHolderAvatar,
        fit: BoxFit.cover,
        height: 80.0,
        width: 80.0,
        errorWidget: (context, url, error) => new Icon(Icons.error),
      );
    } else {
      avatar = Icon(
        APPIcons.AvatarData,
        size: 80.0,
        color: AppColors.ArrowNormalColor,
      );
    }
    return GestureDetector(
      child: ClipOval(
              child: avatar,
            ),
      onTap: () {

      },
    );
  }

  _buildNickNameFieldView() {
    var node = FocusNode();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: TextEditingController(text: _nickName),
        onChanged: (value) {
          _nickName = value;
        },
        decoration: InputDecoration(
          hintText: '请输入昵称',
          labelText: '昵称',
          hintStyle:
              TextStyle(fontSize: 12.0, color: AppColors.ArrowNormalColor),
        ),
        maxLines: 1,
        maxLength: 30,
        keyboardType: TextInputType.emailAddress,
        autofocus: true,
        onSubmitted: (value) {
          FocusScope.of(context).requestFocus(node);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
            title: new Text('完善信息', style: TextStyle(color: Colors.white)),
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.white,
            )),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 100),
                _buildIconView(),
                SizedBox(height: 80),
                _buildNickNameFieldView()
              ],
            ),
          ),
        ),
      );
  }
}