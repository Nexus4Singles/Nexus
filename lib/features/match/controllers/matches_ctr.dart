import 'package:dartz/dartz_unsafe.dart';
import 'package:get/get.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/features/explore/controllers/explore_ctr.dart';

class MatchesCtr extends GetxController {
  var isLoading = false.obs;
  var ctr = Get.put(ExploreCtr());
  var emptyText = "".obs;
  var userData = <UserModel>[].obs;

  setMyLikes() {
    emptyText.value = "You have not liked any profiles yet.";
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () => isLoading.value = false);
    userData.clear();
    var myLikes = ctr.myProfile.value.myLikes?.toSet() ?? {};
    userData.assignAll(
        ctr.allUsers.where((user) => myLikes.contains(user.id)).toList());
  }

  setLikedMe() {
    emptyText.value = "You don’t have any likes yet";

    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () => isLoading.value = false);
    userData.clear();
    var likedMes = ctr.myProfile.value.likeMe?.toSet() ?? {};
    userData.assignAll(
        ctr.allUsers.where((user) => likedMes.contains(user.id)).toList());
  }

  setSaved() {
    emptyText.value = "You don't have any saved profiles yet";
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () => isLoading.value = false);
    userData.clear();
    var savedIds = ctr.myProfile.value.mySaves?.toSet() ?? {};
    userData.assignAll(
        ctr.allUsers.where((user) => savedIds.contains(user.id)).toList());
  }

  @override
  void onInit() {
    setMyLikes();
    super.onInit();
  }
}
