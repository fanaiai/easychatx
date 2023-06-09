import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../me/controllers/me_controller.dart';
import '../../../util/http.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Obx(() => Container(
              // height: 1000.h,
              // color:Colors.red,
              padding: EdgeInsets.only(bottom:150.h),
              // decoration: BoxDecoration,
              child: ListView(
                controller: controller.scrollController,
                children: controller.rendList(),
              ),
            )),
        Positioned(
            bottom: 0.h,
            left: 0,
            child: Container(
              width: 750.w,
              height: 150.h,
              decoration: BoxDecoration(
                  // color: Color(0xfefefe),
                  color:Colors.white,
                  border: Border(top: BorderSide(color: Color(0xffefefef)))),
              child: 
              Container(
                width: 750.w,
                height: 150.h,
                child:Stack(
                children: [
                  Positioned(
                      child: FocusScope(
                          node: controller.focusNode,
                          child: TextField(
                            maxLines: 2,
                            style: TextStyle(fontSize: 26.sp),
                            controller: controller.inputController,
                            decoration: InputDecoration(
                              suffix: Container(
                                // height: 120.h,
                                transform:
                                    Matrix4.translationValues(0, 10.h, 0.0),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.inputController.clear();
                                  },
                                  child: Icon(Icons.clear),
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(40.w, 10.h, 40.w, 10.h),
                              border: InputBorder.none,
                              hintText: '输入你的问题',
                            ),
                          ))),
                  Positioned(
                      bottom: 10.w,
                      right: 10.w,
                      child: OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Color(0xFF0C54F1)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // 设置圆角半径为20
                              ),
                            ),
                          ),
                          onPressed: () {
                            controller.getResponse();
                          },
                          child: Obx(() => Text(
                                controller.loading.value ? '答案生成中' : '提交',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 32.sp),
                              ))))
                ],
              )),
            )
            )
      ],
    ));
  }
}
