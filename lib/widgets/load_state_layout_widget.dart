import 'package:flutter/material.dart';
import './loading_dialog.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppColors, APPIcons;
import 'package:it_resource_exchange_app/pages/login/login_page.dart';


//四种视图状态
enum LoadState { State_Success, State_Error, State_Loading, State_Empty, State_Max_Api_Times, State_Token_Exprie }

LoadState loadStateByErrorCode(int code) {
  LoadState state;

  switch (code) {
    case 401:
      state = LoadState.State_Token_Exprie;
      break;
    case 403:
      state = LoadState.State_Max_Api_Times;
      break;
    case -1: //网络错误
    case -2:
      state = LoadState.State_Error;
      break;
    default:
      assert(false,"网络请求返回未知错误状态$code");
      break;
  }
  return state;
}

///根据不同状态来展示不同的视图
class LoadStateLayout extends StatefulWidget {
  final LoadState state; //页面状态
  final Widget successWidget; //成功视图
  final VoidCallback errorRetry; //错误事件处理

  LoadStateLayout(
      {Key key,
      this.state = LoadState.State_Loading, //默认为加载状态
      this.successWidget,
      this.errorRetry})
      : super(key: key);

  @override
  _LoadStateLayoutState createState() => _LoadStateLayoutState();
}

class _LoadStateLayoutState extends State<LoadStateLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //宽高都充满屏幕剩余空间
      width: double.infinity,
      height: double.infinity,
      child: _buildWidget,
    );
  }

  ///根据不同状态来显示不同的视图
  Widget get _buildWidget {
    switch (widget.state) {
      case LoadState.State_Success:
        return widget.successWidget;
        break;
      case LoadState.State_Error:
        return _errorView;
        break;
      case LoadState.State_Loading:
        return LoadingDialog();
        break;
      case LoadState.State_Empty:
        return _emptyView;
        break;
      case LoadState.State_Max_Api_Times:
        return _maxApiTimesView;
        break;
      case LoadState.State_Token_Exprie:
        return _tokenExpireView;
        break;
      default:
        return null;
    }
  }

  ///错误视图
  Widget get _errorView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            APPIcons.NetworkErrorData,
            color: AppColors.PrimaryColor,
            size: 100,
          ),
          Text("加载失败，请重试"),
          RaisedButton(
            color: Color(0xffbc2929),
            onPressed: widget.errorRetry,
            child: Text(
              '重新加载',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  ///toekn 过期视图
  Widget get _tokenExpireView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            APPIcons.NetworkErrorData,
            color: AppColors.PrimaryColor,
            size: 100,
          ),
          Text("用户登录凭证过期, 点击重新登录"),
          RaisedButton(
            color: Color(0xffbc2929),
            onPressed: () {
              // token 过期 重新登录
              Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              '登录',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
  ///数据为空的视图
  Widget get _emptyView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            APPIcons.EmptyData,
            color: AppColors.PrimaryColor,
            size: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('暂无数据'),
          )
        ],
      ),
    );
  }

  ///数据为空的视图
  Widget get _maxApiTimesView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            APPIcons.EmptyData,
            color: AppColors.PrimaryColor,
            size: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('请求次数已经超过次数限制,请稍后再试~'),
          )
        ],
      ),
    );
  }
}
