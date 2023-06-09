import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/me_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../../../app/values/index.dart';

class MeView extends GetView<MeController> {
  MeView({Key? key, String? param, Map? query}) : super(key: key);
  TabValueController tab = Get.find();
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Obx(
          () => Container(
            height: 1100.h,
            padding: EdgeInsets.fromLTRB(20.w, 00.w, 20.w, 0.w),
            child: ListView(
              children: [
                Container(
                  child: Text(
                    controller.notice.value,
                    style: TextStyle(fontSize: 30.sp, height: 2),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 20.h, 0, 40.h),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color(0xFF0C54F1)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // 设置圆角半径为20
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text('免责声明'),
                              content: Obx(() => Container(
                                    height: 800.h,
                                    width: 600.w,
                                    child: ListView(
                                      children: [Text(controller.mianze.value)],
                                    ),
                                  )),
                              actions: [
                                TextButton(
                                  child: Text('确定'),
                                  onPressed: () {
                                    // 处理确定按钮的点击事件
                                    Get.back(); // 关闭弹出层
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          '免责声明',
                          style:
                              TextStyle(color: Colors.white, fontSize: 32.sp),
                        )),
                    OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color(0xFF0C54F1)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // 设置圆角半径为20
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text('打个赏吧'),
                              content: Container(
                                height: 600.h,
                                width: 600.w,
                                child: ListView(
                                  children: [
                                    SelectableText(
                                        '项目地址：https://github.com/fanaiai/easychatx'),
                                    Container(
                                      margin: EdgeInsets.only(top: 40.w),
                                      child: Image.asset('images/1.png',
                                          width: 270.w,
                                          height: 500.w,
                                          fit: BoxFit.fill),
                                    )
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('确定'),
                                  onPressed: () {
                                    // 处理确定按钮的点击事件
                                    Get.back(); // 关闭弹出层
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          '给我打赏',
                          style:
                              TextStyle(color: Colors.white, fontSize: 32.sp),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
