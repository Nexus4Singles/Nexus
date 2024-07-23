import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          : SingleChildScrollView(
              child: Column(
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
                  optionsMenu(
                    userModel.compatibility!.maritalStatus!.toLowerCase() ==
                            "never married"
                        ? "${userModel.username} has never been married"
                        : "${userModel.username} has been married",
                  ),
                  optionsMenu(
                      userModel.compatibility!.haveKids!.toLowerCase() == "no"
                          ? "${userModel.username} doesn't have kids"
                          : "${userModel.username} have kids"),
                  optionsMenu(
                      "${userModel.username} has an ${userModel.compatibility!.genotype} Genotype"),
                  optionsMenu(
                      "${userModel.username} is an ${userModel.compatibility!.personalityType}"),
                  optionsMenu(userModel.compatibility!.regularSourceOfIncome!
                              .toLowerCase() ==
                          "yes"
                      ? "${userModel.username} has a regular source of income"
                      : "${userModel.username} doesn't  have a regular source of income"),
                  optionsMenu(
                    "${userModel.username} ${userModel.compatibility!.marrySomeoneNotFS!.contains("Yes") ? "can" : "cannot"} date or marry someone who is not yet financially stable",
                  ),
                  optionsMenu(
                    "${userModel.username} ${userModel.compatibility!.believeInCohiabiting!.contains("Yes") ? "can" : "cannot"} date or marry someone who is not yet financially stable",
                  ),
                  optionsMenu(
                    "${userModel.username} ${userModel.compatibility!.believeInCohiabiting!.toLowerCase().contains("yes") ? "believe" : "doesn't believe"} in cohabiting before marriage",
                  ),
                  optionsMenu(
                    "${userModel.username} ${userModel.compatibility!.shouldChristianSpeakInTongue!.toLowerCase().contains("yes") ? "believe" : "doesn't believe"} every Christian should desire to speak in tongues",
                  ),
                  optionsMenu(
                    "${userModel.username} ${userModel.compatibility!.believeInTithing!.toLowerCase().contains("yes") ? "believe" : "doesn't believe"} in tithing",
                  )
                ],
              ),
            ),
    );
  }
}

optionsMenu(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(radius: 2, backgroundColor: white),
        const SizedBoxW5(),
        Flexible(
          child: Text(
            text,
            style: textStyle14.copyWith(color: white),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    ),
  );
}
