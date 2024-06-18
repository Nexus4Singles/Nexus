import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  String message;
  String messageType;
  String sentBy;
  Timestamp timestamp;

  MessageModel(
      {required this.id,
      required this.message,
      required this.messageType,
      required this.sentBy,
      required this.timestamp});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"] ?? "",
        message: json["message"] ?? "",
        timestamp: json['timestamp'] ?? Timestamp.now(),
        messageType: json['messageType'] ?? '',
        sentBy: json['sentBy'] ?? "",
      );
}
