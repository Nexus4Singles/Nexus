import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/constant.dart';
import '../../../core/models/user.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/fcm.dart';
import '../../../core/utils/shared_pref.dart';
import '../../explore/controllers/explore_ctr.dart';

enum RecommendedState {
  hasExceededForTheDay,
  hasNotExceededButEmpty,
  hasNotExceeded,
}

class HomeController extends GetxController {
  static HomeController get instance => Get.find<HomeController>();
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final explore = ExploreCtr.instance;
  var allUsers = <UserModel>[].obs;
  List<UserModel> recommendationList = [];
  final RxInt _viewedCount = 0.obs;

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
    var unRecommendUsers = <String>[];
    var matchedUsers = <String>[];
    var savedUsers = <String>[];
    var likedUsers = <String>[];
    unRecommendUsers.assignAll(user.value.unRecommendUsers ?? []);
    matchedUsers.assignAll(user.value.matchedUsers ?? []);
    savedUsers.assignAll(user.value.mySaves ?? []);
    likedUsers.assignAll(user.value.myLikes ?? []);
    allUsers.assignAll(explore.allUsers
        .where((e) => e.gender != user.value.gender)
        .where((el) => el.registrationProgress == 'completed')
        .where((data) => !matchedUsers.contains(data.id))
        // .where((data) => !savedUsers.contains(data.id))
        .where((data) => !likedUsers.contains(data.id))
        .where((u) => !unRecommendUsers.contains(u.id))
        .toList());
    allUsers.shuffle();
    debugPrint(
        "This is a list of all my recommended users == > ${allUsers.length}");

    isLoading.value = false;
  }

  final user = const UserModel(
          id: "", name: '', username: "", email: "", age: 0, gender: "")
      .obs;

  String _backDateRecommendedTime() {
    DateTime now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 13));
    return yesterday.toIso8601String();
  }

  getMyProfile() async {
    await db.collection(kUSER).doc(auth.currentUser!.uid).get().then((val) {
      var userData = val.data();
      user.value = UserModel.fromJson(userData!);
      print(
          "This is the amount of image left here ${user.value.photos?.length}");

      //save the time locally
      if (userData['recommendedTime'] != null) {
        SharedPref.setString('recommendedTime', user.value.recommendedTime!);
      }
      // log('this is my id:  ${user.value.id}');
      if (userData['recommendedTime'] == null) {
        db.collection(kUSER).doc(auth.currentUser!.uid).update({
          'recommendedTime': _backDateRecommendedTime(),
          'matchedUsers': [],
          'myLikes': [],
          'unRecommendUsers': [],
        });

        update();
        refresh();
      }

      SharedPref.setString("email", user.value.email);
      getFilteredUsers(false);
    });
  }

// CHECK 12 HOURS TIME BEFORE VIEW
  Duration calculateCountDownTime() => DateTime.now().difference(
      user.value.recommendedTime.toDate().add(const Duration(hours: 12)));
  int calculateTimeLeftToView() =>
      DateTime.now().difference(user.value.recommendedTime.toDate()).inHours;
  bool checkTimeIsAbove12hrs() => calculateTimeLeftToView() >= 12;

  //
// ----------------- RECOMMENDED USERS FUNCTION -----------------------
  List<UserModel> getRecommendedUsers() {
    final myProfile = user.value;
    final allUsersList = explore.allUsers.call();

    //CHECK IF IT'S ALREADY IN RECOMMENDED
    bool isNotInMyLikes(String othersUID) {
      if (myProfile.myLikes.isNotNull() && othersUID.isNotEmptyOrNull()) {
        return !myProfile.myLikes!.contains(othersUID);
      }
      return false;
    }

    //IF IT'S NOT IN OUR UNRECOMMENDED
    bool isNotUnrecommendedUsers(String othersUID) {
      if (myProfile.unRecommendUsers.isNotNull() &&
          othersUID.isNotEmptyOrNull()) {
        return !myProfile.unRecommendUsers!.contains(othersUID);
      }
      return false;
    }

    //FOR GENDER
    bool isDifferentGender(String gender) =>
        myProfile.gender.toLowerCase() != gender.toLowerCase();

    // FOR NATIONALITY
    bool isSameCountry(String country) => myProfile.country.isNotEmptyOrNull()
        ? myProfile.country!.toLowerCase() == country.toLowerCase()
        : false;

    // FOR AGE RANGE
    bool ageRange(int otherAge) {
      // for females
      if (myProfile.gender.toLowerCase() == 'female') {
        if (otherAge <= (myProfile.age + 15)) {
          return true;
        }
        return false;
      }
      // for males
      else {
        if (otherAge >= (myProfile.age + 3)) {
          return false;
        }
        return true;
      }
    }

    recommendationList = allUsersList
        .where((otherUsers) =>
            isDifferentGender(otherUsers.gender) &&
            isSameCountry(otherUsers.country ?? '') &&
            isNotUnrecommendedUsers(otherUsers.id) &&
            isNotInMyLikes(otherUsers.id) &&
            // checkTimeIsAbove12hrs() &&
            ageRange(otherUsers.age))
        .toList();
    // recommendationList.shuffle();
    update();

    return recommendationList.take(10).toList();
  }

  set count(int value) => _viewedCount.value = value;
  int get viewedCount => _viewedCount.value;

  void incrementViews() {
    _viewedCount.value++;

    if (viewedCount >= getRecommendedUsers().length ||
        getRecommendedUsers().isEmpty) {
      db.collection(kUSER).doc(auth.currentUser!.uid).update({
        'recommendedTime': DateTime.now().toIso8601String(),
      });
    }
  }

  // bool hasExceededViewedCount() => viewedCount < getRecommendedUsers().length ? false : true;

  RecommendedState recommendedState() {
    if (checkTimeIsAbove12hrs()) {
      if (getRecommendedUsers().isEmpty) {
        log('i have not exceeded but empty', name: 'state');
        return RecommendedState.hasNotExceededButEmpty;
      }
      log('i have recommended list', name: 'state');
      return RecommendedState.hasNotExceeded;
    } else {
      log('i have exceeded for the day', name: 'state');
      return RecommendedState.hasExceededForTheDay;
    }
  }
}

extension StringExtension on String? {
  bool isNotEmptyOrNull() => this != null && this?.isNotEmpty == true;
  DateTime toDate() => this != null
      ? DateTime.parse(this!)
      : DateTime.now().subtract(const Duration(days: 3));
}

extension ListOfItemsExtension on List? {
  bool isNotNull() => this != null;
  bool isNotEmptyOrNull() => isNotNull() && this?.isNotEmpty == true;
}
