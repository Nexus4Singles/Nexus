import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

class Audio1Screen extends StatefulWidget {
  const Audio1Screen({super.key});

  @override
  State<Audio1Screen> createState() => _Audio1ScreenState();
}

class _Audio1ScreenState extends State<Audio1Screen> {
  double currentpage = 80;
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
                    currentpage = 80;
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
                Get.toNamed(AppRoutes.audio2);
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              padding: const EdgeInsets.symmetric(
                vertical: 100,
              ),
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
                          '1',
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
                      'How would you describe your relationship with God and \nwhat has been the highlight of your relationship with Him?',
                      style: textStyle12.copyWith(
                          fontWeight: FontWeight.w700, height: 2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBoxH30(),
                  Text(
                    '00:00',
                    style: textStyle18.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w200,
                        color: friendGrey),
                  ),
                  const SizedBoxH30(),
                  SvgPicture.asset('assets/icons/audio1.svg'),
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
                      child: SvgPicture.asset('assets/icons/mic.svg'),
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
