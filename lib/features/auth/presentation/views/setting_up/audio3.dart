import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

class Audio3Screen extends StatefulWidget {
  const Audio3Screen({super.key});

  @override
  State<Audio3Screen> createState() => _Audio3ScreenState();
}

class _Audio3ScreenState extends State<Audio3Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Slider(
          value: 0.7,
          onChanged: (val) {},
          activeColor: primary,
          inactiveColor: grey,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.audio4);
            },
            child: Text(
              'Next',
              style: textStyle14.copyWith(
                  fontWeight: FontWeight.w700, color: black),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          children: [
            Center(
              child: Text(
                'Audio Recordings',
                style: textStyle8.copyWith(
                    fontSize: 30, fontWeight: FontWeight.w700, color: black),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: primary,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '3',
                          style: textStyle18.copyWith(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  const SizedBoxH15(),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'What are the best qualities or traits about you?',
                      style: textStyle12.copyWith(
                          fontWeight: FontWeight.w700, height: 2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBoxH30(),
                  Text(
                    '1:00',
                    style: textStyle18.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w200,
                        color: friendGrey),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: warGrey,
                    child: SvgPicture.asset('assets/icons/refresh.svg'),
                  ),
                  const SizedBoxW40(),
                  const Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: warGrey,
                      child: CircleAvatar(
                        backgroundColor: primary,
                        radius: 30,
                        child: Icon(
                          Iconsax.microphone,
                          color: white,
                        ),
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
