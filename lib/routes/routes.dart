import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {

  static String rootPage = "/";
  
  static String mainPage = "/main";

  static String loginPage = "/login";

  static String registerPage = "/registerPage";

  static String resetPasswordVerityPage = "/resetPasswordVerityPage";
  
  static String resetPasswordPage = "/resetPasswordPage";

  static String perfectInfoPage = "/perfectInfoPage";

  static String productDetailPage = "/productDetailPage";

  static String webPage = "/webPage";

  static String myProductListPage = "/myProductList";

  static String myCollectionListPage = "/myCollectionListPage";

  static String newProductPage = "/newProductPage";

  static String moviePlayerPage = "/moviePlayerPage";

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
       print("ROUTE WAS NOT FOUND !!!");
       return null;
    });

    router.define(rootPage, handler: rootHandler);
    router.define(mainPage, handler: mainHandler);
    router.define(productDetailPage, handler: productDetailHandler);
    router.define(webPage, handler: webHandler);
    router.define(myProductListPage, handler: myProductListHandler);
    router.define(myCollectionListPage, handler: myCollectionListHandler);
    router.define(newProductPage, handler: newProductHandler);
    router.define(loginPage, handler:loginHandler);
    router.define(registerPage, handler:registerHandler);
    router.define(perfectInfoPage, handler:perfectInfoHander);
    router.define(resetPasswordVerityPage, handler:resetPassworVerityHandler);
    router.define(resetPasswordPage, handler:resetPassworHandler);
    router.define(moviePlayerPage, handler:videoPlayerHandler);
  }

}