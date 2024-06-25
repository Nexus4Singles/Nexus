import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/button_outline.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

import '../../../../core/utils/shared_pref.dart';

class LoginModalSheet extends StatefulWidget {
  const LoginModalSheet({super.key});

  @override
  State<LoginModalSheet> createState() => _LoginModalSheetState();
}

class _LoginModalSheetState extends State<LoginModalSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Logout',
                style: headerStyle.copyWith(
                  fontSize: 20,
                ),
              ),
              const SizedBoxH25(),
              Text(
                'Are you sure you want to logout?',
                style: textStyle14,
              ),
            ],
          ),
          const SizedBoxH40(),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomButtonOut(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Cancel',
                    ),
                  ),
                  const SizedBoxW15(),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Get.offAndToNamed(AppRoutes.login);
                        SharedPref.deleteAll();
                      },
                      text: 'Yes, Logout',
                    ),
                  ),
                ],
              ),
              const SizedBoxH30(),
            ],
          ),
        ],
      ),
    );
  }
}
