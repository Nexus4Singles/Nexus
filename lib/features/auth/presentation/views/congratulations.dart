import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/router.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({super.key});

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/congratulation.png'),
                          Text(
                            ' Congratulations ',
                            style: GoogleFonts.nunito(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w700,
                              color: black,
                            ),
                          ),
                          Text(
                            'You have successfully created an account on nexus!\nif you have not verified youe account, please do so\nlater. only verified profiles will be visible on search\nresults.',
                            textAlign: TextAlign.center,
                            style: textStyle12.copyWith(
                                fontWeight: FontWeight.w300, color: black),
                          ),
                          const SizedBoxH20(),
                          Text(
                            'You are now ready to setup your profile which will be\nvisible to opposite gender users',
                            textAlign: TextAlign.center,
                            style: textStyle12.copyWith(
                                fontWeight: FontWeight.w300, color: black),
                          ),
                          const SizedBoxH25(),
                          CustomButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.profile);
                            },
                            text: 'Set Up Profile',
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
