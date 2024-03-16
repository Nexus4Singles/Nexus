import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

class RegSuccessful extends StatefulWidget {
  const RegSuccessful({super.key});

  @override
  State<RegSuccessful> createState() => _RegSuccessfulState();
}

class _RegSuccessfulState extends State<RegSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/congratulation.png',
            ),
            const SizedBoxH20(),
            Text(
              'Congratulations Ayo',
              style: textStyle18.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: black,
              ),
            ),
            const SizedBoxH20(),
            Text(
              ' You have successfully created a profile on Nexus! \nWe are launching soon and you will be able to search and view profiles. \n\n\nIn the mean time, please go to your profile to fill a short questionnaire.',
              style: textStyle18.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w300, color: black),
              textAlign: TextAlign.center,
            ),
            const SizedBoxH40(),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.mainNav);
                },
                text: 'Go to your Profile',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
