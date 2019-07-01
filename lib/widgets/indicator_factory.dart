import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
 * Author: Jpeng
 * Email: peng8350@gmail.com
 * Time: 2018/5/30 上午10:25
 */

Widget buildDefaultHeader() {
  return new ClassicHeader(
    failedText: '刷新失败!',
    completeText: '刷新完成!',
    releaseText: '释放可以刷新',
    idleText: '下拉刷新哦!',
    failedIcon: new Icon(Icons.clear, color: Colors.black),
    completeIcon: new Icon(Icons.done, color: Colors.black),
    idleIcon: new Icon(Icons.arrow_downward, color: Colors.black),
    releaseIcon: new Icon(Icons.arrow_upward, color: Colors.black),
    refreshingText: '正在刷新...',
  );
}

Widget buildDefaultFooter() {
  return new ClassicFooter(
      idleIcon: new Icon(Icons.arrow_upward, color: Colors.black),
      loadingText: '正在加载中...',
      idleText: '上拉加载',
      noDataText: '没有更多数据');
}
