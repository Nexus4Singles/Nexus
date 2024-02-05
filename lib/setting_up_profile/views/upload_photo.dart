import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  double currentpage = 60;
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
                currentpage = 60;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Upload Your Photos',
                style: textStyle8.copyWith(
                    fontSize: 30, fontWeight: FontWeight.w700, color: black),
              ),
              const SizedBoxH10(),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'Add at least 2 photos of yourself. We highly recommend \nuploading your best pictures because first impressions \nreally matter. Indecent pictures will be deleted. ',
                      textAlign: TextAlign.center,
                      style: textStyle12,
                    ),
                  ],
                ),
              ),
              const SizedBoxH20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 50),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: primary,
                        )
                      ],
                    ),
                  ),
                  const SizedBoxW15(),
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 50),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: primary,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBoxH15(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 50),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: primary,
                        )
                      ],
                    ),
                  ),
                  const SizedBoxW15(),
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 50),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: primary,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBoxH40(),
              CustomButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.audioRecording);
                },
                child: Text(
                  'Next',
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
