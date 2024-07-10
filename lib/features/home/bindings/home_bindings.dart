import 'package:get/get.dart';
import 'package:nexus/features/explore/controllers/explore_ctr.dart';
import 'package:nexus/features/home/controllers/home_controller.dart';
import 'package:nexus/features/home/controllers/notification_controller.dart';
import 'package:nexus/features/match/controllers/matches_ctr.dart';

// here
class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(NotificationController());
    Get.lazyPut<ExploreCtr>(() => ExploreCtr());
    Get.lazyPut<MatchesCtr>(() => MatchesCtr());
  }
}
