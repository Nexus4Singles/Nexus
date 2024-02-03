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

class ReviewSummaryScreen extends StatefulWidget {
  const ReviewSummaryScreen({super.key});

  @override
  State<ReviewSummaryScreen> createState() => _ReviewSummaryScreenState();
}

class _ReviewSummaryScreenState extends State<ReviewSummaryScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Review Summary',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 140.sp,
                  decoration: BoxDecoration(
                      color: grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        '\$4',
                        style: textStyle18.copyWith(
                            color: black,
                            fontSize: 35,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'You’ve selected the Basic plan',
                        style: textStyle18.copyWith(
                            color: black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBoxH10(),
                      CustomButton(
                          onPressed: () {},
                          text: 'Select another plan',
                          size: height(context))
                    ],
                  ),
                ),
              ),
              SizedBoxH20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount',
                    style: textStyle18.copyWith(color: ash),
                  ),
                  Text(
                    '\$4',
                    style: textStyle18.copyWith(
                        color: black, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBoxH10(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Taxes & Fees',
                    style: textStyle18.copyWith(color: ash),
                  ),
                  Text(
                    '\$1.09',
                    style: textStyle18.copyWith(
                        color: black, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBoxH10(),
              Container(
                decoration: BoxDecoration(
                  color: white.withOpacity(0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Taxes & Fees',
                      style: textStyle18.copyWith(color: ash),
                    ),
                    Text(
                      '\$1.09',
                      style: textStyle18.copyWith(
                          color: black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBoxH30(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: white.withOpacity(0.9),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/smallcard.png'),
                        SizedBoxW10(),
                        Text(
                          'Taxes & Fees',
                          style: textStyle18.copyWith(color: ash),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$1.09',
                    style: textStyle18.copyWith(
                        color: black, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBoxH20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: null,
                    side: const BorderSide(color: black),
                  ),
                  Text(
                    'Auto-Renew Plan',
                    style: textStyle14.copyWith(color: ash),
                  )
                ],
              ),
              const SizedBoxH40(),
              CustomButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.paymentSuccess);
                },
                text: 'Confirm Payment',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
