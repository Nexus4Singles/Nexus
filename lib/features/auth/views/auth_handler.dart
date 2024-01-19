import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/button_outline.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/utils/shared_pref.dart';
import 'package:nexus/router.dart';
import 'package:nexus/screens/registration_screen/existing_user.dart';

class AuthHandler extends StatefulWidget {
  const AuthHandler({super.key});

  @override
  State<AuthHandler> createState() => _AuthHandlerState();
}

class _AuthHandlerState extends State<AuthHandler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBoxH40(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'nexus'.toUpperCase(),
                    style: GoogleFonts.novaSquare(
                      fontSize: 35.sp,
                      color: white,
                    ),
                  ),
                ),
                const SizedBoxH15(),
                Image.asset(iLogo),
                const SizedBoxH15(),
                Text(
                  'Connecting African Christian Singles',
                  style: GoogleFonts.novaSquare(
                    fontSize: 16.sp,
                    color: white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CustomButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.createAccount);
                  },
                  text: 'Create Account',
                  textColor: primary,
                  bgColor: white,
                ),
                const SizedBoxH15(),
                CustomButtonOut(
                  onPressed: () {
                    Get.toNamed(AppRoutes.existingUser);
                  },
                  text: 'Sign In',
                  textColor: white,
                  bgColor: white,
                  // bgColor: white,
                ),
                const SizedBoxH15(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
