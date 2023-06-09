import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/index_controller.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);
// 底部导航
  Widget _buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
          items: controller.bottomTabs,
          currentIndex: controller.page.value,
          // fixedColor: AppColors.primaryElement,
          type: BottomNavigationBarType.fixed,
          onTap: controller.handleNavBarTap,
          selectedLabelStyle:TextStyle(color: Colors.red),
          selectedItemColor:Color(0xFF176AE7)
        ));
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Chat'),
      //   centerTitle: true,
      // ),
      body: Obx(()=>IndexedStack(
        index:controller.page.value,
        children: controller.pageList,
      )),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
