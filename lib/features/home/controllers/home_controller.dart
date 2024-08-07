import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/constant.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/core/services/api_service.dart';
import 'package:Nexus/core/services/fcm.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find<HomeController>();
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  void onReady() async {
    super.onReady();

    getMyProfile();
    FCMService.init();
    await ApiService.getToken();
  }

  final user = const UserModel(
          id: "", name: '', username: "", email: "", age: 0, gender: "")
      .obs;

  getMyProfile() async {
    var authUser = await db.collection(kUSER).doc(auth.currentUser!.uid).get();
    var data = UserModel.fromJson(authUser.data()!);
    user.value = data;
  }
}
