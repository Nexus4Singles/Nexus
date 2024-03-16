import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/auth/data/data-sources/local-datasource/hobbies.dart';
import 'package:nexus/features/auth/presentation/widgets/hobbie_card.dart';
import 'package:nexus/router.dart';

class DesiredQualityScreen extends StatefulWidget {
  const DesiredQualityScreen({super.key});

  @override
  State<DesiredQualityScreen> createState() => _DesiredQualityScreenState();
}

class _DesiredQualityScreenState extends State<DesiredQualityScreen> {
  List<String> selectedDesires = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Slider(
          value: 0.5,
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
              '    Desired Qualities',
              style: textStyle8.copyWith(
                  fontSize: 30, fontWeight: FontWeight.w700, color: black),
            ),
            const SizedBoxH10(),
            const Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select 5 Qualities you value the most in the choice of \na life partner,  asides from Godliness  ',
                  ),
                ],
              ),
            ),
            const SizedBoxH20(),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: List.generate(
                HobbiesLocalData().desireQualities.length,
                (index) => HobbieCard(
                  text: HobbiesLocalData().desireQualities[index],
                  isChecked: selectedDesires.contains(
                    HobbiesLocalData().desireQualities[index],
                  ),
                  onPress: () {
                    if (selectedDesires
                        .contains(HobbiesLocalData().desireQualities[index])) {
                      setState(() {
                        selectedDesires
                            .remove(HobbiesLocalData().desireQualities[index]);
                      });
                    } else {
                      setState(() {
                        selectedDesires.add(
                          HobbiesLocalData().desireQualities[index],
                        );
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBoxH20(),
            CustomButton(
              onPressed: () {
                Get.toNamed(AppRoutes.uploadPhoto);
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
}
