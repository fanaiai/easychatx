# getx

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# get_cli命令
[get_cli](https://pub.flutter-io.cn/packages/get_cli)

# 应用的配置项
- 应用名称 android/src/main/AndriodManifest.xml android:label="中文名"
# 图标库 flutter_launcher_icons
- 配置 pubspec.yaml
flutter_launcher_icons:
android: "launcher_icon"
ios: true
image_path: "images/logo.png"
min_sdk_android: 21 # android min sdk min:16, default 21
web:
    generate: true
    image_path: "images/logo.png"
    background_color: "#hexcode"
    theme_color: "#hexcode"
windows:
    generate: true
    image_path: "images/logo.png"
    icon_size: 48 # min:48, max:256, default: 48
macos:
    generate: true
    image_path: "images/logo.png"
- 执行 flutter pub run flutter_launcher_icons:main
# flutter_native_splash app闪屏配置，启动画面
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
- 创建flutter_native_splash.yaml 文件
- 执行dart run flutter_native_splash:create
- main中添加代码
    // 如果需要异步初始化，必须执行下面的方法 ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // 显示启动画面
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // 程序启动时初始化，并持续到初始化结束
  await initData();
  初始化结束则执行 FlutterNativeSplash.remove();
  注意initData一定是个异步的哦

# 应用key的生成 我感觉多个应用用一个秘钥也可以的 (https://blog.csdn.net/qq_27909209/article/details/125928975)
- 使用keytool工具 在java里面 执行 keytool -genkey -v -keystore c:/Users/USER_NAME/key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
- 在android文件夹下创建 key.properties文件
    storePassword=yuanyuan1987
    keyPassword=yuanyuan1987
    keyAlias=key
    storeFile=d:/project/flutter/justrecite/key.jks
- 




