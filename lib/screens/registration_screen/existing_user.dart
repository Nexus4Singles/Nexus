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

class ExistingUserScreen extends StatefulWidget {
  const ExistingUserScreen({super.key});

  @override
  State<ExistingUserScreen> createState() => _ExistingUserScreenState();
}

class _ExistingUserScreenState extends State<ExistingUserScreen> {
  bool isChecked = true;
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
                          horizontal: 10, vertical: 10),
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
                            'Our goal is to provide you with the visibility you need\nto potentially connect with your life partner.',
                            textAlign: TextAlign.center,
                            style: textStyle12.copyWith(
                              color: black,
                            ),
                          ),
                          SizedBoxH20(),
                          CustomTextField(
                            controller: TextEditingController(),
                            prefixIcon: Image.asset('assets/images/email.png'),
                            hintText: 'Email Address / Username',
                          ),
                          const SizedBoxH20(),
                          CustomTextField(
                            controller: TextEditingController(),
                            hintText: 'Password',
                            prefixIcon: Image.asset('assets/images/lock2.png'),
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
                                  Text(
                                    'Remember me',
                                    style: textStyle14.copyWith(color: black),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.forgottenPassword);
                                    },
                                    child: Text(
                                      'Forgotten password?',
                                      style: textStyle14,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBoxH25(),
                          CustomButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.existingUser);
                            },
                            text: 'Sign in',
                          ),
                          const SizedBoxH20(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don’t have an account?',
                                style: textStyle14.copyWith(color: black),
                              ),
                              const SizedBoxW15(),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.createAccount);
                                },
                                child: Text(
                                  'Sign up',
                                  style: textStyle14,
                                ),
                              )
                            ],
                          )
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
