import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/device.dart';
import 'package:Nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:Nexus/router.dart';
import 'package:provider/provider.dart';

import '../../../../core/assets.dart';

class CongratulationScreen extends StatefulWidget {
  final String username;
  const CongratulationScreen({super.key, required this.username});

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  var username = "";

  init() async {
    username = (await const FlutterSecureStorage().read(key: "username"))!;
    setState(() {});
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        body: Column(
          children: [
            Container(
              height: height(context),
              width: width(context),
              color: white,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/firelove.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 60,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBoxH20(),
                          Column(
                            children: [
                              SvgPicture.asset('$svgPath/congrats.svg'),
                              const SizedBoxH20(),
                              Text(
                                'Hello ${username}',
                                overflow: TextOverflow.ellipsis,
                                style: headerStyle.copyWith(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  color: black,
                                ),
                              ),
                              const SizedBoxH20(),
                              Text(
                                "You have successfully created an account on Nexus! \nKindly click on the verification link sent to your email inbox/spam to activate your account. Please note that you won't be able to sign in until you have verified your account ",
                                textAlign: TextAlign.center,
                                style: textStyle14.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: black.withOpacity(0.7)),
                              ),
                              // const SizedBoxH20(),
                              // Text(
                              //   'We have sent you a verification link. Kindly click on the link to verify your account',
                              //   textAlign: TextAlign.center,
                              //   style: textStyle14.copyWith(
                              //       fontWeight: FontWeight.w400, color: black),
                              // ),
                              const SizedBoxH20(),
                              Text(
                                'Didn’t receive verification link?',
                                style: textStyle14.copyWith(
                                  color: ash,
                                ),
                              ),
                              const SizedBoxH10(),
                              InkWell(
                                onTap: () {
                                  model.resendVerificatioLink();
                                },
                                child: Text(
                                  'Resend Link',
                                  style: textStyle14.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primary,
                                  ),
                                ),
                              ),
                              const SizedBoxH25(),
                              CustomButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.login);
                                },
                                text: 'Sign In',
                              ),
                              // const SizedBoxH20(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
