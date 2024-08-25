import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/utils/shared_pref.dart';
import 'package:nexus/router.dart';

import '../../../explore/controllers/explore_ctr.dart';

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
    var email = await SharedPref.getString("email");
    var auth = FirebaseAuth.instance.currentUser?.uid;
    if (firstTime || auth == null) {
      Get.offAndToNamed(AppRoutes.onboardingHandler);
    } else if (email.isNotEmpty) {
      // ctr.allUsers.isNotEmpty : () {}?
      Get.offAndToNamed(AppRoutes.mainNav);
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
            Image.asset('$svgPath/nexus-logo1.gif'),
          ],
        ),
      ),
    );
  }
}
