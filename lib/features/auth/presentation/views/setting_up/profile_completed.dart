import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:nexus/features/auth/presentation/widgets/social_media.dart';
// import 'package:nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:nexus/router.dart';
import 'package:provider/provider.dart';

class RegSuccessful extends StatefulWidget {
  const RegSuccessful({super.key});

  @override
  State<RegSuccessful> createState() => _RegSuccessfulState();
}

class _RegSuccessfulState extends State<RegSuccessful> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  FutureOr _init() {
    Provider.of<AuthNotifier>(context, listen: false).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
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
                'Congratulations ${model.user!.username}',
                style: textStyle18.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
              const SizedBoxH20(),
              Text(
                ' You have successfully created a profile on Nexus! \n\nWe are launching soon and you will be able to search and view profiles. \n\nKindly tell your Christian single friends about Nexus & follow us on social media to stay updated!',
                style: textStyle18.copyWith(
                    fontSize: 12, fontWeight: FontWeight.w300, color: black),
                textAlign: TextAlign.center,
              ),
              const SizedBoxH20(),
              const SocialMediaWidget(),
              const SizedBoxH40(),
              const SizedBoxH20(),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  onPressed: () async {
                    Get.offAndToNamed(AppRoutes.mainNav);
                    // await Provider.of<HomeNotifier>(context, listen: false)
                    //     .getProfile()
                    //     .then((value) {
                    //   Get.offAndToNamed(AppRoutes.mainNav,
                    //       arguments: {'fromSignUp': true});
                    // });
                  },
                  text: 'Go to Home',
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
