import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppColors;
import './pages/application_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT资源交换',
      theme: ThemeData(
        primarySwatch: AppColors.PrimaryColor,
      ),
      home: ApplicationPage(),
    );
  }
}