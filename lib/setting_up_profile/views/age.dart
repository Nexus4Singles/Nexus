import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/router.dart';
import 'package:wheel_slider/wheel_slider.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int val = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Slider(
          value: 10,
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
                  'What’s Your Age?',
                  style: textStyle8.copyWith(
                      fontSize: 30, fontWeight: FontWeight.w700, color: black),
                ),
                const SizedBoxH20(),
                SizedBox(
                  height: height(context) * .4,
                  width: width(context),
                  child: WheelSlider.customWidget(
                    horizontal: false,
                    verticalListHeight: 70.0,
                    perspective: 0.01,
                    totalCount: 10,
                    isInfinite: true,
                    initValue: 0,
                    itemSize: 80,
                    pointerColor: Color(0xffCEA050),
                    pointerWidth: 0,
                    pointerHeight: 0,
                    onValueChanged: (p0) {
                      setState(() {
                        val = p0;
                      });
                    },
                    hapticFeedbackType: HapticFeedbackType.heavyImpact,
                    children: List.generate(
                      10,
                      (index) => Center(
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            color: val == index
                                ? Colors.white
                                : Colors.grey.withOpacity(.3),
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CustomButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.extraInfo);
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
