import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/util/index.dart';
import '../../../../app/modules/home/views/home_view.dart';
import '../../../../app/modules/me/views/me_view.dart';
import '../../../../app/modules/me/controllers/me_controller.dart';
import '../../../../app/modules/home/controllers/home_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../../app/values/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexController extends GetxController {
  //TODO: Implement IndexController
  TabValueController tab = Get.find();
  var page;
  var bottomTabs;
  MeController meController = Get.find();
  HomeController homeController = Get.find();
  // 页控制器
  late final PageController pageController;
  var _prefs;
  var prefs;
  void handleNavBarTap(int index) {
    tab.changeTab(index);
    homeController.focusNode.unfocus();
  }

  var pageList;
  void onPageChanged(int index) {}
  @override
  void onInit() {
    super.onInit();
    _prefs = SharedPreferences.getInstance();
    // Get.putAsync<StorageService>(() => StorageService().init());
    page = tab.index;
    bottomTabs = tab.bottomTabs;
    pageList = [HomeView(), MeView(param: tab.params.value, query: tab.querys)];
    pageController = new PageController();
  }

  @override
  void onReady() async {
    super.onReady();
    try {
      final SharedPreferences prefs = await _prefs;
      var mianzeshow = prefs.getBool('mianzeshow')??false;
       if (mianzeshow) {
      return;
    }
    Get.dialog(
      AlertDialog(
        title: Text('免责声明'),
        content: Container(
          height: 800.h,
          width: 600.w,
          child: ListView(
            // children:[Text('aa')]
            children: [Obx(() => Text(meController.mianze.value))],
          ),
        ),
        actions: [
          TextButton(
            child: Text('确定'),
            onPressed: () {
              // 处理确定按钮的点击事件
              Get.back(); // 关闭弹出层
             prefs.setBool('mianzeshow',true);
            },
          ),
        ],
      ),
    );
    } catch (e) {
    };

    // var mianzeshow = StorageService.to.getBool('mianzeshow');

   
  }

  @override
  void onClose() {
    super.onClose();
  }
}
