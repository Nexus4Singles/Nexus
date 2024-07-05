import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/core/utils/toast.dart';
import 'package:nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:nexus/router.dart';
import 'package:provider/provider.dart';
import 'package:wheel_slider/wheel_slider.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int val = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  FutureOr _init() {
    Provider.of<AuthNotifier>(context, listen: false).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: SizedBox(
            width: width(context) * .5,
            child: LinearProgressIndicator(
              value: 0.2,
              backgroundColor: newGrey,
              color: primary,
              borderRadius: BorderRadius.circular(20),
            ),
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
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: black),
                  ),
                  Text(
                    'Nexus is for users between the ages of 21 to 70 years',
                    style: textStyle14,
                  ),
                  const SizedBoxH20(),
                  SizedBox(
                    height: height(context) * .4,
                    width: width(context),
                    child: WheelSlider.customWidget(
                      horizontal: false,
                      verticalListHeight: 70.0,
                      perspective: 0.01,
                      totalCount: 70,
                      isInfinite: false,
                      initValue: val,
                      itemSize: 80,
                      pointerColor: const Color(0xffCEA050),
                      pointerWidth: 0,
                      pointerHeight: 0,
                      customPointer: Container(
                        width: 60.w,
                        height: 55.h,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: primary,
                              width: 2,
                            ),
                            top: BorderSide(
                              color: primary,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      onValueChanged: (p0) {
                        setState(() {
                          val = p0;
                        });
                      },
                      hapticFeedbackType: HapticFeedbackType.heavyImpact,
                      children: List.generate(
                        70,
                        (index) => Center(
                          child: Text(
                            (index + 1).toString(),
                            style: headerStyle.copyWith(
                              color: val == index ? primary : otherGrey,
                              fontSize: val == index ? 40 : 30,
                              fontWeight: val == index
                                  ? FontWeight.w900
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                onPressed: () {
                  if ((val + 1) < 21) {
                    AppToast().showErrorToast('Age must be 21 to 70 years');
                  } else {
                    model.updateProfile(
                      map: {
                        kAGE: val + 1,
                        kREGPROGRESS: 'age',
                      },
                      onCompleted: () {
                        Get.toNamed(AppRoutes.extraInfo);
                      },
                    );
                    //
                  }
                },
                child: Text(
                  'Next',
                  style: textStyle16.copyWith(color: white),
                ),
              ),
              const SizedBoxH30(),
            ],
          ),
        ),
      );
    });
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
