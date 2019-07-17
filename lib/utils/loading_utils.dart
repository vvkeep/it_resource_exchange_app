import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/widgets/loadingDialog.dart';

class LoadingUtils {
  
  static LoadingDialog loadingDialog = LoadingDialog();

  static showLoading(BuildContext context) {
        showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return loadingDialog;
        });


  }

  static hideLoading(BuildContext context) {
       
  }

}