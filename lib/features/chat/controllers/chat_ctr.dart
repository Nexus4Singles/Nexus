import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/models/message_model.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/features/chat/widget/image_selected_container.dart';
import 'package:nexus/features/chat/widget/video_selected_container.dart';
import 'package:nexus/features/explore/controllers/explore_ctr.dart';
import 'package:nexus/features/home/controllers/notification_controller.dart';
import '../../../core/models/chats_model.dart';
import '../../../core/utils/methods.dart';

class ChatCtr extends GetxController {
  static ChatCtr get instance => Get.find<ChatCtr>();
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var notificationController = NotificationController.instance;
  var exploreCtr = ExploreCtr.instance;
  var allChatUsers = <ChatModel>[].obs;
  var chatController = TextEditingController();
  var picker = ImagePicker().obs;
  var imageFile = File('').obs;
  var mediaType = "".obs;
  var mediaFile = "".obs;

  Stream<QuerySnapshot> getAllMyChats() {
    return db
        .collection(kCHAT)
        .where(kPARTICIPANT, arrayContains: auth.currentUser!.uid)
        .snapshots();
  }

  List<ChatModel> filterChatList(dynamic data) {
    var allChatUsers = <ChatModel>[];
    var chats = data
        .map((data) => ChatModel.fromJson(data.data() as Map<String, dynamic>))
        .toList();
    for (var chat in chats) {
      for (var val in exploreCtr.allUsers) {
        if (chat.participant.contains(val.id)) {
          allChatUsers.add(ChatModel(
              lastMessage: chat.lastMessage,
              messageID: chat.messageID,
              participant: chat.participant,
              timestamp: chat.timestamp,
              unreadCount: chat.unreadCount,
              userModel: val,
              userSentLastMessage: chat.userSentLastMessage));
        }
      }
    }
    allChatUsers.sort((a, b) {
      if (a.timestamp.toDate().isAtSameMomentAs(DateTime.now()) &&
          !b.timestamp.toDate().isAtSameMomentAs(DateTime.now())) {
        return -1;
      } else if (!a.timestamp.toDate().isAtSameMomentAs(DateTime.now()) &&
          b.timestamp.toDate().isAtSameMomentAs(DateTime.now())) {
        return 1;
      }
      return b.timestamp.toDate().compareTo(a.timestamp.toDate());
    });
    return allChatUsers
        .where((val) => val.userModel!.id != auth.currentUser!.uid)
        .toList();
  }

  setUserToHaveShowWarning(id) async {
    db.collection(kUSER).doc(auth.currentUser!.uid).update({
      "usersChatWarning": FieldValue.arrayUnion([id])
    }).then((val) async {
      await exploreCtr.getMyProfile();
    });
  }

  saveToChat(String id, messageID) {
    db.collection(kCHAT).doc("$messageID").set({
      "lastMessage": "",
      'messageID': "$messageID",
      'participant': FieldValue.arrayUnion([id, auth.currentUser!.uid]),
      'userSentLastMessage': "",
      'timestamp': DateTime.now(),
      'unreadCount': 0
    });
  }

  Stream<QuerySnapshot> getMyConversations(String messageID) {
    return db
        .collection("conversations")
        .doc(messageID)
        .collection("messages")
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future sendMessage(
      String messageID, String messages, UserModel recipient) async {
    var message = MessageModel(
        media: imageFile.value.path.isNotEmpty ? imageFile.value.path : "",
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: messages,
        messageType: mediaType.value.isEmpty ? 'text' : mediaType.value,
        sentBy: auth.currentUser!.uid,
        recipientId: recipient.id,
        timestamp: Timestamp.now());
    if (messages.isNotEmpty || imageFile.value.path.isNotEmpty) {
      db
          .collection(kCONVERSATION)
          .doc(messageID)
          .collection(kMESSAGES)
          .doc(message.id)
          .set(message.toJson());

      updateLastMessage(messageID, messages);
      // auth.currentUser!.uid

      notificationController.sendMessageNotification(recipient.id, messages,
          mediaType.value.isEmpty ? 'text' : mediaType.value);
    }
    if (imageFile.value.path.isNotEmpty) {
      mediaFile.value = await uploadFile(file: imageFile.value);
      db.runTransaction((transactions) async {
        DocumentReference messageRef = db
            .collection(kCONVERSATION)
            .doc(messageID)
            .collection(kMESSAGES)
            .doc(message.id);
        transactions.update(messageRef,
            {"media": mediaFile.value, "message_type": mediaType.value});
        imageFile.value = File('');
        mediaFile.value = "";
        mediaType.value = "";
      });
    } else {}
    chatController.clear();
  }

  deleteAMessage(conversationID, messageID) {
    db
        .collection(kCONVERSATION)
        .doc(conversationID)
        .collection(kMESSAGES)
        .doc(messageID)
        .delete();
  }

  updateLastMessage(String messageID, String message) async {
    var chatDoc = db.collection(kCHAT).doc(messageID);
    await db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(chatDoc);
      if (snapshot.exists) {
        var data = ChatModel.fromJson(snapshot.data() as Map<String, dynamic>);
        transaction.update(chatDoc, {
          "lastMessage": mediaType.value.isNotEmpty ? mediaType.value : message,
          "userSentLastMessage": auth.currentUser!.uid,
          'timestamp': Timestamp.now(),
          'unreadCount': data.userSentLastMessage == auth.currentUser!.uid
              ? data.unreadCount + 1
              : 1
        });
      }
    });
  }

  void pickImage(ChatModel model) async {
    final XFile? image =
        await picker.value.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile.value = File(image.path);
      mediaType.value = "image";
      Get.back();
      Get.bottomSheet(
          SizedBox(
              height: Get.height / 1.5,
              child: ImageSelectedContainer(
                imageFile: imageFile.value,
                chatModel: model,
              )),
          isDismissible: false,
          enableDrag: false,
          isScrollControlled: true);
    }
  }

  void pickVideo(ChatModel model) async {
    final XFile? image = await picker.value.pickVideo(
        source: ImageSource.gallery, maxDuration: const Duration(seconds: 30));
    if (image != null) {
      imageFile.value = File(image.path);
      mediaType.value = "Video";
      Get.back();
      Get.bottomSheet(
          VideoWidget(
            chatModel: model,
            videoUrl: imageFile.value,
          ),
          isDismissible: false,
          enableDrag: true,
          isScrollControlled: true);
    }
  }

  Future<String> uploadFile({required File file}) async {
    try {
      var url = await upload(file);
      mediaFile.value = url;
      return url;
    } catch (e) {
      debugPrint("This is the url error  $e");
      return '';
    }
  }

  @override
  void onInit() {
    getAllMyChats();
    super.onInit();
  }
}
