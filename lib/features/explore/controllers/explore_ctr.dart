import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Nexus/core/models/user.dart';
import '../../../core/constant.dart';

class ExploreCtr extends GetxController {
  static ExploreCtr get instance => Get.find<ExploreCtr>();

  final allUsers = <UserModel>[].obs;
  final searchedUsers = <UserModel>[].obs;
  final filteredUsers = <UserModel>[].obs;
  final myProfile = const UserModel(
          id: "", name: '', username: "", email: "", age: 0, gender: "")
      .obs;
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var education = ''.obs;
  var church = ''.obs;
  var ageRange = <int>[].obs;
  var rangeValues = const RangeValues(25, 50).obs;
  var exploreError = "".obs;

  getAllUsers() async {
    var users = await db
        .collection(kUSER)
        .where(kREGPROGRESS, isEqualTo: "completed")
        .get();
    var data =
        users.docs.map((data) => UserModel.fromJson(data.data())).toList();
    allUsers.assignAll(data);
    for (var data in allUsers) {
      if (data.id == auth.currentUser!.uid) {
        myProfile.value = data;
        allUsers.where((users) => users.gender != myProfile.value.gender);
      }
    }
    print("this is all users == >${allUsers.length}");
  }

  getMyProfile() async {
    var user = await db.collection(kUSER).doc(auth.currentUser!.uid).get();
    var data = UserModel.fromJson(user.data()!);
    myProfile.value = data;
  }

  searchCountry(String country) async {
    exploreError.value = "";
    isLoading.value = true;
    searchedUsers.clear();
    filteredUsers.clear();

    await Future.delayed(
        const Duration(seconds: 2), () => isLoading.value = false);
    allUsers
        .where((val) =>
            val.gender.toLowerCase() != myProfile.value.gender.toLowerCase())
        .toList()
        .forEach((vals) {
      if (country.toLowerCase().contains(vals.country!.toLowerCase())) {
        searchedUsers.add(vals);
        filteredUsers.add(vals);
      }
      if (searchedUsers.isEmpty || filteredUsers.isEmpty) {
        exploreError.value =
            "Sorry, No Users in this Country Yet. Check Back Later!!";
      }
    });
    print(
        "THis is for searched users ${searchedUsers.length} this is filtered ${filteredUsers.length}  and this is ${exploreError.value}");
    isLoading.value = false;
  }

  filterUsers() async {
    await generateNumberList(
        rangeValues.value.start.toInt(), rangeValues.value.end.toInt());

    isLoading.value = true;
    Get.back();
    await Future.delayed(
        const Duration(seconds: 2), () => isLoading.value = false);
    var filtered =
        filterUser(searchedUsers, ageRange, education.value, church.value);
    for (var user in filtered) {
      print(
          'Age: ${user.age}, Education: ${user.educationLevel}, Church: ${user.churchName}');
    }
    searchedUsers.assignAll(filtered);
    if (searchedUsers.isEmpty) {
      exploreError.value =
          "There are currently no profiles matching your request!";
    }
  }

  filterUser(List<UserModel> users, List<int> ageRange, String? education,
      String? church) {
    return users.where((user) {
      bool ageMatch = ageRange.isEmpty || ageRange.contains(user.age);
      bool churchMatch =
          church == null || church.isEmpty || user.churchName == church;
      bool educationMatch = education == null ||
          education.isEmpty ||
          user.educationLevel == education;
      return ageMatch && churchMatch && educationMatch;
    }).toList();
  }

  generateNumberList(int startNumber, int endNumber) {
    ageRange.assignAll(List<int>.generate(
        endNumber - startNumber + 1, (index) => startNumber + index));
    print("${ageRange.length}");
  }

  resetFilter() {
    searchedUsers.assignAll(filteredUsers);
    ageRange.clear();
    rangeValues = const RangeValues(25, 50).obs;
    education.value = "";
    church.value = "";
  }

  setOnlineStatus(bool isOnline) {
    db
        .collection(kUSER)
        .doc(auth.currentUser!.uid)
        .update({"isOnline": isOnline});
  }

  @override
  void onInit() {
    getAllUsers();
    super.onInit();
  }
}
