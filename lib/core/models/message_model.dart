import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  String message;
  String media;
  String messageType;
  String sentBy;
  String recipientId; // New field for recipient
  Timestamp timestamp;

  MessageModel({
    required this.id,
    required this.message,
    required this.messageType,
    required this.media,
    required this.sentBy,
    required this.recipientId, // Include recipientId in the constructor
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json["id"] ?? "",
    media: json["media"] ?? "",
    message: json["message"] ?? "",
    timestamp: json['timestamp'] ?? Timestamp.now(),
    messageType: json['message_type'] ?? '',
    sentBy: json['sentBy'] ?? "",
    recipientId: json['recipientId'] ?? "", // Parse recipientId from JSON
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'media': media,
    'message': message,
    'message_type': messageType,
    'sentBy': sentBy,
    'recipientId': recipientId, // Add recipientId to JSON
    'timestamp': timestamp,
  };
}
