import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:it_resource_exchange_app/route/it_router.dart';
import 'package:it_resource_exchange_app/route/routes.dart';
import 'package:it_resource_exchange_app/utils/regex_utils.dart';
import '../../net/network_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:async';

class UserVerifyCodePage extends StatefulWidget {
  @override
  _UserVerifyCodePageState createState() => _UserVerifyCodePageState();
}

class _UserVerifyCodePageState extends State<UserVerifyCodePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String _accountNum = '';
  String _verifyCode = '';

  bool isVeriftyBtnEnable = false; //按钮状态 是否可点击
  String buttonText = '发送验证码'; //初始文本
  int count = 60; //初始倒计时时间
  Timer timer; //倒计时的计时器

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    timer?.cancel(); //销毁计时器
    timer = null;
    super.dispose();
    _controller.dispose();
  }

  sendVerityCode() {
    NetworkUtils.sendCodeForReset(this._accountNum).then((res) {
      if (res.status == 200) {
        // 注册成功，跳转回登录页面
        showToast("验证码发送成功", duration: Duration(milliseconds: 1500));

        //开始倒计时
        setState(() {
          if (isVeriftyBtnEnable) {
            //当按钮可点击时
            isVeriftyBtnEnable = false; //按钮状态标记
            _initTimer();
          }
        });
      } else {
        showToast(res.message, duration: Duration(milliseconds: 1500));
      }
    });
  }

  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          isVeriftyBtnEnable = true; //按钮可点击
          count = 60; //重置时间
          buttonText = '发送验证码'; //重置按钮文本
        } else {
          buttonText = '重新发送($count)'; //更新文本内容
        }
      });
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
              this.isVeriftyBtnEnable = RegexUtils.isEmail(value);
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
        onSubmitted: (value) {
          FocusScope.of(context).requestFocus(node);
        },
      ),
    );
  }

  Widget _buildVerifyCodeBtn() {
    var node = new FocusNode();
    Widget passwordEdit = new TextField(
      onChanged: (str) {
        _verifyCode = str;
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
              onPressed: this.isVeriftyBtnEnable
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
        onPressed: (_accountNum.isEmpty || _verifyCode.isEmpty)
            ? null
            : () {
                ITRouter.push(context, Routes.resetPasswordPage, {
                  'account': this._accountNum,
                  'verityCode': this._verifyCode
                });
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
    return Scaffold(
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
              _buldAccountEdit(),
              _buildVerifyCodeBtn(),
              _buildSubmitBtn()
            ],
          ),
        ),
      ),
    );
  }
}
