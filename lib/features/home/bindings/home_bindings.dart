import 'package:get/get.dart';
import 'package:Nexus/features/explore/controllers/explore_ctr.dart';
import 'package:Nexus/features/home/controllers/home_controller.dart';
import 'package:Nexus/features/home/controllers/notification_controller.dart';
import 'package:Nexus/features/match/controllers/matches_ctr.dart';

// here
class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(NotificationController());
    Get.put(ExploreCtr());
    Get.put(MatchesCtr());
  }
}
