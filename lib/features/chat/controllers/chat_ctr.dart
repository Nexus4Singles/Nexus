import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/models/message_model.dart';
import 'package:nexus/features/chat/widget/chat_image_selector.dart';
import 'package:nexus/features/explore/controllers/explore_ctr.dart';
import '../../../core/models/chats_model.dart';
import '../../auth/data/data-sources/remote-datasource/auth_remote.dart';

class ChatCtr extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var exploreCtr = Get.put(ExploreCtr());
  var allChatUsers = <ChatModel>[].obs;
  var chatController = TextEditingController();
  var picker = ImagePicker().obs;
  var imageFile = File('').obs;
  var mediaType = "".obs;
  var mediaFile = "".obs;
  AuthenticationRemoteDatasource? remote;

  getAllMyChats() async {
    allChatUsers.clear();
    var data = await db
        .collection(kCHAT)
        .where(kPARTICIPANT, arrayContains: auth.currentUser!.uid)
        .get();
    var chats =
        data.docs.map((data) => ChatModel.fromJson(data.data())).toList();
    for (var chats in chats) {
      for (var val in exploreCtr.allUsers) {
        if (chats.participant.contains(val.id)) {
          allChatUsers.add(ChatModel(
              lastMessage: chats.lastMessage,
              messageID: chats.messageID,
              participant: chats.participant,
              timestamp: chats.timestamp,
              unreadCount: chats.unreadCount,
              userModel: val,
              userSentLastMessage: chats.userSentLastMessage));
        }
      }
    }
    var filteredUsers = allChatUsers
        .where((val) => val.userModel!.id != auth.currentUser!.uid)
        .toList();
    allChatUsers.assignAll(filteredUsers);
    print("this is all chats .... ${allChatUsers.length}");
  }

  saveToChat(String id) {
    db.collection(kCHAT).doc("${DateTime.now().millisecondsSinceEpoch}").set({
      "lastMessage": "",
      'messageID': "${DateTime.now().millisecondsSinceEpoch}",
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

  sendMessage(String messageID, String messages) async {
    print("called..");
    imageFile.value.path.isNotEmpty ? uploadFile(file: imageFile.value) : () {};
    var message = MessageModel(
        media: mediaFile.value,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: messages,
        messageType: mediaType.value.isEmpty ? 'text' : mediaType.value,
        sentBy: auth.currentUser!.uid,
        timestamp: Timestamp.now());
    if (messages.isNotEmpty) {
      db
          .collection(kCONVERSATION)
          .doc(messageID)
          .collection(kMESSAGES)
          .doc(message.id)
          .set(message.toJson());
      updateLastMessage(messageID, messages);
    }
  }

  updateLastMessage(String messageID, String message) async {
    var chatDoc = db.collection(kCHAT).doc(messageID);
    await db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(chatDoc);
      if (snapshot.exists) {
        var data = ChatModel.fromJson(snapshot.data() as Map<String, dynamic>);

        transaction.update(chatDoc, {
          "lastMessage": message,
          "userSentLastMessage": auth.currentUser!.uid,
          'timestamp': Timestamp.now(),
          'unreadCount': data.userSentLastMessage == auth.currentUser!.uid
              ? data.unreadCount + 1
              : 1
        });
      }
    });
    getAllMyChats();
  }

  void pickImage() async {
    final XFile? image =
        await picker.value.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile.value = File(image.path);
      Get.to(
          () => ChatImageSelector(
                imagePath: imageFile.value,
              ),
          fullscreenDialog: true);
    }
  }

  Future<String> uploadFile({required File file}) async {
    try {
      var url = await remote!.upload(file);
      mediaFile.value = url;
      return url;
    } catch (e) {
      return '';
    }
  }

  @override
  void onInit() {
    getAllMyChats();
    super.onInit();
  }
}
