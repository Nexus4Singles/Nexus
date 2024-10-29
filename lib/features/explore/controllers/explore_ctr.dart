import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/constant.dart';
import '../../../core/models/user.dart';
import '../../../core/utils/app_logger.dart';

class ExploreCtr extends GetxController {
  static ExploreCtr get instance => Get.find<ExploreCtr>();

  final allUsers = <UserModel>[].obs;
  final searchedUsers = <UserModel>[].obs;
  final filteredUsers = <UserModel>[].obs;
  final myProfile = const UserModel(
    id: "",
    name: '',
    username: "",
    email: "",
    age: 0,
    gender: "",
  ).obs;
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var education = ''.obs;
  var church = ''.obs;
  var ageRange = <int>[].obs;
  var country = ''.obs;
  var incomeSource = ''.obs;
  var relationshipLongDistancePreference = ''.obs;
  var maritalStatus = ''.obs;
  var hasKids = ''.obs;
  var genotype = ''.obs;
  var rangeValues = const RangeValues(25, 50).obs;
  var exploreError = "".obs;

  Future<void> getAllUsers() async {
    var usersSnapshot = await db
        .collection(kUSER)
        .where(kREGPROGRESS, isEqualTo: "completed")
        .get();

    var fetchedUsers = usersSnapshot.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();

    var currentUserId = auth.currentUser?.uid;
    if (currentUserId == null) {
      debugPrint("No authenticated user found");
      allUsers.assignAll(fetchedUsers);
      return;
    }

    UserModel? myProfileUser = fetchedUsers.firstWhere(
        (user) => user.id == currentUserId,
        orElse: () => myProfile.value);
    myProfile.value = myProfileUser;
    debugPrint("My profile gender: ${myProfile.value.gender}");

    var filteredUsers = fetchedUsers
        .where((user) => user.gender != myProfile.value.gender)
        .toList();

    allUsers.assignAll(filteredUsers);
  }

  getMyProfile() async {
    var user = await db.collection(kUSER).doc(auth.currentUser!.uid).get();
    var data = UserModel.fromJson(user.data()!);
    myProfile.value = data;
  }

  searchCountry(String place) async {
    exploreError.value = "";
    isLoading.value = true;
    searchedUsers.clear();
    filteredUsers.clear();
    allUsers.where((val) => val.gender != myProfile.value.gender);

    await Future.delayed(
      const Duration(seconds: 2),
      () => isLoading.value = false,
    );

    for (var vals in allUsers) {
      if (vals.location!.country!.toLowerCase().contains(place.toLowerCase())) {
        searchedUsers.add(vals);
        filteredUsers.add(vals);
      }
    }
    isLoading.value = false;
    if (searchedUsers.length.isLowerThan(1) ||
        filteredUsers.length.isLowerThan(1)) {
      exploreError.value =
          "Sorry, No Users in this Country Yet. Check Back Later!!";
    }
  }

  filterUsers() async {
    await generateNumberList(
      rangeValues.value.start.toInt(),
      rangeValues.value.end.toInt(),
    );

    isLoading.value = true;
    // Get.back();

    await Future.delayed(
      const Duration(seconds: 2),
      () => isLoading.value = false,
    );

    log('$ageRange');

    var filtered = filterUser(
      allUsers,
      ageRange,
      education.value,
      church.value,
      country.value,
      incomeSource.value,
      relationshipLongDistancePreference.value,
      maritalStatus.value,
      hasKids.value,
      genotype.value,
    );

    // for (var user in filtered) {
    //   debugPrint(
    //     'Age: ${user.age}, Education: ${user.educationLevel}, Church: ${user.churchName}',
    //   );
    // }

    searchedUsers.assignAll(filtered ?? []);
    if (searchedUsers.isEmpty) {
      exploreError.value =
          "There are currently no profiles matching your request!";
    } else {
      exploreError.value = '';
    }
  }

