import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppColors;
import 'package:it_resource_exchange_app/route/it_router.dart';
import './utils/local_storage_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';
import './route/routes.dart';

void main() async {
  await LocalStorage.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final router = new Router();
    Routes.configureRoutes(router);
    ITRouter.initWithRouter(router);
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: Colors.black87,
      radius: 6.0,
      child: MaterialApp(
        title: 'IT换换',
        theme: ThemeData(
            primaryColor: AppColors.PrimaryColor,
            backgroundColor: Colors.white),
        onGenerateRoute: ITRouter.router().generator,
      ),
    );
  }
}
