import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/utils/app_logger.dart';
import 'package:nexus/features/explore/controllers/explore_ctr.dart';
import 'package:nexus/features/home/controllers/notification_controller.dart';
import 'package:nexus/features/match/presentation/views/matched.dart';
import '../../../core/constant.dart';
import '../../chat/controllers/chat_ctr.dart';

class MatchesCtr extends GetxController {
  static MatchesCtr get instance => Get.find<MatchesCtr>();

  var isLoading = false.obs;
  var ctr = ExploreCtr.instance;
  var chatCtr = Get.put(ChatCtr());
  var emptyText = "".obs;
  var userData = <UserModel>[].obs;
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var unrecommendId = "".obs;

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

  checkSavedAlready(String id) {
    return ctr.myProfile.value.mySaves?.contains(id);
  }

  var notificationController = NotificationController.instance;

  saveCountOfLikeMe(String userID) async {
    var likeDoc = db.collection(kUSER).doc(userID);
    await db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(likeDoc);
      if (snapshot.exists) {
        var data = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
        transaction.update(likeDoc,
            {'countLike': data.countLike != null ? data.countLike! + 1 : 1});
      }
    });
  }

  Future<void> toggleLike(UserModel userModel) async {
    EasyLoading.show();
    await ctr.getMyProfile();
    // this is for users that was liked by someone already
    if (ctr.myProfile.value.likeMe != null &&
        ctr.myProfile.value.likeMe!.contains(userModel.id)) {
      print("I was called here first");
      await removeFromLikeMe(userModel.id, false);
      await removeUserMyLike(userModel.id, false);
      await saveBothToMatched(userModel);
      EasyLoading.dismiss();

      notificationController.sendMatchNotification(userModel.id);
      // go to matched user screen & remove the myLike  from the other users & remove like Me from the and create a chat view instead
    } else {
      if (ctr.myProfile.value.myLikes != null &&
          ctr.myProfile.value.myLikes!.contains(userModel.id)) {
        print("I was called here second");
        await removeUserMyLike(userModel.id, true);
        await removeFromLikeMe(userModel.id, true);

        EasyLoading.dismiss();
      } else {
        print("I was called here third");
        addUserToMyLike(userModel.id);
        saveCountOfLikeMe(userModel.id);
        addUserToLikeMe(userModel.id);

        EasyLoading.dismiss(); // this is to remove slow downs...
        notificationController.sendLikeNotification(userModel.id);
        appLog(userModel.toJson());
      }
      await ctr.getMyProfile();
      setMyLikes();
    }
  }

  removeUserMyLike(id, bool isUser) async {
    await db.collection(kUSER).doc(isUser ? auth.currentUser!.uid : id).update({
      "myLikes": FieldValue.arrayRemove([isUser ? id : auth.currentUser!.uid])
    });
  }

  addUserToMyLike(id) async {
    await db.collection(kUSER).doc(auth.currentUser!.uid).update({
      "myLikes": FieldValue.arrayUnion([id])
    });
  }

  removeFromLikeMe(id, bool isUser) async {
    await db.collection(kUSER).doc(isUser ? id : auth.currentUser!.uid).update({
      "likeMe": FieldValue.arrayRemove([isUser ? auth.currentUser!.uid : id])
    });
  }

  addUserToLikeMe(id) async {
    await db.collection(kUSER).doc(id).update({
      "likeMe": FieldValue.arrayUnion([auth.currentUser!.uid])
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
    await db.collection('matches').add({
      'timestamp': FieldValue.serverTimestamp(),
      'matchedUsers': [currentUserId, userModel.id]
    });
    var messageID = DateTime.now().millisecondsSinceEpoch;
    await chatCtr.saveToChat(userModel.id, messageID);
    Get.to(() => Matched(userModel: userModel, messageID: messageID));
  }

  Future<void> toggleSave(String id) async {
    EasyLoading.show();

    final updateOperation = checkSavedAlready(id) ?? false
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

  addToUnRecommend(String id) async {
    unrecommendId.value = id;
    try {
      EasyLoading.show();
      await db.collection(kUSER).doc(auth.currentUser!.uid).update({
        "unRecommendUsers": FieldValue.arrayUnion([id])
      });
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  undoUnRecommend(bool shouldSwipe, CardSwiperController ctr) async {
    print("Called");
    if (unrecommendId.value.isNotEmpty) {
      try {
        EasyLoading.show();
        await db.collection(kUSER).doc(auth.currentUser!.uid).update({
          "unRecommendUsers": FieldValue.arrayRemove([unrecommendId.value])
        });
        shouldSwipe ? ctr.undo() : () {};
        EasyLoading.dismiss();
      } catch (e) {
        EasyLoading.dismiss();
      }
    } else {
      ctr.undo();
    }
  }

  @override
  void onInit() {
    setMyLikes();
    super.onInit();
  }
}
