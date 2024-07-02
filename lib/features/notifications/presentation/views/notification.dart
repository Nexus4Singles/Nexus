import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/home/presentation/widgets/coming_soon.dart';
import 'package:nexus/features/notifications/presentation/views/notify_permission.dart';
import 'package:nexus/features/notifications/presentation/widgets/notify_container.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBoxH20(),
                Text(
                  'Today',
                  style: textStyle10.copyWith(
                      color: black, fontWeight: FontWeight.w600),
                ),
                const SizedBoxH10(),
                InkWell(
                  onTap: () {
                    Get.to(() => const NotifyPermission());
                  },
                  child: const NotifyContainer(
                      image: 'assets/images/amina.png',
                      text1: 'Aminat sent you a message',
                      text2: '9:01am'),
                ),
                const Divider(color: white),
                const NotifyContainer(
                    image: 'assets/images/amina.png',
                    text1: 'Someone liked your profile!',
                    text2: '8:48am'),
                const Divider(color: white),
                const NotifyContainer(
                    image: 'assets/images/amina.png',
                    text1: 'You got a new match! 😍😍😍',
                    text2: '8:45am'),
                const Divider(color: white),
                Text(
                  'Yesterday',
                  style: textStyle10.copyWith(
                      color: black, fontWeight: FontWeight.w600),
                ),
                const SizedBoxH10(),
                const NotifyContainer(
                    image: 'assets/images/nexus.png',
                    text1:
                        'We would be updating the app and \nthere might be downtime later today...',
                    text2: '9:01am'),
                const Divider(
                  color: white,
                ),
                const NotifyContainer(
                    image: 'assets/images/nexus.png',
                    text1:
                        'We are launching a new feature \ntomorrow. Stay Tuned!',
                    text2: '9:01am'),
                const Divider(
                  color: white,
                ),
                const NotifyContainer(
                    image: 'assets/images/amina.png',
                    text1: 'Seyi sent you a message',
                    text2: '9:01am'),
                const Divider(
                  color: white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
