import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors;
import 'package:flutter/services.dart';

class NewGoodsTextField extends StatelessWidget {
  const NewGoodsTextField({Key key,this.inputFormatters, this.keyboardType, this.hintText, this.onChanged})
      : super(key: key);

  final String hintText;

  final ValueChanged<String> onChanged;

  final List<TextInputFormatter> inputFormatters;

  final TextInputType keyboardType;

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
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            decoration:
                InputDecoration(hintText: hintText, border: InputBorder.none),
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
