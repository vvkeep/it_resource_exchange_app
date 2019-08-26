import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:it_resource_exchange_app/utils/regex_utils.dart';
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
  String _verityCode = '';

  bool isVerifyBtnEnable = false; //按钮状态 是否可点击
  String buttonText = '发送验证码'; //初始文本
  int count = 60; //初始倒计时时间
  Timer timer; //倒计时的计时器

  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          isVerifyBtnEnable = true; //按钮可点击
          count = 60; //重置时间
          buttonText = '发送验证码'; //重置按钮文本
        } else {
          buttonText = '重新发送($count)'; //更新文本内容
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel(); //销毁计时器
    timer = null;
    super.dispose();
  }

  register() {
    NetworkUtils.register(this._accountNum, this._password, this._verityCode).then((res) {
      if (res.status == 200) {
        // 注册成功，跳转回登录页面
        showToast("注册成功", duration: Duration(milliseconds: 1500));
        Future.delayed(Duration(milliseconds: 1500), () {
          Navigator.pop(this.context, this._accountNum);
        });
      } else {
        showToast(res.message, duration: Duration(milliseconds: 1500));
      }
    });
  }

  sendVerityCode() {
    NetworkUtils.sendCodeForRegister(this._accountNum).then((res) {
      if (res.status == 200) {
        // 注册成功，跳转回登录页面
        showToast("验证码发送成功", duration: Duration(milliseconds: 1500));

        //开始倒计时
        setState(() {
          if (isVerifyBtnEnable) {
            //当按钮可点击时
            isVerifyBtnEnable = false; //按钮状态标记
            _initTimer();
          } 
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

  Widget _buldAccountEdit() {
    var node = FocusNode();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        onChanged: (value) {
          _accountNum = value;
          if (this.count == 60) {
            setState(() {
              this.isVerifyBtnEnable = RegexUtils.isEmail(value);
            });
          }
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
          labelText: '输入密码',
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
          labelText: '确认密码',
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

  Widget _buildVerifyCodeBtn() {
    var node = new FocusNode();
    Widget passwordEdit = new TextField(
      onChanged: (str) {
        _verityCode = str;
        setState(() {});
      },
      decoration: new InputDecoration(
        hintText: '请输入验证码',
        labelText: '验证码',
        hintStyle: new TextStyle(fontSize: 12.0, color: Colors.grey),
      ),
      maxLines: 1,
      maxLength: 6,
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

    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: passwordEdit,
          ),
          SizedBox(
            width: 25,
          ),
          Container(
            width: 120,
            child: OutlineButton(
              borderSide: BorderSide(
                color: AppColors.PrimaryColor,
                width: 1,
              ),
              disabledBorderColor: AppColors.ArrowNormalColor,
              disabledTextColor: AppColors.ArrowNormalColor,
              textColor: AppColors.PrimaryColor,
              child: Text(
                '$buttonText',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
              ),
              onPressed: this.isVerifyBtnEnable
                  ? () {
                      this.sendVerityCode();
                    }
                  : null,
            ),
          )
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
            (_accountNum.isEmpty || _password.isEmpty || _password2.isEmpty || _verityCode.isEmpty)
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
        body: GestureDetector(
          behavior: HitTestBehavior.translucent, //解决透明区域不响应事件
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTipIcon(),
                _buldAccountEdit(),
                _bulidPasswordEdit(),
                _bulidPasswordEdit2(),
                _buildVerifyCodeBtn(),
                _buildSubmitBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
