import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/router.dart';

class ForgottenPasswordScreen extends StatefulWidget {
  const ForgottenPasswordScreen({super.key});

  @override
  State<ForgottenPasswordScreen> createState() =>
      _ForgottenPasswordScreenState();
}

class _ForgottenPasswordScreenState extends State<ForgottenPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height(context),
              width: width(context),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/firelove.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ' Welcome Back ',
                            style: GoogleFonts.nunito(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w700,
                              color: black,
                            ),
                          ),
                          Text(
                            'Your new password must be different from\npreviously used passwords',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sora(
                                color: black,
                                textStyle: textStyle12,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBoxH30(),
                          CustomTextField(
                              controller: TextEditingController(),
                              hintText: 'Password'),
                          const SizedBoxH20(),
                          CustomTextField(
                              controller: TextEditingController(),
                              hintText: 'Confirm Password'),
                          const SizedBoxH25(),
                          CustomButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.existingUser);
                            },
                            text: 'Sign in',
                          ),
                          const SizedBoxH20(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
