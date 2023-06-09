import 'package:get/get.dart';

import '../controllers/index_controller.dart';
import '../../../../app/modules/home/controllers/home_controller.dart';
import '../../../../app/modules/me/controllers/me_controller.dart';
import '../../../../app/values/index.dart';
// 需要将其他tab页的controller绑定进来，否则其他页面找不到controller

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndexController>(
      () => IndexController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<MeController>(
      () => MeController(),
    );
    Get.lazyPut<MeController>(
      () => MeController(),
    );
    Get.lazyPut<TabValueController>(
      () => TabValueController(),
    );
  }
}
