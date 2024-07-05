import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/core/utils/shared_pref.dart';
import 'package:nexus/router.dart';

class OnboardingHandler extends StatelessWidget {
  const OnboardingHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        padding: EdgeInsets.all(15.sp),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              iWelcomeBg,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visibility, Connection, Love',
                  style: headerStyle.copyWith(
                    fontSize: 24.sp,
                    color: white,
                  ),
                  textAlign: TextAlign.center,
                ),
                // const SizedBoxH5(),
                Text(
                  'Marriage is God’s idea and we are committed to seeing more Godly marriages exist. Matthew 19:4-6',
                  textAlign: TextAlign.center,
                  style: textStyle12.copyWith(
                    color: white,
                    fontSize: 13.sp,
                  ),
                ),
                const SizedBoxH15(),
                CustomButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.onboarding);
                  },
                  text: 'How It Works',
                ),
                const SizedBoxH15(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
