import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppColors;
import './pages/application_page.dart';
import 'package:oktoast/oktoast.dart';
import './utils/user_utils.dart';
import './pages/login/login_page.dart';
import './utils/local_storage_utils.dart';
import 'package:flutter/services.dart';

void main() async {
  await LocalStorage.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white,
    ));
    return OKToast(
      textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: Colors.black87,
      radius: 6.0,
      child: MaterialApp(
        title: 'IT换换',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: AppColors.PrimaryColor,
            backgroundColor: Colors.white),
        home: UserUtils.isLogin() ? ApplicationPage() : LoginPage(),
      ),
    );
  }
}
