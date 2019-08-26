import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:it_resource_exchange_app/route/it_router.dart';
import 'package:it_resource_exchange_app/route/routes.dart';
import '../../net/network_utils.dart';
import '../../model/user_info.dart';
import '../../utils/user_utils.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> registKey = new GlobalKey();

  String _accountNum =
      UserUtils.getUserName().isEmpty ? "" : UserUtils.getUserName();
  String _password = '';

  login() {
    NetworkUtils.login(this._accountNum, this._password).then((res) {
      if (res.status == 200) {
        UserInfo userInfo = UserInfo.fromJson(res.data);
        UserUtils.saveUserInfo(userInfo);
        // 保存用户名
        UserUtils.saveUserName(this._accountNum);

        // 保存成功，跳转到首页
        ITRouter.push(context, Routes.mainPage, {},
            clearStack: true, transition: TransitionType.fadeIn);
      } else {
        showToast(res.message, duration: Duration(milliseconds: 1500));
      }
    });
  }

  Widget _buldAccountEdit() {
    var node = FocusNode();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: TextEditingController(text: _accountNum),
        onChanged: (value) {
          _accountNum = value;
        },
        decoration: InputDecoration(
          hintText: '请输入邮箱地址作为用户名',
          labelText: '账号',
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
      obscureText: true,
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

  Widget _buildLoginBtn() {
    return new Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: new RaisedButton(
        padding: new EdgeInsets.fromLTRB(150.0, 15.0, 150.0, 15.0),
        color: AppColors.PrimaryColor,
        textColor: Colors.white,
        disabledColor: AppColors.DisableTextColor,
        onPressed: (_accountNum.isEmpty || _password.isEmpty)
            ? null
            : () {
                login();
              },
        child: new Text(
          '登 录',
          style: new TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRegisterBtn() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0, bottom: 30.0),
      child: OutlineButton(
        padding: EdgeInsets.fromLTRB(150.0, 15.0, 150.0, 15.0),
        borderSide: BorderSide(
          color: AppColors.PrimaryColor,
          width: 1,
        ),
        child: Text("注册",
            style: TextStyle(fontSize: 16.0, color: AppColors.PrimaryColor)),
        onPressed: () {
          ITRouter.push(context, Routes.registerPage, {}).then((res) {
            if (res != null) {
              setState(() {
                this._accountNum = res;
              });
            }
          });
        },
      ),
    );
  }

  Widget _buildTipIcon() {
    return new Padding(
      padding: const EdgeInsets.only(
          left: 40.0, right: 40.0, top: 50.0, bottom: 50.0),
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

  Widget _forgetPasswordTipBtn() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              ITRouter.push(context, Routes.resetPasswordVerityPage, {'account': this._accountNum});
            },
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: 100,
                  height: 40,
                ),
                Text(
                  '忘记密码',
                  style: TextStyle(
                      color: AppColors.PrimaryColor,
                      fontSize: 15,
                      decoration: TextDecoration.underline),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Scaffold(
        key: registKey,
        backgroundColor: Colors.white,
        appBar: new AppBar(
            title: new Text('账号登录', style: TextStyle(color: Colors.white)),
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
                _buildTipIcon(),
                _buldAccountEdit(),
                _bulidPasswordEdit(),
                _forgetPasswordTipBtn(),
                _buildLoginBtn(),
                _buildRegisterBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
