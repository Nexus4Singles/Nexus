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

class HobbiesScreen extends StatefulWidget {
  const HobbiesScreen({super.key});

  @override
  State<HobbiesScreen> createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
  List<String> selectedHobbies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Slider(
          value: 0.4,
          onChanged: (val) {},
          activeColor: primary,
          inactiveColor: grey,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hobbies/Interests',
              style: textStyle8.copyWith(
                  fontSize: 30, fontWeight: FontWeight.w700, color: black),
            ),
            const SizedBoxH10(),
            Center(
              child: Text(
                'Select up to 5 interests/hobbies to let users know \nwhat you are passionate about. ',
                textAlign: TextAlign.center,
                style: textStyle14,
              ),
            ),
            const SizedBoxH20(),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: List.generate(
                HobbiesLocalData().hobbies.length,
                (index) => HobbieCard(
                  text: HobbiesLocalData().hobbies[index],
                  isChecked: selectedHobbies.contains(
                    HobbiesLocalData().hobbies[index],
                  ),
                  onPress: () {
                    if (selectedHobbies
                        .contains(HobbiesLocalData().hobbies[index])) {
                      setState(() {
                        selectedHobbies
                            .remove(HobbiesLocalData().hobbies[index]);
                      });
                    } else {
                      setState(() {
                        selectedHobbies.add(
                          HobbiesLocalData().hobbies[index],
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
                Get.toNamed(AppRoutes.desiredQuality);
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
