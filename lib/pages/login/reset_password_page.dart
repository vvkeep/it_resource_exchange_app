import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/routes/it_router.dart';
import 'package:it_resource_exchange_app/routes/routes.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:async';

class RestPasswordPage extends StatefulWidget {
  RestPasswordPage({Key key, this.account, this.verityCode}) : super(key: key);

  final String account;
  final String verityCode;

  @override
  _RestPasswordPageState createState() => _RestPasswordPageState();
}

class _RestPasswordPageState extends State<RestPasswordPage> {
  String _password = '';
  String _password2 = '';

  @override
  void dispose() {
    super.dispose();
  }

  resetPassword() {
    NetworkUtils.resetPassword(this.widget.account, this._password, this.widget.verityCode).then((res) {
      if (res.status == 200) {
        // 注册成功，跳转回登录页面
        showToast("密码重置成功", duration: Duration(milliseconds: 1500));
        Future.delayed(Duration(milliseconds: 1500), () {
        // 保存成功，跳转到登录页面
        ITRouter.push(context, Routes.loginPage, {}, clearStack: true);
        });
      } else {
        showToast(res.message, duration: Duration(milliseconds: 1500));
      }
    });
  }

  Widget _buildTipIcon() {
    return new Padding(
      padding: const EdgeInsets.only(
          left: 40.0, right: 40.0, top: 30.0, bottom: 50.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center, //子组件的排列方式为主轴两端对齐
        children: <Widget>[
          new Image.asset(
            './assets/imgs/app_icon.png',
            width: 88.0,
            height: 88.0,
          ),
        ],
      ),
    );
  }

  Widget _bulidPasswordEdit() {
    var node = new FocusNode();
    Widget passwordEdit = new TextField(
      onChanged: (str) {
        _password = str;
        setState(() {});
      },
      decoration: new InputDecoration(
          hintText: '请输入至少6位密码',
          labelText: '输入新密码',
          hintStyle: new TextStyle(fontSize: 12.0, color: Colors.grey)),
      maxLines: 1,
      maxLength: 6,
      obscureText: true,
      //键盘展示为数字
      keyboardType: TextInputType.number,
      //只能输入数字
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      onSubmitted: (text) {
        FocusScope.of(context).requestFocus(node);
      },
    );

    return new Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0.0),
      child: new Stack(
        children: <Widget>[
          passwordEdit,
        ],
      ),
    );
  }

  Widget _bulidPasswordEdit2() {
    var node = new FocusNode();
    Widget passwordEdit = new TextField(
      onChanged: (str) {
        _password2 = str;
        setState(() {});
      },
      decoration: new InputDecoration(
          hintText: '请再次输入至少6位密码',
          labelText: '确认新密码',
          hintStyle: new TextStyle(fontSize: 12.0, color: Colors.grey)),
      maxLines: 1,
      maxLength: 6,
      obscureText: true,
      //键盘展示为数字
      keyboardType: TextInputType.number,
      //只能输入数字
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      onSubmitted: (text) {
        FocusScope.of(context).requestFocus(node);
      },
    );

    return new Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0.0),
      child: new Stack(
        children: <Widget>[
          passwordEdit,
        ],
      ),
    );
  }


  Widget _buildSubmitBtn() {
    return new Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: new RaisedButton(
        padding: new EdgeInsets.fromLTRB(150.0, 15.0, 150.0, 15.0),
        color: AppColors.PrimaryColor,
        textColor: Colors.white,
        disabledColor: AppColors.DisableTextColor,
        onPressed:
            (_password.isEmpty || _password2.isEmpty)
                ? null
                : () {
                    if (_password != _password2) {
                      showToast("密码输入不一致");
                      return;
                    }
                    resetPassword();
                  },
        child: new Text(
          '确 定',
          style: new TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text("重置密码", style: TextStyle(color: Colors.white)),
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.white,
            )),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent, //解决透明区域不响应事件
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTipIcon(),
                _bulidPasswordEdit(),
                _bulidPasswordEdit2(),
                _buildSubmitBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
