import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field_password.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/router.dart';

class ForgottenPasswordScreen extends StatefulWidget {
  const ForgottenPasswordScreen({super.key});

  @override
  State<ForgottenPasswordScreen> createState() =>
      _ForgottenPasswordScreenState();
}

class _ForgottenPasswordScreenState extends State<ForgottenPasswordScreen> {
  bool showPassword = true;
  bool showCPassword = true;
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
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
                          CustomTextFieldPassword(
                            controller: TextEditingController(),
                            hintText: 'Password',
                            obsecure: showPassword,
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              child: Icon(showPassword
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye),
                            ),
                          ),
                          const SizedBoxH20(),
                          CustomTextFieldPassword(
                            controller: TextEditingController(),
                            hintText: 'Confirm Password',
                            obsecure: showCPassword,
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  showCPassword = !showCPassword;
                                });
                              },
                              child: Icon(showCPassword
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye),
                            ),
                          ),
                          const SizedBoxH25(),
                          CustomButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.login);
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
