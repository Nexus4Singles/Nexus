import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexus/core/models/user.dart';

class ChatModel {
  String lastMessage;
  String messageID;
  List<String> participant;
  Timestamp timestamp;
  int unreadCount;
  String userSentLastMessage;
  UserModel? userModel;

  ChatModel(
      {required this.lastMessage,
      required this.messageID,
      required this.participant,
      required this.timestamp,
      required this.unreadCount,
      required this.userModel,
      required this.userSentLastMessage});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        lastMessage: json["lastMessage"] ?? "",
        messageID: json["messageID"] ?? "",
        participant: json['participant'] == null
            ? []
            : (json['participant'] as List<dynamic>?)!
                .map((e) => e as String)
                .toList(),
        timestamp: json['timestamp'] ?? Timestamp.now(),
        unreadCount: json['unreadCount'] ?? 0,
        userSentLastMessage: json['userSentLastMessage'] ?? "",
        userModel: json['userModel'] == null
            ? null
            : UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
      );
}
