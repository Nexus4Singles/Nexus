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

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String selectedGender = '';

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
          title: SizedBox(
            width: width(context) * .5,
            child: LinearProgressIndicator(
              value: 0.1,
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
                    'What’s Your Gender?',
                    style: textStyle8.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: black),
                  ),
                  const SizedBoxH20(),
                  genderCard('Male'),
                  const SizedBoxH10(),
                  genderCard('Female'),
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
                  if (selectedGender == '') {
                    AppToast().showErrorToast('Please select your gender');
                  } else {
                    model.updateProfile(
                        map: {
                          kGENDER: selectedGender,
                          kREGPROGRESS: 'gender',
                        },
                        onCompleted: () {
                          Get.toNamed(AppRoutes.age);
                        });
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

  Widget genderCard(String name) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedGender = name;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedGender == name ? primary : const Color(0xffd6d6d6),
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
