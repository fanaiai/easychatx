import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'app/routes/app_pages.dart';

Future<void> initData() async {
  print('初始化开始');
  // 设置手机状态栏的样式
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white, // 设置状态栏的颜色
        statusBarIconBrightness: Brightness.dark, // 设置状态栏图标的亮度
        systemNavigationBarColor: Colors.black, // 设置系统导航栏的颜色
        systemNavigationBarIconBrightness: Brightness.dark, // 设置系统导航栏图标的亮度
      ),
    );
  // await Future.delayed(Duration(seconds: 10));
  FlutterNativeSplash.remove();
  print('初始化结束，关闭启动画面');
}

void main() async {
  // 如果需要异步初始化，必须执行下面的方法 ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // 显示启动画面
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // 程序启动时初始化，并持续到初始化结束
  await initData();

  runApp(ScreenUtilInit(
    designSize: const Size(750, 1334),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return GetMaterialApp(
          theme: ThemeData(fontFamily: 'iconfontxiannvzuo'),
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          routingCallback: (routing) {
            print(routing?.current);
          });
    },
  ));
}
