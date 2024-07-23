import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:nexus/core/models/notification_model.dart';

import 'package:nexus/core/services/api_service.dart';

class NotificationsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<NotificationModel>> getAllNotifications(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('notifications')
          .where('recipient_id', isEqualTo: userId)
          // .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) =>
              NotificationModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList()
          .reversed
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Notification endpoints
  Future<void> likeNotification(
    String recipientId, {
    required Function(Response<dynamic>? data) onSuccess,
    required Function(Response<dynamic>? error) onError,
  }) async {
    const path = "/notifications/notify/like";
    final data = {
      'recipient_id': recipientId,
    };
    return ApiService().post(
      path,
      data: data,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  Future<void> messageNotification(
    String recipientId,
    // String senderId,
    String messageContent,
    String messageType, {
    required Function(Response<dynamic>? data) onSuccess,
    required Function(Response<dynamic>? error) onError,
  }) async {
    const path = "/notifications/notify/message";
    final data = {
      'recipient_id': recipientId,
      // 'sender_id': senderId,
      'message_content': messageContent,
      'message_type': messageType,
    };
    return ApiService()
        .post(path, data: data, onSuccess: onSuccess, onError: onError);
  }

  Future<void> matchNotification(
    String recipientId, {
    required Function(Response<dynamic>? data) onSuccess,
    required Function(Response<dynamic>? error) onError,
  }) async {
    const path = "/notifications/notify/match";
    final data = {
      'recipient_id': recipientId,
    };
    return ApiService()
        .post(path, data: data, onSuccess: onSuccess, onError: onError);
  }
}
