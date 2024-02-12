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

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            // decoration: ,

            child: Image.asset(
              'assets/images/firelove.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: height(context),
            ),
          ),
          Container(
            // height: height(context) * .7,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Create Account',
                  style: GoogleFonts.nunito(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                ),
                Text(
                  'Welcome to Nexus! Lets create an account\nfor you',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sora(
                    color: black,
                    textStyle: textStyle12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBoxH15(),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: 'Username ',
                  prefixIcon: Image.asset('assets/images/frame.png'),
                ),
                const Divider(color: Colors.transparent),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: 'Email Address / Username',
                  prefixIcon: Image.asset('assets/images/email.png'),
                ),
                const Divider(color: Colors.transparent),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: 'Password',
                  prefixIcon: Image.asset(
                    'assets/images/lock2.png',
                  ),
                ),
                const SizedBoxH10(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: null,
                          side: const BorderSide(color: black),
                        ),
                        Column(
                          children: [
                            Text(
                              'By checking this box, I agree to the',
                              style: textStyle14.copyWith(color: black),
                            ),
                            Row(
                              children: [
                                Text(
                                  'terms of use',
                                  style: textStyle14.copyWith(color: primary),
                                ),
                                Text(
                                  ' and',
                                  style: textStyle14.copyWith(color: black),
                                ),
                                Text(
                                  ' privacy policy',
                                  style: textStyle14.copyWith(color: primary),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBoxH25(),
                CustomButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.verifyAccount);
                  },
                  text: 'Sign up',
                ),
                const SizedBoxH20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: textStyle14.copyWith(
                          color: ash, fontWeight: FontWeight.w700),
                    ),
                    const SizedBoxW15(),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.login);
                      },
                      child: Text(
                        'Sign in',
                        style: textStyle14.copyWith(
                            fontWeight: FontWeight.w700, color: primary),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
