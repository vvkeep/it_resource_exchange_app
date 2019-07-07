import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors;

class NewGoodsTextField extends StatelessWidget {
  const NewGoodsTextField({Key key, this.hintText, this.onChanged})
      : super(key: key);

  final String hintText;

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: AppSize.DividerWidth,
            color: AppColors.DividerColor,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 5),
          TextField(
            decoration:
                InputDecoration(hintText: hintText, border: InputBorder.none),
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
