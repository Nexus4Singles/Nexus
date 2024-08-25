import 'package:get/get.dart';

import '../../explore/controllers/explore_ctr.dart';
import '../../match/controllers/matches_ctr.dart';
import '../../profile/presentation/controllers/profile_ctr.dart';
import '../controllers/home_controller.dart';
import '../controllers/notification_controller.dart';

// here
class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(NotificationController());
    Get.put(ExploreCtr());
    Get.put(MatchesCtr());
    Get.put(ProfileCtr());
  }
}
