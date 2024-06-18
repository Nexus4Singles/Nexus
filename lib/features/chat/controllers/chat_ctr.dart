import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/features/explore/controllers/explore_ctr.dart';

import '../../../core/models/chats_model.dart';

class ChatCtr extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var exploreCtr = Get.put(ExploreCtr());
  var allChatUsers = <ChatModel>[].obs;

  setRecentMatches() {}

  sendAMessage() async {}

  getAllMyChats() async {
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
        .snapshots();
  }

  @override
  void onInit() {
    getAllMyChats();
    super.onInit();
  }
}
