import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/util/index.dart';
import '../../../../app/controller/gpt.dart';
import '../../me/controllers/me_controller.dart';
import 'package:intl/intl.dart' as intl;

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var http = Http();
  var loading = false.obs;
  var chatList = [].obs;
  var nomore = false;
  var userId = 'unknown' + DateTime.now().microsecondsSinceEpoch.toString();
  final TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusScopeNode focusNode = FocusScopeNode();
  MeController meController = Get.find();
  Widget rendOneNode(c) {
    print(c);
    return Container(
        padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 20.w),
        decoration: BoxDecoration(
            color: c['role'] == 'user' ? Color(0xFFF5F5F5) : Colors.white),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.h),
              alignment:
                  c['role'] == 'user' ? Alignment.topRight : Alignment.topLeft,
              child: Text(
                intl.DateFormat('yyyy-MM-dd HH:mm:ss')
                    .format(c['created_time']),
                style: TextStyle(color: Color(0xff888888), fontSize: 20.sp),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment :chatList[i]['role']=='user'?MainAxisAlignment.start:MainAxisAlignment.start,
              textDirection:
                  c['role'] == 'user' ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Container(
                  child: Image.asset('images/${c['role']}.png',
                      width: 70.w, height: 70.w, fit: BoxFit.cover),
                ),
                Container(
                  width: 50.w,
                  height: 74.w,
                  margin: c['role'] == 'user' ?EdgeInsets.fromLTRB(10.w, 0, 0.w, 0):EdgeInsets.fromLTRB(10.w, 0, 0.w, 0),
                  child: TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: c['content']));
                    },
                    icon: Icon(
                      Icons.copy,
                      size: 28.sp,
                    ),
                    label: Text(''),
                    style: ButtonStyle(
                        alignment: Alignment.center,
                        padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                  ),
                ),
                Container(
                  width: 500.w,
                  margin: c['role'] == 'user' ?EdgeInsets.fromLTRB(0.w, 10.w, 0.w, 0):EdgeInsets.fromLTRB(0.w, 10.w, 20.w, 0),
                  alignment: c['role'] == 'user'
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: Text(
                    c['content'],
                    style: TextStyle(
                        fontSize: 32.sp,
                        height: 1.5,
                        color: c['loading'] == true
                            ? Color(0xFF1C88EC)
                            : Colors.black),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  List<Widget> rendList() {
    List<Widget> list = [];
    for (var i = 0; i < chatList.length; i++) {
      var c = chatList[i];
      list.add(rendOneNode(c));
    }
    if (list.length <= 0 && !loading.value) {
      list.add(Container(
        padding: EdgeInsets.fromLTRB(40.w, 140.h, 40.w, 140.h),
        alignment: Alignment.center,
        child: Text(
          '还没有进行过对话，在页面下方输入您的问题，点击提交,当答案较长时，回答时间会比较长，请耐心等待',
          textAlign: TextAlign.center,
        ),
      ));
    } else if (loading.value) {
      var c = {
        "role": "assistant",
        "content": "小助手正在努力回答您的问题，请耐心等待哦...",
        "created_time": DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch),
        "loading": true
      };
      list.add(rendOneNode(c));
    }
    return list;
  }

  void getChatList(int dir, bool init) async {
    if (nomore) {
      return;
    }
    //上滑
    if (dir == -1) {
      var list = await getList(
          limit: 10,
          offset: chatList.length - 1,
          orderBy: 'modified_time desc');
      chatList.insertAll(0, list.reversed.map((value) {
        return value.toMap();
      }));
      print(chatList);
      if (list.length <= 0) {
        nomore = true;
      }
      if (init) {
        Future.delayed(Duration(milliseconds: 100)).then((_) {
          focusNode.unfocus();
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }
    }
  }

  void getResponse() {
    if (loading.value) {
      return;
    }
    loading.value = true;
    var chat = {
      "role": "user",
      "content": inputController.text,
      "created_time": DateTime.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch)
    };
    chatList.add(chat);
    insert(chat);
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      focusNode.unfocus();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
    var url = 'xx';
    http.post(url,
        data: {'content': inputController.text, 'user_id': userId}).then((res) {
      loading.value = false;
      var chat = {
        "role": "assistant",
        "content": "",
        "created_time": DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)
      };
      if (res['code'] == 200) {
        chat["content"] = res['data'];
      } else {
        chat["content"] = res['message'];
      }
      chatList.add(chat);
      insert(chat);
      Future.delayed(Duration(milliseconds: 100)).then((_) {
        focusNode.unfocus();
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
      inputController.text = '';
    }).catchError((onError) {
      loading.value = false;
    });
  }

  @override
  void onInit() {
    super.onInit();
    
    initPlatformState().then((value) {
      userId = value['brand'] + value['id'];
    });
    getChatList(-1, true);
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        // 到达列表底部，触发加载更多数据的逻辑
        getChatList(1, false);
      }
      if (scrollController.offset < 100) {
        getChatList(-1, false);
      }
    });
  }

  @override
  void onReady()  {
    super.onReady();


  }

  @override
  void onClose() {
    super.onClose();
    print('close');
  }
}
