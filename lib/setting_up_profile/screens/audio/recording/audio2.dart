import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

class Audio2Screen extends StatefulWidget {
  const Audio2Screen({super.key});

  @override
  State<Audio2Screen> createState() => _Audio2ScreenState();
}

class _Audio2ScreenState extends State<Audio2Screen> {
  double currentpage = 90;
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
                    currentpage = 90;
                  },
                );
              },
              divisions: 12,
              max: 120,
              thumbColor: primary,
              activeColor: primary,
              inactiveColor: grey,
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.audio3);
              },
              child: Text(
                'Next',
                style: textStyle14.copyWith(
                    fontWeight: FontWeight.w700, color: black),
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(),
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
              padding: EdgeInsets.symmetric(vertical: 100),
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
                          '2',
                          style: textStyle18.copyWith(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'What are your thoughts concerning Gender roles in\n marriage?',
                      style: textStyle12.copyWith(fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBoxH30(),
                  Text(
                    '00:15',
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
                  SizedBoxW40(),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: warGrey,
                      radius: 40,
                      child: SvgPicture.asset('assets/icons/playing.svg'),
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
