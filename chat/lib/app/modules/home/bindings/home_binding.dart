import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../me/controllers/me_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<MeController>(
      () => MeController(),
    );

  }
}
