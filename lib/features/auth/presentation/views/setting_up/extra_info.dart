import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/features/auth/presentation/widgets/drop_down.dart';
import 'package:nexus/router.dart';

class ExtraInformationScreen extends StatefulWidget {
  const ExtraInformationScreen({super.key});

  @override
  State<ExtraInformationScreen> createState() => _ExtraInformationScreenState();
}

class _ExtraInformationScreenState extends State<ExtraInformationScreen> {
  String state = '';
  String eduLevel = '';
  String profession = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Slider(
          value: 0.3,
          onChanged: (val) {},
          activeColor: primary,
          inactiveColor: grey,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 15.sp,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Extra Information',
              style: textStyle8.copyWith(
                  fontSize: 30, fontWeight: FontWeight.w700, color: black),
            ),
            const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nexus is currently available to only Nigerians living \nin Nigeria and in diaspora',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBoxH25(),
            CustomTextField(
              borderColor: white,
              controller: TextEditingController(),
              hintText: 'Select your City, Country of Residence',
              radius: 10.r,
            ),
            const SizedBoxH15(),
            ProfileDropDown(
              items: const [
                'Option1',
                'Option2',
                'Option3',
              ],
              val: state,
              hintText: 'State of Origin',
              onChanged: (p0) {
                setState(() {
                  state = p0!;
                });
              },
            ),
            const SizedBoxH10(),
            ProfileDropDown(
              items: const [
                'Option1',
                'Option2',
                'Option3',
              ],
              val: eduLevel,
              hintText: 'Education Level',
              onChanged: (p0) {
                setState(() {
                  eduLevel = p0!;
                });
              },
            ),
            const SizedBoxH10(),
            ProfileDropDown(
              items: const [
                'Option1',
                'Option2',
                'Option3',
              ],
              val: profession,
              hintText: 'Profession / Industry',
              onChanged: (p0) {
                setState(() {
                  profession = p0!;
                });
              },
            ),
            const SizedBoxH10(),
            CustomTextField(
              borderColor: white,
              controller: TextEditingController(),
              hintText: 'Church (Full name)',
              radius: 10.r,
            ),
            const SizedBoxH40(),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.hobbies);
                },
                child: Text(
                  'Next',
                  style: textStyle16.copyWith(color: white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
