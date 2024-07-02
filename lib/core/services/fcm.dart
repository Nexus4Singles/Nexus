import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:provider/provider.dart';
// import 'package:godaesil/app/services/storage_service.dart';

import '../../firebase_options.dart';
import '../utils/app_logger.dart';
// import '../utils/fcm_message_handler.dart';

class FCMService {
  static String? fcmToken;
  static String? apnsToken;

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await initPushNotifications();
    await initLocalNotifications();
  }

  static Future<void> initPushNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();

    await FirebaseMessaging.instance
        .requestPermission(
      sound: true,
      badge: true,
      alert: true,
      announcement: true,
    )
        .then((NotificationSettings settings) {
      print('User granted permission: ${settings.authorizationStatus}');
    }).catchError((error) {
      print('Error requesting permission: $error');
    });

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
      await flutterLocalNotificationsPlugin.cancelAll();

      final notification = message.notification;
      if (notification != null) {
        appLog('message received', notification.body.toString());
        handleMessage(message);
        showNotification(
          title: notification.title ?? '',
          message: notification.body ?? '',
          id: notification.hashCode,
        );
        saveNotification(message);
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
    }
  }

  static void handleMessageClick(RemoteMessage? message) {
    if (message != null) {
      appLog('message-->', message.data);
      // FcmMessageHandler().handleClick(message.data);
    }
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    saveNotification(message);
    // handleMessage(message);
    // Handle background messages here if needed
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
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
        ),
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
}
