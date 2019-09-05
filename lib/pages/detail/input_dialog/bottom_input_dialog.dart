import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:oktoast/oktoast.dart';

class BottomInputDialog extends StatelessWidget {
  TextEditingController inputController = TextEditingController();

  ValueChanged<String> callback;

  BottomInputDialog({this.callback});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Column(
        children: <Widget>[
          Expanded(
              child: new GestureDetector(
            child: new Container(color: Colors.black38),
            onTap: () {
              Navigator.pop(context);
            },
          )),
          new Container(
              height: 80,
              color: AppColors.MidTextColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: inputController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '留下你的精彩吧！',
                          border: InputBorder.none,
                        ),
                        maxLines: 100,
                        autofocus: true,
                        textInputAction: TextInputAction.newline,
                      ),
                    ),
                    SizedBox(width: 10,),
                    MaterialButton(
                      color: AppColors.PrimaryColor,
                      textColor: Colors.white,
                      clipBehavior:Clip.antiAlias,
                      child: Text('发布', style:TextStyle(fontSize:14)),
                      onPressed: () {
                        String content = inputController.text;
                        if (content == null || content.isEmpty) {
                            showToast('评论内容不能为空');
                        }else {
                          this.callback(content);
                          Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
