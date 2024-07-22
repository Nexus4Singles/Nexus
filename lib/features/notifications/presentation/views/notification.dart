import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/models/notification_model.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/progress_indicator.dart';
import 'package:nexus/features/home/controllers/home_controller.dart';
import 'package:nexus/features/home/controllers/notification_controller.dart';
import 'package:nexus/features/notifications/presentation/widgets/notify_container.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  void initState() {
    super.initState();

    notificationController.getAllNotifications();
  }

  String get username => HomeController.instance.user.value.username;

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
      body: Obx(() {
        if (notificationController.isLoading.value) {
          return const Center(child: CustomCircularProgressIndicator());
        }
        if (notificationController.groupedNotifications.isEmpty) {
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
        } else {
          Map<String, List<NotificationModel>> groupedNotifications =
              notificationController.groupedNotifications;

          return ListView.builder(
            itemCount: groupedNotifications.keys.length,
            itemBuilder: (context, index) {
              String date = groupedNotifications.keys.elementAt(index);
              List<NotificationModel> dailyNotifications =
                  groupedNotifications[date]!;
              String displayDate = notificationController.getDisplayDate(date);

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBoxH20(),
                    Text(
                      displayDate,
                      style: textStyle10.copyWith(
                          color: black, fontWeight: FontWeight.w600),
                    ),
                    const SizedBoxH10(),
                    ...dailyNotifications.map((notification) {
                      return Column(
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
                      );
                    }).toList(),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}

// assets/images/nexus.png