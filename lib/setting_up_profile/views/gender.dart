import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  var rating = 1;
  double currentpage = 1;
  // ignore: unused_field, prefer_final_fields
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Slider(
          value: currentpage,
          // ignore: avoid_types_as_parameter_names
          onChanged: (double) {
            setState(
              () {
                currentpage = 1;
              },
            );
          },
          max: 12,
          min: 0.5,
          thumbColor: primary,
          activeColor: primary,
          inactiveColor: grey,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Text(
              'What’s Your Gender?',
              style: textStyle8.copyWith(
                  fontSize: 30, fontWeight: FontWeight.w700, color: black),
            ),
            const SizedBoxH20(),
            Container(
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/male.svg'),
                  const SizedBoxW10(),
                  Text(
                    'Male',
                    style: textStyle16.copyWith(
                        fontWeight: FontWeight.w700, color: black),
                  ),
                ],
              ),
            ),
            const SizedBoxH10(),
            Container(
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/female.svg'),
                  const SizedBoxW10(),
                  Text(
                    'Female',
                    style: textStyle16.copyWith(
                        fontWeight: FontWeight.w700, color: black),
                  ),
                ],
              ),
            ),
            const SizedBoxH40(),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.extraInfo);
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
