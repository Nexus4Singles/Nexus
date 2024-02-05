import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/router.dart';
import 'package:nexus/setting_up_profile/widgets/extra_container.dart';

class ExtraInformationScreen extends StatefulWidget {
  const ExtraInformationScreen({super.key});

  @override
  State<ExtraInformationScreen> createState() => _ExtraInformationScreenState();
}

class _ExtraInformationScreenState extends State<ExtraInformationScreen> {
  @override
  Widget build(BuildContext context) {
    double currentpage = 30;
    // ignore: unused_local_variable
    PageController pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: Slider(
          value: currentpage,
          // ignore: avoid_types_as_parameter_names
          onChanged: (double) {
            setState(
              () {
                currentpage = 30;
              },
            );
          },
          divisions: 12,
          max: 120,
          thumbColor: primary,
          activeColor: primary,
          inactiveColor: grey,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
            SizedBoxH25(),
            CustomTextField(
              borderColor: white,
              controller: TextEditingController(),
              hintText: 'Select your City, Country of Residence',
            ),
            const ExtraContainer(text: 'State of Origin', icon: true),
            const Divider(
              color: Colors.transparent,
            ),
            const ExtraContainer(text: 'Education Level', icon: true),
            const Divider(
              color: Colors.transparent,
            ),
            const ExtraContainer(text: 'Profession / Industry', icon: true),
            const Divider(
              color: Colors.transparent,
            ),
            CustomTextField(
              borderColor: white,
              controller: TextEditingController(),
              hintText: 'Church (Full name)',
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
