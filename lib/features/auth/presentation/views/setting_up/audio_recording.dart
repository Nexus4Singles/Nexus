import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

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
        title: Slider(
          value: 0.7,
          onChanged: (val) {},
          activeColor: primary,
          inactiveColor: grey,
        ),
        elevation: 0,
      ),
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
            const SizedBoxH10(),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Please record short responses to the following questions below. Each response has a limit of 60 seconds. Kindly note that you will not be able to change these recordings after you have completed your profile. Your responses dont need to be perfect, they just need to be authentic.',
                    style: textStyle14,
                  ),
                ],
              ),
            ),
            const SizedBoxH20(),
            Text(
              'Questions',
              style: textStyle16.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBoxH20(),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. ',
                      style: textStyle12.copyWith(
                        color: black,
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'How would  you summarize your relationship with God  and what has been the highlight of your experience with Him? ',
                              style: textStyle12.copyWith(
                                color: black,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '(Private or Sensitive details can be omitted)',
                              style: textStyle12.copyWith(
                                color: black.withOpacity(.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBoxH20(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2. ',
                      style: textStyle12.copyWith(
                        color: black,
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'What are your thoughts on the role of a husband and a wife in marriage?',
                              style: textStyle12.copyWith(
                                color: black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBoxH20(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3. ',
                      style: textStyle12.copyWith(
                        color: black,
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'What are the best qualities or traits about you?',
                              style: textStyle12.copyWith(
                                color: black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBoxH40(),
            CustomButton(
              onPressed: () {
                Get.toNamed(AppRoutes.audio1);
              },
              child: Text(
                'Begin Recording',
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
