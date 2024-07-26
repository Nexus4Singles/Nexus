// lib/models/notification_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable {
  const NotificationModel({
    required this.userId,
    required this.id,
    required this.recipientId,
    required this.type,
    this.message,
    this.messageType,
    this.createdAt,
    this.read,
    this.avater,
    this.title,
  });
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'recipient_id')
  final String recipientId;
  final NotificationType type;
  final String? message;
  @JsonKey(name: 'message_type')
  final MessageType? messageType;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  final bool? read;
  final String? avater;
  final String id;
  final String? title;

  @override
  List<Object?> get props => [
        userId,
        recipientId,
        type,
        message,
        messageType,
        createdAt,
        read,
        avater,
        title,
        id,
      ];

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

enum NotificationType {
  like,
  chat,
  match,
  update,
}

enum MessageType {
  text,
  voice,
  image,
}
