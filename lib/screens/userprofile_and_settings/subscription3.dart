import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/button_outline.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

class CancelSubScreen extends StatefulWidget {
  const CancelSubScreen({super.key});

  @override
  State<CancelSubScreen> createState() => _CancelSubScreenState();
}

class _CancelSubScreenState extends State<CancelSubScreen> {
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Are you sure you want to cancel?',
                style: textStyle16.copyWith(
                    fontWeight: FontWeight.w600, color: ash),
              ),
              SizedBoxH20(),
              CustomButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.subscription3);
                },
                text: 'Keep Subscription',
              ),
              SizedBoxH10(),
              CustomButtonOut(
                onPressed: () {
                  Get.toNamed(AppRoutes.subscription4);
                },
                text: 'Cancel',
                bgColor: primary,
                textColor: primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
