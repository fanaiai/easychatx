import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware{
  var isLogin=true;
  @override
  RouteSettings? redirect(String? route) {
    // TODO: implement redirect
    // return super.redirect(route);
    if (isLogin ||
        route == '/login') {
      return null;
    } else {
      Future.delayed(
          Duration(seconds: 1), () => Get.snackbar("提示", "登录过期,请重新登录"));
      return RouteSettings(name: '/login');
    }
  }
}