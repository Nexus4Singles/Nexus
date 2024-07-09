import 'package:get/get.dart';
import 'package:nexus/core/services/api_service.dart';
import 'package:nexus/core/services/fcm.dart';

class HomeController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    FCMService.init();
    // await ApiService.getToken();
  }
}
