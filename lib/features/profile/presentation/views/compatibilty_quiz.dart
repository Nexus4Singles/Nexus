import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/constant.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/toast.dart';
import 'package:Nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:Nexus/features/home/controllers/home_controller.dart';
import 'package:Nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:Nexus/features/profile/presentation/widgets/compat_radio.dart';
import 'package:Nexus/features/profile/presentation/widgets/compat_success.dart';
import 'package:Nexus/features/profile/presentation/widgets/compat_title.dart';
import 'package:provider/provider.dart';

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
  String longDistanceRelationship = '';
  String believeInCohabitingBeforeMarriage = '';
  String shouldChristianSpeakInTongue = '';
  String believeInTithing = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Consumer<HomeNotifier>(builder: (context, homeModel, _) {
        return Scaffold(
          appBar: AppBar(
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
                  style: textStyle12,
                  textAlign: TextAlign.center,
                ),
                const SizedBoxH25(),
                const CampaTitle(
                  num: '1',
                  title: 'What is your Marital Status?',
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
                const CampaTitle(
                  num: '2',
                  title: 'Do you have kids?',
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
                const CampaTitle(
                  num: '3',
                  title: 'What is your Genotype?',
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
                const CampaTitle(
                  num: '4',
                  title: 'What is your Personality type?',
                ),
                // Text(
                //   '4. What is your Personality type?',
                //   style: textStyle14.copyWith(
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
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
                const CampaTitle(
                  num: '5',
                  title: 'Do you have a regular source of income?',
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
                const CampaTitle(
                  num: '6',
                  title:
                      'Can you date or marry someone who is not yet financially stable?',
                ),

                CompatRadio(
                  groupVal: dateWhoIsNotFinanciallyStable,
                  val: 'Yes, as long as they are diligent & responsible.',
                  onChanged: (p0) {
                    setState(() {
                      dateWhoIsNotFinanciallyStable = p0!;
                    });
                  },
                ),
                CompatRadio(
                  groupVal: dateWhoIsNotFinanciallyStable,
                  val: 'No, due to reasons that are important to me.',
                  onChanged: (p0) {
                    setState(() {
                      dateWhoIsNotFinanciallyStable = p0!;
                    });
                  },
                ),
                const SizedBoxH20(),
                const CampaTitle(
                  num: '7',
                  title: 'Are you open to a long distance relationship?',
                ),

                CompatRadio(
                  groupVal: longDistanceRelationship,
                  val: 'Yes',
                  onChanged: (p0) {
                    setState(() {
                      longDistanceRelationship = p0!;
                    });
                  },
                ),
                CompatRadio(
                  groupVal: longDistanceRelationship,
                  val: 'No',
                  onChanged: (p0) {
                    setState(() {
                      longDistanceRelationship = p0!;
                    });
                  },
                ),
                const SizedBoxH20(),
                const CampaTitle(
                  num: '8',
                  title: 'Do you believe in cohabiting before marriage?',
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
                const SizedBoxH20(),
                const CampaTitle(
                  num: '9',
                  title: 'Should every Christian desire to speak in tongues?',
                ),

                CompatRadio(
                  groupVal: shouldChristianSpeakInTongue,
                  val: 'Yes, it is a very necessary gift for a Christian.',
                  onChanged: (p0) {
                    setState(() {
                      shouldChristianSpeakInTongue = p0!;
                    });
                  },
                ),
                CompatRadio(
                  groupVal: shouldChristianSpeakInTongue,
                  val: 'No, It´s a good gift but not that important.',
                  onChanged: (p0) {
                    setState(() {
                      shouldChristianSpeakInTongue = p0!;
                    });
                  },
                ),
                const SizedBoxH20(),
                const CampaTitle(
                  num: '10',
                  title: 'Do you believe in tithing?',
                ),
                CompatRadio(
                  groupVal: believeInTithing,
                  val: 'Yes, I take it seriously.',
                  onChanged: (p0) {
                    setState(() {
                      believeInTithing = p0!;
                    });
                  },
                ),
                CompatRadio(
                  groupVal: believeInTithing,
                  val: 'No, I don´t believe in it.',
                  onChanged: (p0) {
                    setState(() {
                      believeInTithing = p0!;
                    });
                  },
                ),
                const SizedBoxH30(),
                CustomButton(
                  onPressed: () {
                    if (maritalStatus.isEmpty ||
                        haveKids.isEmpty ||
                        genotype.isEmpty ||
                        personalityType.isEmpty ||
                        regularSourceOfIncome.isEmpty ||
                        dateWhoIsNotFinanciallyStable.isEmpty ||
                        longDistanceRelationship.isEmpty ||
                        believeInCohabitingBeforeMarriage.isEmpty ||
                        shouldChristianSpeakInTongue.isEmpty ||
                        believeInTithing.isEmpty) {
                      AppToast().showErrorToast(
                        'All questions must be answered',
                      );
                    } else {
                      Map<String, dynamic> map = {
                        kCOMPATIBILITYSETTED: true,
                        kCOMPATIBILITY: {
                          kMARITALSTATUS: maritalStatus,
                          kHAVEKIDS: haveKids,
                          kGENOTYPE: genotype,
                          kPERSONALITYTYPE: personalityType,
                          kREGULARSOURCEOFINCOME: regularSourceOfIncome,
                          kMARRYWHOISNOTFINANCIALLYSTABLE:
                              dateWhoIsNotFinanciallyStable,
                          kLONGDISTANCERELATIONSHIP: longDistanceRelationship,
                          kBELIEVEINCOHIABITING:
                              believeInCohabitingBeforeMarriage,
                          kSHOULDCHRISTIANSPEAKINTONGUE:
                              shouldChristianSpeakInTongue,
                          kBELIEVEINTITHING: believeInTithing,
                        }
                      };
                      model.updateProfile(
                        map: map,
                        onCompleted: () async {
                          await model.getProfile().then((value) async {
                            await HomeController.instance
                                .getMyProfile()
                                .then((val) {
                              Get.back();
                              showAdaptiveDialog(
                                context: context,
                                barrierDismissible: false,
                                barrierColor: primary,
                                builder: (context) {
                                  return AlertDialog.adaptive(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    content: const CompatibilitySuccessful(),
                                  );
                                },
                              );
                            });
                          });
                        },
                      );
                    }
                  },
                  text: 'Submit',
                ),
                const SizedBoxH40(),
              ],
            ),
          ),
        );
      });
    });
  }
}
