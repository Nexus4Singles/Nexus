import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/models/notification_model.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/home/controllers/home_controller.dart';
import 'package:nexus/features/home/controllers/notification_controller.dart';
import 'package:nexus/features/notifications/presentation/widgets/notify_container.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key, required this.notificationController});
  final NotificationController notificationController;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController notificationController =
      Get.find<NotificationController>();
  var homeController = HomeController.instance;

  @override
  void initState() {
    super.initState();
    // notificationController.getAllNotifications();
  }

  String get username => HomeController.instance.user.value.username;

  Future<QuerySnapshot<Map<String, dynamic>>> loadData() {
    Logger().e(homeController.user.value.id);
    return FirebaseFirestore.instance
        .collection('notifications')
        .where('recipient_id', isEqualTo: 'rhrcJcwNAmX77Hdrs55yptqaWPk1')
        // .orderBy('createdAt', descending: true)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Notifications',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          // if (notificationController.groupedNotifications.isEmpty) {
          //   return Center(
          //     child: Column(
          //       children: [
          //         const Spacer(),
          //         const Spacer(),
          //         SvgPicture.asset("$svgPath/bell.svg"),
          //         const SizedBoxH15(),
          //         Text("You haven’t received any notifications yet.",
          //             textAlign: TextAlign.center, style: textStyle14),
          //         const Spacer(),
          //         const Spacer(),
          //         const Spacer(),
          //       ],
          //     ),
          //   );
          // }
          // else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            EasyLoading.show();
          }
          EasyLoading.dismiss();

          if (snapshot.data == null) {
            return Container();
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  const Spacer(),
                  SvgPicture.asset("$svgPath/bell.svg"),
                  const SizedBoxH15(),
                  Text("You haven’t received any notifications yet.",
                      textAlign: TextAlign.center, style: textStyle14),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              NotificationModel n =
                  NotificationModel.fromJson(snapshot.data!.docs[0].data());
              Logger().i(n);
               NotificationModel notification =
                          NotificationModel.fromJson(
                              snapshot.data!.docs[index].data());
                      Logger().d(notification.toJson());
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBoxH20(),
                    // Text(
                    //   'Notification',
                    //   style: textStyle10.copyWith(
                    //       color: black, fontWeight: FontWeight.w600),
                    // ),
                    const SizedBoxH10(),
                          Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // Get.to(() => const NotifyPermission());
                            },
                            child: NotifyContainer(
                              image: notification.avater ??
                                  'https://ui-avatars.com/api/?name=$username&rounded=true&size=128',
                              text1: notification.title ?? 'Notification',
                              text2: DateFormat('hh:mm a').format(
                                notification.createdAt ?? DateTime.now(),
                              ),
                            ),
                          ),
                          const Divider(color: white),
                        ],
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// assets/images/nexus.png
