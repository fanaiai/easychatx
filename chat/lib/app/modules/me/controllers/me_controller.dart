import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../app/util/index.dart';

class MeController extends GetxController {
  //TODO: Implement MeController
  var notice = '感谢您使用我们的应用程序！使用前请务必仔细阅读免责声明！'.obs;
  var mianze =
      '免责声明：感谢您使用我们开发的应用程序。在使用本应用程序之前，请仔细阅读以下免责声明。通过使用本应用程序，您确认并接受以下内容：\n1.信息准确性：本应用程序的目的是提供有关特定主题的信息和功能。我们努力确保所提供的信息准确、完整和最新，但不能保证信息的准确性或完整性。因此，对于因使用或依赖这些信息而导致的任何损失或损害，我们不承担任何责任。\n2.功能和稳定性：我们致力于确保应用程序的正常运行和稳定性。然而，由于技术限制、外部因素或其他不可预见的问题，应用程序可能会出现故障、中断或延迟。因此，我们不对应用程序的可用性、连续性或正常运行负责。\n3.第三方内容和链接：本应用程序可能包含第三方提供的内容、链接或广告。这些内容和链接是由第三方提供和控制的，我们无法控制其准确性、完整性和安全性。您通过访问或使用这些内容和链接所产生的风险和后果将完全由您自行承担。\n4.用户行为和责任：您在使用本应用程序时需遵守适用的法律法规和条款。您应对您使用应用程序的行为和结果负责。您应理解并接受，我们不对您使用应用程序的行为、内容或后果承担责任。\n5.安全和隐私：我们将尽力保护您的个人信息和隐私。然而，由于互联网的开放性和技术的不断发展，无法保证信息的绝对安全性。您在使用本应用程序时，需自行承担风险，并理解我们对于由于未经授权访问、数据泄露或其他安全问题导致的损失或损害概不负责。\n6.请不要向GPT发送任何敏感信息，因敏感信息导致的法律问题概不负责。\n7.其他免责事项：本免责声明不排除法律所允许的任何明示或默示的责任排除。在适用法律允许的最大范围内，我们明确声明不承担任何明示或默示的责任，包括但不限于商业适用性、特定目的的适用性和非侵权的保证。请注意，本免责声明适用于您使用本应用程序的所有方面。如果您不同意本免责声明的任何条款或条件，请停止使用本应用程序。如果您对本免责声明有任何疑问或需要进一步的信息'
          .obs;
  var http = Http();
  void getNotice() {
    var url = 'xx';
    http.get(url).then((res) {
      notice.value = res['data'];
    }).catchError((onError) {});
  }

  @override
  void onInit() {
    super.onInit();
    getNotice();
  }

  @override
  void onReady() {
    super.onReady();
    print('onReady');
  }

  @override
  void onClose() {
    print('什么时候调close?');
    super.onClose();
  }
}
