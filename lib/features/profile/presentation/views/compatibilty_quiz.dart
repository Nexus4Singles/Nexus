import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/profile/presentation/widgets/compat_radio.dart';
import 'package:nexus/features/profile/presentation/widgets/compat_success.dart';

class CompatibilityQuizScreen extends StatefulWidget {
  const CompatibilityQuizScreen({super.key});

  @override
  State<CompatibilityQuizScreen> createState() =>
      _CompatibilityQuizScreenState();
}

class _CompatibilityQuizScreenState extends State<CompatibilityQuizScreen> {
  String maritalStatus = '';
  String haveKids = '';
  String genotype = '';
  String personalityType = '';
  String regularSourceOfIncome = '';
  String dateWhoIsNotFinanciallyStable = '';
  String mentallyReadyForMarriage = '';
  String believeInCohabitingBeforeMarriage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: white,
        title: Text(
          'Compatibility Quiz',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kindly answer the questions below. Your responses will not be visible on your profile. It will only be visible to your matched users to provide them with more information on their compatibility with you.',
              style: textStyle14,
              textAlign: TextAlign.center,
            ),
            const SizedBoxH25(),
            Text(
              '1. What is your Marital Status?',
              style: textStyle14.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            CompatRadio(
              groupVal: maritalStatus,
              val: 'Never Married',
              onChanged: (p0) {
                setState(() {
                  maritalStatus = p0!;
                });
              },
            ),
            CompatRadio(
              groupVal: maritalStatus,
              val: 'Divorced',
              onChanged: (p0) {
                setState(() {
                  maritalStatus = p0!;
                });
              },
            ),
            CompatRadio(
              groupVal: maritalStatus,
              val: 'Widow/Widower',
              onChanged: (p0) {
                setState(() {
                  maritalStatus = p0!;
                });
              },
            ),
            const SizedBoxH20(),
            Text(
              '2. Do you have kids?',
              style: textStyle14.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            CompatRadio(
              groupVal: haveKids,
              val: 'Yes',
              onChanged: (p0) {
                setState(() {
                  haveKids = p0!;
                });
              },
            ),
            CompatRadio(
              groupVal: haveKids,
              val: 'No',
              onChanged: (p0) {
                setState(() {
                  haveKids = p0!;
                });
              },
            ),
            const SizedBoxH20(),
            Text(
              '3. What is your Genotype?',
              style: textStyle14.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            CompatRadio(
              groupVal: genotype,
              val: 'AA',
              onChanged: (p0) {
                setState(() {
                  genotype = p0!;
                });
              },
            ),
            CompatRadio(
              groupVal: genotype,
              val: 'AC',
              onChanged: (p0) {
                setState(() {
                  genotype = p0!;
                });
              },
            ),
            CompatRadio(
              groupVal: genotype,
              val: 'AS',
              onChanged: (p0) {
                setState(() {
                  genotype = p0!;
                });
              },
            ),
            CompatRadio(
              groupVal: genotype,
              val: 'SS',
              onChanged: (p0) {
                setState(() {
                  genotype = p0!;
                });
              },
            ),
            const SizedBoxH20(),
            Text(
              '4. What is your Personality type?',
              style: textStyle14.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            CompatRadio(
              groupVal: personalityType,
              val: 'Ambivert',
              onChanged: (p0) {
                setState(() {
                  personalityType = p0!;
                });
              },
            ),
            CompatRadio(
              groupVal: personalityType,
              val: 'Extrovert',
              onChanged: (p0) {
                setState(() {
                  personalityType = p0!;
                });
              },
            ),
            CompatRadio(
              groupVal: personalityType,
              val: 'Introvert',
              onChanged: (p0) {
                setState(() {
                  personalityType = p0!;
                });
              },
            ),
            const SizedBoxH20(),
            Text(
              '5. Do you have a regular source of income?',
              style: textStyle14.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            CompatRadio(
              groupVal: regularSourceOfIncome,
              val: 'Yes',
              onChanged: (p0) {
                setState(() {
                  regularSourceOfIncome = p0!;
                });
              },
            ),
            CompatRadio(
              groupVal: regularSourceOfIncome,
              val: 'No',
              onChanged: (p0) {
                setState(() {
                  regularSourceOfIncome = p0!;
                });
              },
            ),
            const SizedBoxH20(),
            Text(
              '6. Can you date or marry someone who is not yet financially stable?',
              style: textStyle14.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            CompatRadio(
              groupVal: dateWhoIsNotFinanciallyStable,
              val: 'Yes, as long as they are diligent & responsible',
              onChanged: (p0) {
                setState(() {
                  dateWhoIsNotFinanciallyStable = p0!;
                });
              },
            ),
            CompatRadio(
              groupVal: dateWhoIsNotFinanciallyStable,
              val: 'No, due to reasons that are important to me',
              onChanged: (p0) {
                setState(() {
                  dateWhoIsNotFinanciallyStable = p0!;
                });
              },
            ),
            const SizedBoxH20(),
            Text(
              '7. Are you mentally ready for marriage?',
              style: textStyle14.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            CompatRadio(
              groupVal: mentallyReadyForMarriage,
              val: 'Yes',
              onChanged: (p0) {
                setState(() {
                  mentallyReadyForMarriage = p0!;
                });
              },
            ),
            CompatRadio(
              groupVal: mentallyReadyForMarriage,
              val: 'No',
              onChanged: (p0) {
                setState(() {
                  mentallyReadyForMarriage = p0!;
                });
              },
            ),
            const SizedBoxH20(),
            Text(
              '8. Do you believe in cohabiting before marriage?',
              style: textStyle14.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            CompatRadio(
              groupVal: believeInCohabitingBeforeMarriage,
              val: 'Yes',
              onChanged: (p0) {
                setState(() {
                  believeInCohabitingBeforeMarriage = p0!;
                });
              },
            ),
            CompatRadio(
              groupVal: believeInCohabitingBeforeMarriage,
              val: 'No',
              onChanged: (p0) {
                setState(() {
                  believeInCohabitingBeforeMarriage = p0!;
                });
              },
            ),
            const SizedBoxH40(),
            CustomButton(
              onPressed: () {
                showAdaptiveDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text(
                        'Compatibility Quiz',
                        style: textStyle16,
                      ),
                      content: const CompatibilitySuccessful(),
                    );
                  },
                );
              },
              text: 'Submit',
            ),
            const SizedBoxH40(),
          ],
        ),
      ),
    );
  }
}
