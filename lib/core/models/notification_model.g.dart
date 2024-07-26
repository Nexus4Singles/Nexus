// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      userId: json['user_id'] as String,
      id: json['id'] as String,
      recipientId: json['recipient_id'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      message: json['message'] as String?,
      messageType:
          $enumDecodeNullable(_$MessageTypeEnumMap, json['message_type']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      read: json['read'] as bool?,
      avater: json['avater'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'recipient_id': instance.recipientId,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'message': instance.message,
      'message_type': _$MessageTypeEnumMap[instance.messageType],
      'createdAt': instance.createdAt?.toIso8601String(),
      'read': instance.read,
      'avater': instance.avater,
      'id': instance.id,
      'title': instance.title,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.like: 'like',
  NotificationType.chat: 'chat',
  NotificationType.match: 'match',
  NotificationType.update: 'update',
};

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.voice: 'voice',
  MessageType.image: 'image',
};
