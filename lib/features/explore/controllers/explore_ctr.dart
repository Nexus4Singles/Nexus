import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexus/core/models/user.dart';

class ExploreCtr extends GetxController {
  final allUsers = <UserModel>[].obs;
  final db = FirebaseFirestore.instance;

  getAllUsers() async {
    var users = await db.collection("users").get();
    var data =
        users.docs.map((data) => UserModel.fromJson(data.data())).toList();
    allUsers.assignAll(data);
    print("this is all users == >${allUsers.length}");
  }

  @override
  void onInit() {
    getAllUsers();
    super.onInit();
  }
}
