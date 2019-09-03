import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart';

class BottomInputDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Column(
        children: <Widget>[
          Expanded(
              child: new GestureDetector(
                child: new Container(
                  color: Colors.black38
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
          ),
          new Container(
              height: 80,
              color: AppColors.MidTextColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical:10),
                child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '留下你的精彩吧！',
                      border: InputBorder.none,
                    ),
                    maxLines: 100,
                    autofocus: true,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (value) {
                      print("$value");
                      Navigator.of(context).pop();
                    },
                  ),
                  )
                ],
              ),
              )
          )
        ],
      ),
    );
  }
}