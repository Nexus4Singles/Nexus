import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/router.dart';

class ChangePlanScreen extends StatefulWidget {
  const ChangePlanScreen({super.key});

  @override
  State<ChangePlanScreen> createState() => _ChangePlanScreenState();
}

class _ChangePlanScreenState extends State<ChangePlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Subsciption',
          style: textStyle18.copyWith(
              fontSize: 24.sp, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 300.sp,
                height: 170.sp,
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      'Basic',
                      style: textStyle18.copyWith(
                          color: white,
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Your plan will automatically renew, when you \nexhaust your chat access',
                      style: textStyle18.copyWith(
                          color: white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBoxH10(),
                    CustomButton(
                      onPressed: () {},
                      text: 'Cancel plan',
                      textColor: black,
                      bgColor: white,
                      size: height(context),
                    ),
                  ],
                ),
              ),
            ),
            SizedBoxH40(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment method',
                  style: textStyle10.copyWith(
                      fontWeight: FontWeight.w600, color: ash),
                ),
                Text(
                  'Change',
                  style: textStyle10.copyWith(
                      fontWeight: FontWeight.w600, color: ash),
                ),
              ],
            ),
            SizedBoxH20(),
            Text(
              '**** **** *** **** 4325',
              style: textStyle16.copyWith(
                  fontWeight: FontWeight.w600, color: black),
            ),
            SizedBoxH40(),
            CustomButton(
              onPressed: () {
                Get.toNamed(AppRoutes.subscription3);
              },
              text: 'Sign in',
            ),
          ],
        ),
      ),
    );
  }
}
