import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/core/text_field_password.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/router.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isChecked = false;
  bool showPassword = true;
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
                        color: bgColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ' Create Account',
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
                            prefixIcon: const Icon(Iconsax.user),
                          ),
                          const Divider(color: Colors.transparent),
                          CustomTextField(
                            controller: TextEditingController(),
                            hintText: 'Email Address',
                            prefixIcon: const Icon(Icons.mail_outline),
                          ),
                          const Divider(color: Colors.transparent),
                          CustomTextFieldPassword(
                            controller: TextEditingController(),
                            hintText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                            ),
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
                                        style:
                                            textStyle14.copyWith(color: black),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'terms of use',
                                            style: textStyle14.copyWith(
                                                color: primary),
                                          ),
                                          Text(
                                            ' and',
                                            style: textStyle14.copyWith(
                                                color: black),
                                          ),
                                          Text(
                                            ' privacy policy',
                                            style: textStyle14.copyWith(
                                                color: primary),
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
                                      fontWeight: FontWeight.w700,
                                      color: primary),
                                ),
                              ),
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
