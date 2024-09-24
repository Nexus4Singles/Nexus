import 'package:Nexus/core/services/fcm.dart';
import 'package:Nexus/features/home/controllers/home_controller.dart';
import 'package:Nexus/features/subscription/provider/subscription_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../core/button.dart';
import '../../../../core/button_outline.dart';
import '../../../../core/size_boxes.dart';
import '../../../../core/style.dart';
import '../../../../core/utils/shared_pref.dart';
import '../../../../router.dart';

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
                    child: Consumer<SubscriptionProvider>(
                      builder: (context, provider, _) =>
                          CustomButton(
                            onPressed: () async {
                              await FCMService.setFcmTokenToNull(
                                  HomeController.instance.user.value.id);
                              SharedPref.deleteAll();
                              //provider.isLoggingOut = true;
                              Get.offAllNamed('/');
                            },
                            text: 'Yes, Logout',
                          ),
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
