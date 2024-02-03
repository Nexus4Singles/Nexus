import 'package:flutter/material.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
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
          'Notification',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: textStyle10.copyWith(
                  color: black, fontWeight: FontWeight.w600),
            ),
            SizedBoxH10(),
            NotifyContainer(
                image: 'assets/images/amina.png',
                text1: 'Aminat sent you a message',
                text2: '9:01am'),
            Divider(
              color: white,
            ),
            NotifyContainer(
                image: 'assets/images/amina.png',
                text1: 'Someone liked your profile!',
                text2: '8:48am'),
            Divider(
              color: white,
            ),
            NotifyContainer(
                image: 'assets/images/amina.png',
                text1: 'You got a new match! 😍😍😍',
                text2: '8:45am'),
            Divider(
              color: white,
            ),
            Text(
              'Yesterday',
              style: textStyle10.copyWith(
                  color: black, fontWeight: FontWeight.w600),
            ),
            SizedBoxH10(),
            NotifyContainer(
                image: 'assets/images/nexus.png',
                text1:
                    'We would be updating the app and \nthere might be downtime later today...',
                text2: '9:01am'),
            Divider(
              color: white,
            ),
            NotifyContainer(
                image: 'assets/images/nexus.png',
                text1: 'We are launching a new feature \ntomorrow. Stay Tuned!',
                text2: '9:01am'),
            Divider(
              color: white,
            ),
            NotifyContainer(
                image: 'assets/images/amina.png',
                text1: 'Seyi sent you a message',
                text2: '9:01am'),
            Divider(
              color: white,
            ),
            Text(
              'This week',
              style: textStyle10.copyWith(
                  color: black, fontWeight: FontWeight.w600),
            ),
            SizedBoxH10(),
            NotifyContainer(
                image: 'assets/images/amina.png',
                text1: 'Chioma sent you a message',
                text2: '9:01am'),
            Divider(
              color: white,
            ),
            NotifyContainer(
                image: 'assets/images/amina.png',
                text1: 'Seyi sent you a message',
                text2: '9:01am'),
            Divider(
              color: white,
            ),
            NotifyContainer(
                image: 'assets/images/amina.png',
                text1: 'Aminat sent you a message',
                text2: '9:01am'),
          ],
        ),
      ),
    );
  }
}
