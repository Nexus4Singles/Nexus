import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/features/explore/controllers/explore_ctr.dart';
import 'package:nexus/features/match/presentation/views/matched.dart';
import '../../../core/constant.dart';
import '../../chat/controllers/chat_ctr.dart';

class MatchesCtr extends GetxController {
  var isLoading = false.obs;
  var ctr = Get.put(ExploreCtr());
  var chatCtr = Get.put(ChatCtr());
  var emptyText = "".obs;
  var userData = <UserModel>[].obs;
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

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

  checkLikedAlready(String id) {
    return ctr.myProfile.value.myLikes!.contains(id);
  }

  checkSavedAlready(String id) {
    return ctr.myProfile.value.mySaves!.contains(id);
  }

  Future<void> toggleLike(userModel) async {
    EasyLoading.show();
    if (ctr.myProfile.value.likeMe!.contains(userModel.id)) {
      await removeFromLikeMe(userModel.id);
      await removeUserMyLike(userModel.id);
      saveBothToMatched(userModel);
      // go to matched user screen & remove the myLike  from the other users & remove like Me from the and create a chat view instead
    } else {
      final updateOperation = checkLikedAlready(userModel.id)
          ? FieldValue.arrayRemove([userModel.id])
          : FieldValue.arrayUnion([userModel.id]);
      await db
          .collection(kUSER)
          .doc(auth.currentUser!.uid)
          .update({"myLikes": updateOperation});
      await ctr.getMyProfile();
      setMyLikes();
    }
    EasyLoading.dismiss();
  }

  removeUserMyLike(id) async {
    await db.collection(kUSER).doc(id).update({
      "myLikes": FieldValue.arrayRemove([auth.currentUser!.uid])
    });
  }

  removeFromLikeMe(id) async {
    await db.collection(kUSER).doc(auth.currentUser!.uid).update({
      "likeMe": FieldValue.arrayRemove([id])
    });
  }

  saveBothToMatched(UserModel userModel) async {
    final currentUserId = auth.currentUser!.uid;
    await Future.wait([
      db.collection(kUSER).doc(currentUserId).update({
        "matchedUsers": FieldValue.arrayUnion([userModel.id])
      }),
      db.collection(kUSER).doc(userModel.id).update({
        "matchedUsers": FieldValue.arrayUnion([currentUserId])
      }),
    ]);
    await chatCtr.saveToChat(userModel.id);
    Get.to(() => Matched(userModel: userModel));
  }

  Future<void> toggleSave(String id) async {
    EasyLoading.show();

    final updateOperation = checkSavedAlready(id)
        ? FieldValue.arrayRemove([id])
        : FieldValue.arrayUnion([id]);

    await db
        .collection(kUSER)
        .doc(auth.currentUser!.uid)
        .update({"mySaves": updateOperation});

    await ctr.getMyProfile();
    setSaved();
    EasyLoading.dismiss();
  }

  @override
  void onInit() {
    setMyLikes();
    super.onInit();
  }
}
