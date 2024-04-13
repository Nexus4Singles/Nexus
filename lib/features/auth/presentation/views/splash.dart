import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/utils/shared_pref.dart';
import 'package:nexus/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        nextScreen();
      },
    );
    super.initState();
  }

  void nextScreen() async {
    bool firstTime = await SharedPref.getBool(kFirstTime) ?? true;
    if (!firstTime) {
      Get.offAndToNamed(AppRoutes.onboardingHandler);
      // }
    } else {
      Get.offAndToNamed(AppRoutes.login);
    }
  }

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
              'The Visibility App for Christian Singles',
              style: GoogleFonts.novaSquare(
                fontSize: 16.sp,
                color: white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
