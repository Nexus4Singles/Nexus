import 'dart:async';
import 'package:Nexus/features/home/presentation/change_notifier/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/assets.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:Nexus/features/auth/presentation/widgets/social_media.dart';
import 'package:Nexus/router.dart';
import 'package:provider/provider.dart';

class RegSuccessful extends StatefulWidget {
  const RegSuccessful({super.key});

  @override
  State<RegSuccessful> createState() => _RegSuccessfulState();
}

class _RegSuccessfulState extends State<RegSuccessful> {
  @override
  void initState() {
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
              SvgPicture.asset('$svgPath/congrats.svg'),
              const SizedBoxH20(),
              model.user?.username == null
                  ? const SizedBox(
                      width: 40 * 4,
                      height: 10,
                      child: LinearProgressIndicator(
                        color: primary,
                        backgroundColor: secondaryGrey2,
                      ),
                    )
                  : Text(
                      'Congratulations ${model.user?.username}',
                      style: textStyle18.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: black,
                      ),
                    ),
              const SizedBoxH20(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text.rich(
                  TextSpan(children: [
                    const TextSpan(
                        text:
                            "You have successfully created a profile on Nexus! We are launching soon and you will be able to search and view profiles. Kindly tell your Christian single friends about Nexus & follow us on social media "),
                    TextSpan(
                        text: " @nexus4singles",
                        style: textStyle18.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w700, color: black)),
                    const TextSpan(text: " to stay updated!"),
                  ]),
                  style: textStyle18.copyWith(
                      fontSize: 12, height: 1.5, fontWeight: FontWeight.w300, color: black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBoxH20(),
              const SocialMediaWidget(),
              const SizedBoxH40(),
              const SizedBoxH20(),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  onPressed: () async {
                    Provider.of<BottomNavModel>(context, listen: false).setInitialPage(4);

                    Get.offAndToNamed(AppRoutes.mainNav, arguments: true);

                    // Future.delayed(Durations.medium1, () {
                    // });
                    // await Provider.of<HomeNotifier>(context, listen: false)
                    //     .getProfile()
                    //     .then((value) {
                    //   Get.offAndToNamed(AppRoutes.mainNav,
                    //       arguments: {'fromSignUp': true});
                    // });
                  },
                  text: 'Go to Your Profile',
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
