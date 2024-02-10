import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

class Audio4Screen extends StatefulWidget {
  const Audio4Screen({super.key});

  @override
  State<Audio4Screen> createState() => _Audio4ScreenState();
}

class _Audio4ScreenState extends State<Audio4Screen> {
  double currentpage = 120;
  // ignore: unused_local_variable
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Row(
          children: [
            Slider(
              value: currentpage,
              onChanged: (double) {
                setState(
                  () {
                    currentpage = 120;
                  },
                );
              },
              divisions: 12,
              max: 120,
              thumbColor: primary,
              activeColor: primary,
              inactiveColor: grey,
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Audio Recordings',
                style: textStyle8.copyWith(
                    fontSize: 30, fontWeight: FontWeight.w700, color: black),
              ),
            ),
            Text(
              'Your Responses',
              style: textStyle18,
            ),
            const SizedBoxH15(),
            Text(
              '1. How would you describe your relationship with God and what has been the highlight of your relationship with Him? ',
              style: textStyle14.copyWith(
                  color: black, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBoxH10(),
            Container(
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/play.svg'),
                  const SizedBoxW10(),
                  SvgPicture.asset('assets/icons/wave.svg'),
                ],
              ),
            ),
            const SizedBoxH25(),
            Text(
              '2. What are your thoughts concerning Gender roles in marriage?',
              style: textStyle14.copyWith(
                  color: black, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBoxH10(),
            Container(
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/play.svg'),
                  const SizedBoxW10(),
                  SvgPicture.asset('assets/icons/wave.svg'),
                ],
              ),
            ),
            const SizedBoxH25(),
            Text(
              '3. How important is the financial stability of anyone romantically interested in you?',
              style: textStyle14.copyWith(
                  color: black, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBoxH10(),
            Container(
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/play.svg'),
                  const SizedBoxW10(),
                  SvgPicture.asset('assets/icons/wave.svg'),
                ],
              ),
            ),
            const SizedBoxH30(),
            CustomButton(
              onPressed: () {
                Get.toNamed(AppRoutes.regSuccessful);
              },
              child: Text(
                'Complete Profile',
                style: textStyle16.copyWith(color: white),
              ),
            ),
            const SizedBoxH20()
          ],
        ),
      ),
    );
  }
}
