import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/constant.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/core/services/api_service.dart';
import 'package:Nexus/core/services/fcm.dart';
import '../../../core/utils/shared_pref.dart';
import '../../explore/controllers/explore_ctr.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find<HomeController>();
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final explore = ExploreCtr.instance;
  var allUsers = <UserModel>[].obs;
  var isLoading = false.obs;
  var isEmpty = false.obs;

  @override
  void onInit() async {
    getMyProfile();
    super.onInit();
    FCMService.init();
    await ApiService.getToken();
  }

  getFilteredUsers(bool callApi) async {
    callApi ? await getMyProfile() : () {};
    isLoading.value = true;
    var unrecommendedUsers = <String>[];
    var matchedUsers = <String>[];
    var savedUsers = <String>[];
    var likedUsers = <String>[];
    unrecommendedUsers.assignAll(user.value.unrecommendedUsers ?? []);
    matchedUsers.assignAll(user.value.matchedUsers ?? []);
    savedUsers.assignAll(user.value.mySaves ?? []);
    likedUsers.assignAll(user.value.myLikes ?? []);
    allUsers.assignAll(explore.allUsers
        .where((e) => e.gender != user.value.gender)
        .where((el) => el.registrationProgress == 'completed')
        .where((data) => !matchedUsers.contains(data.id))
        // .where((data) => !savedUsers.contains(data.id))
        .where((data) => !likedUsers.contains(data.id))
        .where((u) => !unrecommendedUsers.contains(u.id))
        .toList());
    allUsers.shuffle();
    print("This is a list of all my recommended users == > ${allUsers.length}");

    isLoading.value = false;
  }

  final user = UserModel(
          id: "", name: '', username: "", email: "", age: 0, gender: "")
      .obs;

  getMyProfile() async {
    await db.collection(kUSER).doc(auth.currentUser!.uid).get().then((val) {
      user.value = UserModel.fromJson(val.data()!);
      SharedPref.setString("email", user.value.email);
      getFilteredUsers(false);
    });
  }
}
