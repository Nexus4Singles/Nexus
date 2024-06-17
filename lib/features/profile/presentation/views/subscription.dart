import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

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
          'Subscription Plans',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The free version of Nexus provides unlimited access to most features. However, some features have been made premium. We incur some monthly costs to ensure your profiles and audio recordings are securely stored and accessible to users. Hence, we are charging a small subscription fee to access premium features. This is to ensure we are able to maintain our services to you. ',
              style: textStyle12.copyWith(
                fontSize: 11.sp,
                color: black,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xffEAEAEA)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.all(16.sp),
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Free',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Unlimited Access to Search & View Profiles',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Unlimited Access to Like Profiles',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Unlimited Access to View Profiles You Liked',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Unlimited Access to View Who Liked Your Profile',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Unlimited Access to View Compatibility Data',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Limited Access to Chat with Matched Users (1 User)',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp, //#575757
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xffEAEAEA)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.all(16.sp),
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '\$5',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '/month',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xffA7A9B7),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '- Unlimited Messaging',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Save Profiles to View Later',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Backtrack if you mistakenly swiped left',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Access to Advanced Filters on Explore Page',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.paymentSuccess);
                      },
                      child: const Text(
                        'Select Plan',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xffEAEAEA)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.all(16.sp),
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '\$12',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '/3 months',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xffA7A9B7),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '- Unlimited Messaging',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Save Profiles to View Later',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Backtrack if you mistakenly swiped left',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- Access to Advanced Filters on Explore Page',
                      style: textStyle12.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff575757),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onPressed: () {},
                      child: const Text(
                        'Select Plan',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