  filterUser(
    List<UserModel> users,
    List<int> ageRange,
    String? education,
    String? church,
    String? country,
    String? incomeSource,
    String? relationshipDistancePreference,
    String? maritalStatusPreference,
    String? hasKidsPreference,
    String? genotypePreference,
  ) {
    return users.where((user) {
      bool ageMatch = ageRange.isEmpty || ageRange.contains(user.age);

      bool countryMatch = (country == null || country.isEmpty) ||
          (country == 'Diaspora'
              ? user.location!.country != 'Nigeria'
              : country == 'Any'
                  ? true
                  : user.location!.country == country);

      bool churchMatch =
          church == null || church.isEmpty || user.churchName == church;

      bool educationMatch = (education == null || education.isEmpty) ||
          (education == 'Graduate'
              ? (user.educationLevel == 'Undergraduate Degree' ||
                  user.educationLevel == 'Postgraduate Degree' ||
                  user.educationLevel == 'Doctorate Degree (Phd.)')
              : true);

      bool incomeMatch = (incomeSource == null || incomeSource.isEmpty) ||
          (incomeSource == 'Yes'
              ? user.compatibility == null
                  ? true
                  : user.compatibility!.regularSourceOfIncome == incomeSource
              : true);

      bool distanceMatch = (relationshipDistancePreference == null ||
              relationshipDistancePreference.isEmpty) ||
          (relationshipDistancePreference == 'Any'
              ? true
              : user.compatibility == null
                  ? true
                  : user.compatibility!.longDistance ==
                      relationshipDistancePreference);

      bool maritalStatusMatch = (maritalStatusPreference == null ||
              maritalStatusPreference.isEmpty) ||
          (maritalStatusPreference == 'Any Status'
              ? true
              : user.compatibility == null
                  ? true
                  : user.compatibility!.maritalStatus ==
                      maritalStatusPreference);

      bool kidsPreferenceMatch =
          (hasKidsPreference == null || hasKidsPreference.isEmpty) ||
              (hasKidsPreference == 'No kids'
                  ? user.compatibility == null
                      ? true
                      : user.compatibility!.haveKids == 'No'
                  : true);

      bool genotypePreferenceMatch =
          (genotypePreference == null || genotypePreference.isEmpty) ||
              (genotypePreference == 'AA only'
                  ? user.compatibility == null
                      ? true
                      : user.compatibility!.genotype == 'AA'
                  : true);

      return ageMatch &&
          countryMatch &&
          churchMatch &&
          educationMatch &&
          incomeMatch &&
          distanceMatch &&
          maritalStatusMatch &&
          kidsPreferenceMatch &&
          genotypePreferenceMatch;
    }).toList()
      ..sort((a, b) {
        DateTime? dateA = a.profileCompletionDate;
        DateTime? dateB = b.profileCompletionDate;

        // Check if a has a profileCompletionDate and b does not
        if (dateA != null && dateB == null) {
          return -1; // a should come before b
        } else if (dateA == null && dateB != null) {
          return 1; // b should come before a
        } else {
          if (dateA == null && dateB == null) {
            return 0;
          }
          // Both have profileCompletionDate, sort by profileCompletionDate descending
          return dateB!
              .compareTo(dateA!); // Use the non-null assertion operator
        }
      });
  }

  generateNumberList(int startNumber, int endNumber) {
    ageRange.assignAll(List<int>.generate(
      endNumber - startNumber + 1,
      (index) => startNumber + index,
    ));
  }

  resetFilter() {
    searchedUsers.assignAll(filteredUsers);
    ageRange.clear();
    rangeValues = const RangeValues(25, 50).obs;
    education.value = "";
    church.value = "";
    country.value = '';
    incomeSource.value = '';
    relationshipLongDistancePreference.value = '';
    hasKids.value = '';
    genotype.value = '';
  }

  setOnlineStatus(bool isOnline) {
    db.collection(kUSER).doc(auth.currentUser!.uid).update({
      "isOnline": isOnline,
    });
  }

  @override
  void onInit() {
    getAllUsers();
    super.onInit();
  }
}
