import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

class RegSuccessful extends StatefulWidget {
  const RegSuccessful({super.key});

  @override
  State<RegSuccessful> createState() => _RegSuccessfulState();
}

class _RegSuccessfulState extends State<RegSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/congratulation.png'),
          Text(
            'Congratulations',
            style: textStyle18.copyWith(
                fontSize: 32, fontWeight: FontWeight.w700, color: black),
          ),
          Text(
            ' You have successfully created a profile on Nexus!\nWe are launching soon and you will be able to search \nand view profiles.\nIn the mean time, please tell your Christian single \nfriends to sign up right away.\nFollow us on social media to stay updated!',
            style: textStyle18.copyWith(
                fontSize: 12, fontWeight: FontWeight.w300, color: black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.profile);
                },
                text: 'Go to your Profile',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
