import 'package:get/get.dart';

import '../middlewares/index.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/index/bindings/index_binding.dart';
import '../modules/index/views/index_view.dart';
import '../modules/me/bindings/me_binding.dart';
import '../modules/me/views/me_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INDEX;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.size,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.ME,
        page: () => MeView(),
        binding: MeBinding(),
        transition: Transition.rightToLeft,
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: _Paths.INDEX,
      page: () => const IndexView(),
      binding: IndexBinding(),
    ),
  ];
}
