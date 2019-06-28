import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import '../../net/network_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:async';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _accountNum = '';
  String _password = '';
  String _password2 = '';

  register() {
    NetworkUtils.register(this._accountNum, this._password).then((res) {
      if (res.status == 200) {
        // 注册成功，跳转回登录页面
        showToast("注册成功", duration: Duration(milliseconds: 1500));
        Future.delayed(Duration(milliseconds: 1500), (){
          Navigator.pop(this.context);
        });
      } else {
        showToast(res.message, duration: Duration(milliseconds: 1500));
      }
    });
  }

  Widget _buildTipIcon() {
    return new Padding(
      padding: const EdgeInsets.only(
          left: 40.0, right: 40.0, top: 50.0, bottom: 50.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center, //子组件的排列方式为主轴两端对齐
        children: <Widget>[
          new Image.asset(
            'assets/imgs/ic_collections.png',
            width: 60.0,
            height: 60.0,
          ),
        ],
      ),
    );
  }

  Widget _buldAccountEdit() {
    var node = FocusNode();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        onChanged: (value) {
          _accountNum = value;
        },
        decoration: InputDecoration(
          hintText: '请输入邮箱地址作为用户名',
          labelText: '账号',
          hintStyle: TextStyle(
              fontSize: 12.0, color: Color(AppColors.ArrowNormalColor)),
        ),
        maxLines: 1,
        maxLength: 15,
        keyboardType: TextInputType.emailAddress,
        onSubmitted: (value) {
          FocusScope.of(context).reparentIfNeeded(node);
        },
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
          labelText: '密码',
          hintStyle: new TextStyle(fontSize: 12.0, color: Colors.grey)),
      maxLines: 1,
      maxLength: 6,
      //键盘展示为数字
      keyboardType: TextInputType.number,
      //只能输入数字
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      onSubmitted: (text) {
        FocusScope.of(context).reparentIfNeeded(node);
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
          hintText: '请输入至少6位密码',
          labelText: '密码',
          hintStyle: new TextStyle(fontSize: 12.0, color: Colors.grey)),
      maxLines: 1,
      maxLength: 6,
      //键盘展示为数字
      keyboardType: TextInputType.number,
      //只能输入数字
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      onSubmitted: (text) {
        FocusScope.of(context).reparentIfNeeded(node);
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
        disabledColor: AppColors.PrimaryColor[100],
        onPressed:
            (_accountNum.isEmpty || _password.isEmpty || _password2.isEmpty)
                ? null
                : () {
                    if (_password != _password2) {
                      showToast("密码输入不一致");
                      return;
                    }
                    register();
                  },
        child: new Text(
          '注册',
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
              title: Text("账号注册", style: TextStyle(color: Colors.white)),
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: Colors.white,
              )),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTipIcon(),
                _buldAccountEdit(),
                _bulidPasswordEdit(),
                _bulidPasswordEdit2(),
                _buildSubmitBtn()
              ],
            ),
          )),
    );
  }
}
