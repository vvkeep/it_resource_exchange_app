import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppColors;
import './pages/application_page.dart';
import 'package:oktoast/oktoast.dart';
import './utils/user_utils.dart';
import './pages/login/login_page.dart';
import './utils/local_storage_utils.dart';

void main() async {
  await LocalStorage.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: Colors.black87,
      radius: 6.0,
      child: MaterialApp(
        title: 'IT资源',
        theme: ThemeData(
          primarySwatch: AppColors.PrimaryColor,
          backgroundColor: Colors.white
        ),
        home: UserUtils.isLogin() ? ApplicationPage() : LoginPage(),
      ),
    );
  }
}
