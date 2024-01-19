import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';

class SubsciptionScreen extends StatefulWidget {
  const SubsciptionScreen({super.key});

  @override
  State<SubsciptionScreen> createState() => _SubsciptionScreenState();
}

class _SubsciptionScreenState extends State<SubsciptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Subscription',
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
              'Choose Your Plan',
              style: textStyle14.copyWith(
                  fontWeight: FontWeight.w600, color: black),
            ),
            Text(
              'Our free version allows you to chat with\na maximum of one matched user, while\nyou appear randomly on search results\nwith our subscription plans below, you \nget access  to chat with other matched\nusers and much more.',
              style: textStyle12.copyWith(
                  fontSize: 11.sp, color: black, fontWeight: FontWeight.w300),
            ),
            Center(
              child: Container(
                width: 300,
                height: 110,
                decoration: BoxDecoration(
                  color: grey.withOpacity(0.9),
                  border: Border.all(color: primary),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Free',
                        style: textStyle18.copyWith(
                            fontSize: 35,
                            fontWeight: FontWeight.w800,
                            color: black),
                      ),
                      SizedBoxH10(),
                      Text(
                        'Your current plan',
                        style: textStyle18.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: black),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [primary, white],
                ),
              ),
              padding: EdgeInsets.symmetric(),
              child: Column(
                children: [Text('hdhdhdhdh')],
              ),
            )
          ],
        ),
      ),
    );
  }
}
