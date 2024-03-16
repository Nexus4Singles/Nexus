import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:nexus/router.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Slider(
          value: 0.6,
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
                DottedBorder(
                  borderType: BorderType.RRect,
                  strokeWidth: 1,
                  stackFit: StackFit.passthrough,
                  // customPath: (size) => customPath,
                  dashPattern: [6, 3, 0, 3],
                  color: Colors.blue.withOpacity(.2),
                  radius: Radius.circular(20.r),
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Color(0xffeeeeee),
                    ),
                    child: Icon(
                      Icons.add_circle,
                      color: primary,
                    ),
                  ),
                ),
                const SizedBoxW15(),
              ],
            ),
            const SizedBoxH15(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBoxW15(),
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
    );
  }

  Path customPath = Path()
    ..moveTo(20, 20)
    ..lineTo(50, 100)
    ..lineTo(20, 200)
    ..lineTo(100, 100)
    ..lineTo(20, 20);
}
