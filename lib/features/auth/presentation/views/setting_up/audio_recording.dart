import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/router.dart';
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
            value: 0.7,
            backgroundColor: newGrey,
            color: primary,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
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
            const SizedBoxH10(),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Please record short but genuine responses to the questions below. Each response has a limit of 60 seconds. Kindly note that you will not be able to change these recordings after you have completed your profile, so please ensure your voice is loud & clear enough. Your responses don´t need to be perfect, they just need to be audible & authentic.',
                    style: textStyle12.copyWith(color: black.withOpacity(.8)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBoxH30(),
            const SizedBoxH20(),
            Text(
              'Questions',
              style: textStyle16.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBoxH20(),
            DottedBorder(
              borderType: BorderType.RRect,
              strokeWidth: 1,
              stackFit: StackFit.passthrough,
              // customPath: (size) => customPath,
              dashPattern: const [6, 3, 0, 3],
              color: Colors.blue.withOpacity(.2),
              radius: Radius.circular(20.r),
              child: Container(
                padding: EdgeInsets.all(15.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: const Color(0xffeeeeee),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1. ',
                          style: textStyle12.copyWith(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'How would you describe your current relationship with God & why is this relationship important to you? ',
                                  style: textStyle14.copyWith(
                                    color: primary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '(Please answer both parts of this question)',
                                  style: textStyle14.copyWith(
                                    color: black.withOpacity(.4),
                                    fontSize: 13,
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
                          style: textStyle14.copyWith(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'What are your thoughts on the role of a husband and a wife in marriage?',
                                  style: textStyle14.copyWith(
                                    color: primary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
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
                          style: textStyle14.copyWith(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'What are the best qualities or traits about yourself?',
                                  style: textStyle14.copyWith(
                                    color: primary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
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
              ),
            ),
            const SizedBoxH40(),
            Text(
              'Remember that people can easily tell when a response is not authentic, so we encourage you to refrain from seeking external \nhelp to answer these questions. Please note that your profile will \nbe deleted, if your recordings are empty or you record gibberish \njust to bypass this process.',
              style: textStyle12.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: black.withOpacity(.8)),
              textAlign: TextAlign.center,
            ),
            const SizedBoxH40(),
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
