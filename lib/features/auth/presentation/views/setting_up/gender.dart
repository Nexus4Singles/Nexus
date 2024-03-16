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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Slider(
          value: 0,
          onChanged: (val) {},
          activeColor: primary,
          inactiveColor: grey,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'What’s Your Gender?',
                  style: textStyle8.copyWith(
                      fontSize: 30, fontWeight: FontWeight.w700, color: black),
                ),
                const SizedBoxH20(),
                genderCard('Male'),
                const SizedBoxH10(),
                genderCard('Female'),
              ],
            ),
            Column(
              children: [
                CustomButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.age);
                  },
                  child: Text(
                    'Next',
                    style: textStyle16.copyWith(color: white),
                  ),
                ),
                const SizedBoxH20(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String selectedGender = '';

  Widget genderCard(String name) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedGender = name;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedGender == name ? primary : grey,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            SvgPicture.asset(
              name == 'Male'
                  ? 'assets/icons/male.svg'
                  : 'assets/icons/female.svg',
              color: selectedGender == name ? white : black,
            ),
            const SizedBoxW10(),
            Text(
              name,
              style: textStyle16.copyWith(
                  fontWeight: FontWeight.w700,
                  color: selectedGender == name ? white : black),
            ),
          ],
        ),
      ),
    );
  }
}
