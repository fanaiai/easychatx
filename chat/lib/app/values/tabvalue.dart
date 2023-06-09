import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../app/modules/home/views/home_view.dart';
import '../../app/modules/me/views/me_view.dart';

class TabValueController extends GetxController {
  var index = 0.obs;
  var params = ''.obs;
  var querys = {}.obs;
  var bottomTabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_sharp), label: '我的'),
  ];

  final List routeList = ['/home', '/me'];

  TabValue(int i) {
    index.value = i;
  }

  void changeTab(int i, {String? param = '', Map? query}) {
    index.value = i;
    params.value = param ?? '';
    querys.value = query ?? {};
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    index.listen((p0) {
      print(p0);
    });
  }
}
