import 'package:Nexus/features/home/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:Nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:provider/provider.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/chat/chat_manager.dart';
import '../../firebase_options.dart';
import '../colors.dart';
import '../utils/app_logger.dart';

class FCMService {
  static String? fcmToken;
  static String? apnsToken;

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'NEXUS', // id
    'NEXUS', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );
  static final Map<String, List<int>> notificationIdsMap = {};
  static String? conversationId;

  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await initPushNotifications();
    await initLocalNotifications();
  }

  static Future<void> initPushNotifications() async {
    // await flutterLocalNotificationsPlugin.cancelAll();

    await FirebaseMessaging.instance
        .requestPermission(
          sound: true,
          badge: true,
          alert: true,
          announcement: true,
        )
        .then((NotificationSettings settings) {})
        .catchError((error) {});

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // // Retrieve and handle APNS token here
    // apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    // appLog('APNS Token: $apnsToken');

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageClick);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      //await flutterLocalNotificationsPlugin.cancelAll();

      final notification = message.notification;
      if (notification != null) {
        appLog('message received', notification.body.toString());
        //handleMessage(message);
        String? senderId;
        if (message.data.containsKey('senderId')) {
          senderId = message.data['senderId'] ?? '';
        }
        if (message.data.containsKey('conversationId')) {
          conversationId = message.data['conversationId'] ?? '';
        }
        //logger.i(conversationId);

        //logger.i(senderId);
        //logger.i(ChatManager.activeChatUserId);
        int notificationId = notification.hashCode;

        // Check if the user is actively chatting with the sender
        if (ChatManager.activeChatUserId != senderId) {
          // If not, show the notification
          showNotification(
            title: notification.title ?? '',
            message: notification.body ?? '',
            id: notificationId,
          );
          saveNotification(message);
          savePushNotification(message);
        }
      }
    });

    // if (GetPlatform.isAndroid) {
    fcmToken = await FirebaseMessaging.instance.getToken();
    // NOTE: APNS Token is used for topic messaging..
    // } else {
    //   fcmToken = await FirebaseMessaging.instance.getAPNSToken();
    //   // fcmToken = await FirebaseMessaging.instance.getToken();
    // }

    Get.context?.read<AuthNotifier>().updateProfile(
      map: {
        'fcm_token': fcmToken,
      },
      onCompleted: () {
        appLog("Completed FCM");
        appLog(fcmToken);
      },
      load: false,
    );
  }

  static void handleMessage(RemoteMessage? message) {
    if (message != null) {
      appLog('message-->', message.data);
      // FcmMessageHandler().handle(message.data);
      // savePushNotification(message);
    }
  }

  static void handleMessageClick(RemoteMessage? message) {
    if (message != null) {
      appLog('message-->', message.data);
      // FcmMessageHandler().handleClick(message.data);
    }
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    try {
      await Firebase.initializeApp();
      initPushNotifications();
      await savePushNotification(message);
    } catch (e) {
      logger.e(e);
    }
  }

  static Future<void> initLocalNotifications() async {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestCriticalPermission: true,
          requestBadgePermission: true,
        ),
      ),
    );

    final androidPlatform =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlatform?.createNotificationChannel(channel);
  }

  static Future<void> showNotification({
    required String title,
    required String message,
    required int id,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      message,
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            icon: '@drawable/ic_stat_ic_launcher_nbg',
            color: primary),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }

  static void saveNotification(RemoteMessage message) {
    // try {
    //   List notifications = StorageService.getList(key: "notifications") ?? [];
    //   notifications.add({
    //     'title': message.notification?.title,
    //     'date': DateTime.now().toIso8601String(),
    //   });

    //   StorageService.storeList(key: "notifications", value: notifications);

    //   appLog('Notification saved====>',
    //       StorageService.getList(key: "notifications"));
    // } catch (e) {
    //   appLog("Error saving notification: $e");
    // }
  }

  static Map<String, List<int>> notificationMap =
      {}; // Stores notification IDs by conversation ID

  static Future<void> savePushNotification(RemoteMessage message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? conversationId = message.data['conversationId'];
    int notificationId = message.notification.hashCode;

    if (conversationId != null) {
      List<String> ids = prefs.getStringList(conversationId) ?? [];
      ids.add(notificationId.toString());
      await prefs.setStringList(conversationId, ids);
    }
  }

  static Future<void> clearNotificationsForConversation(
      String conversationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? ids = prefs.getStringList(conversationId);

    if (ids != null) {
      for (var id in ids) {
        int notificationId;
        try {
          notificationId = int.parse(id);
        } catch (e) {
          logger.e('Error parsing notification ID: $id');
          continue;
        }

        //logger.i('Attempting to cancel notification with ID: $notificationId');
        try {
          await flutterLocalNotificationsPlugin.cancel(notificationId);
        } catch (e) {
          logger.e('Error canceling notification: $e');
        }
      }

      // Optionally, remove the list from SharedPreferences after clearing notifications
      await prefs.remove(conversationId);
    } else {
      logger.i('No notifications found for conversationId: $conversationId');
    }
  }

  static Future<void> clearRedundantNotifs() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> setFcmTokenToNull(String userId) async {
    try {
      // Reference to the user's document in Firestore
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Update the document by setting the fcm_token field to null
      await userDocRef.update({
        'fcm_token': null,
      });

      logger.i("FCM token set to null successfully for user: $userId");
    } catch (e) {
      logger.i("Error setting FCM token to null: $e");
    }
  }
}
