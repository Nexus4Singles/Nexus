import 'package:flutter/material.dart';
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
  double currentpage = 70;
  // ignore: unused_local_variable
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Slider(
          value: currentpage,
          onChanged: (double) {
            setState(
              () {
                currentpage = 70;
              },
            );
          },
          divisions: 12,
          max: 120,
          thumbColor: primary,
          activeColor: primary,
          inactiveColor: grey,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      'Please record short responses to the following questions\n below. Each response has a limit of 60 seconds. Kindly \nnote that you will not be able to change these recordings \nafter you have completed your profile. Your responses \ndont need to be perfect, they just need to be authentic. ',
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
              const Column(
                children: [
                  Text(
                      '1. How would you describe your relationship with God \Nand what has been the highlight of your relationship \Nwith Him?  (Private or Sensitive details can be omitted)'),
                  SizedBoxH20(),
                  Text(
                      '2. What are your thoughts concerning Gender roles in marriage? '),
                  SizedBoxH20(),
                  Text(
                      '3. How important is the financial stability of anyone romantically interested in you? ')
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
      ),
    );
  }
}
