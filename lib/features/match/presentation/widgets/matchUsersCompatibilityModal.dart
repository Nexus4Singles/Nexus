import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';

class MatchedUsersCompatibilityModal extends StatelessWidget {
  final UserModel userModel;
  const MatchedUsersCompatibilityModal({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: Get.height / 2,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(20)),
      child: userModel.compatibilitySetted == null ||
              userModel.compatibilitySetted == false
          ? Center(
              child: Text(
              "${userModel.username} has not set their compatibility data",
              style: textStyle14.copyWith(color: white),
            ))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Compatibility Data',
                        style: textStyle16.copyWith(
                            color: white, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    InkWell(
                      child: const Icon(Icons.clear, color: white),
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
                const SizedBoxH10(),
                const Divider(color: white),
                const SizedBoxH10(),
                Text(
                  userModel.compatibility!.maritalStatus!.toLowerCase() ==
                          "never married"
                      ? "• ${userModel.username} has never been married"
                      : "• ${userModel.username} has been married",
                  style: textStyle14.copyWith(color: white),
                  textAlign: TextAlign.start,
                ),
                const SizedBoxH10(),
                Text(
                    userModel.compatibility!.haveKids!.toLowerCase() == "no"
                        ? "• ${userModel.username} doesn't have kids"
                        : "${userModel.username} have kids",
                    style: textStyle14.copyWith(color: white)),
                const SizedBoxH10(),
                Text(
                  "• ${userModel.username} has an ${userModel.compatibility!.genotype} Genotype",
                  style: textStyle14.copyWith(color: white),
                  textAlign: TextAlign.start,
                ),
                const SizedBoxH10(),
                Text(
                  "• ${userModel.username} is an ${userModel.compatibility!.personalityType}",
                  style: textStyle14.copyWith(color: white),
                  textAlign: TextAlign.start,
                ),
                const SizedBoxH10(),
                Text(
                  userModel.compatibility!.regularSourceOfIncome!
                              .toLowerCase() ==
                          "yes"
                      ? "• ${userModel.username} has a regular source of income"
                      : "• ${userModel.username} doesn't  have a regular source of income",
                  style: textStyle14.copyWith(color: white),
                  textAlign: TextAlign.start,
                ),
                const SizedBoxH10(),
                Text(
                  "• ${userModel.username} ${userModel.compatibility!.marrySomeoneNotFS!.contains("Yes") ? "can" : "cannot"} date or marry someone who is not yet financially stable",
                  style: textStyle14.copyWith(color: white),
                  textAlign: TextAlign.start,
                ),
                const SizedBoxH10(),
                Text(
                  "• ${userModel.username} ${userModel.compatibility!.believeInCohiabiting!.contains("Yes") ? "can" : "cannot"} date or marry someone who is not yet financially stable",
                  style: textStyle14.copyWith(color: white),
                  textAlign: TextAlign.start,
                ),
                const SizedBoxH10(),
                Text(
                  "• ${userModel.username} ${userModel.compatibility!.believeInCohiabiting!.toLowerCase().contains("yes") ? "believe" : "doesn't believe"} in cohabiting before marriage",
                  style: textStyle14.copyWith(color: white),
                  textAlign: TextAlign.start,
                ),
                const SizedBoxH10(),
                Text(
                  "• ${userModel.username} ${userModel.compatibility!.shouldChristianSpeakInTongue!.toLowerCase().contains("yes") ? "believe" : "doesn't believe"} every Christian should desire to speak in tongues",
                  style: textStyle14.copyWith(color: white),
                  textAlign: TextAlign.start,
                ),
                const SizedBoxH10(),
                Text(
                  "• ${userModel.username} ${userModel.compatibility!.believeInTithing!.toLowerCase().contains("yes") ? "believe" : "doesn't believe"} in tithing",
                  style: textStyle14.copyWith(color: white),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
    );
  }
}
