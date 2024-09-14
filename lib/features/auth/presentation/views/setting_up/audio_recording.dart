import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/device.dart';
import 'package:Nexus/router.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecordingScreen extends StatefulWidget {
  const AudioRecordingScreen({super.key});

  @override
  State<AudioRecordingScreen> createState() => _AudioRecordingScreenState();
}

class _AudioRecordingScreenState extends State<AudioRecordingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: SizedBox(
          width: width(context) * .5,
          child: LinearProgressIndicator(
            value: 0.65,
            backgroundColor: newGrey,
            color: primary,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 15.sp,
        ),
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
            const SizedBoxH20(),
            Text(
              'Instructions',
              style: textStyle16.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBoxH5(),
            Column(
              children: [
                Text.rich(
                  TextSpan(
                    style: textStyle12.copyWith(color: black.withOpacity(.8)),
                    children: const [
                      TextSpan(
                        text:
                            'Please record genuine responses to the questions you see on the subsequent screens. These three (3) questions are centered around your ',
                      ),
                      TextSpan(
                        text:
                            'christian faith, marriage beliefs & personality. ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            '''\n\nEach response has a limit of 60 seconds and you will not be able to change your responses after your profile is completed. \nYour responses don´t need to be perfect, they just need to be audible & authentic. \n\nRemember that people value authenticity and most people can tell when a response feels rehearsed or scripted, so we recommend reflecting deeply on each question & responding from your heart, to avoid wondering why you’re not getting matches, despite saying impressive things in your responses. \n 
It is also obvious that any user who records gibberish or submits empty recordings will not be taken seriously by other users, and such profiles will be deleted. \n\n Once again, you have just one chance to make these recordings, make it count and please avoid background noises, so that users can hear you clearly.\n
Happy Recording!''',
                      ),
                    ],
                  ),
                  style: textStyle14,
                ),
              ],
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              onPressed: () async {
                await Permission.microphone.request();

                await Permission.microphone.status.then((value) {
                  print(value);
                  if (value.isGranted) {
                    Get.toNamed(AppRoutes.audio1);
                  } else {}
                });
              },
              child: Text(
                'Begin Recording',
                style: textStyle16.copyWith(color: white),
              ),
            ),
            const SizedBoxH30()
          ],
        ),
      ),
    );
  }

  Path customPath = Path()
    ..moveTo(20, 20)
    ..lineTo(50, 100)
    ..lineTo(20, 200)
    ..lineTo(100, 100)
    ..lineTo(20, 20);
}
