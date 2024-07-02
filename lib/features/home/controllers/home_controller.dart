import 'package:get/get.dart';
import 'package:nexus/core/services/fcm.dart';

class HomeController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    FCMService.init();
  }
}
