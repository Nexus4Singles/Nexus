
// import 'dio';
// import 'package:get/get.dart';
// import 'package:nexus/core/services/api_service.dart';

// class NotificationsService {
//   // Notification endpoints
//   Future<void> likeNotification(
//     String recipientId, {
//     required Function(Response<dynamic>? data) onSuccess,
//     required Function(Response<dynamic>? error) onError,
//   }) async {
//     const path = "/notify/like";
//     final data = {
//       'recipient_id': recipientId,
//     };
//     return ApiService().post(path, data: data, onSuccess: onSuccess, onError: onError);
//   }

//   Future<void> messageNotification(
//     String recipientId,
//     String senderId,
//     String messageContent,
//     String messageType, {
//     required Function(Response<dynamic>? data) onSuccess,
//     required Function(Response<dynamic>? error) onError,
//   }) async {
//     const path = "/notify/message";
//     final data = {
//       'recipient_id': recipientId,
//       'sender_id': senderId,
//       'message_content': messageContent,
//       'message_type': messageType,
//     };
//     return post(path, data: data, onSuccess: onSuccess, onError: onError);
//   }

//   Future<void> matchNotification(
//     String recipientId, {
//     required Function(Response<dynamic>? data) onSuccess,
//     required Function(Response<dynamic>? error) onError,
//   }) async {
//     const path = "/notify/match";
//     final data = {
//       'recipient_id': recipientId,
//     };
//     return post(path, data: data, onSuccess: onSuccess, onError: onError);
//   }
// }
// }