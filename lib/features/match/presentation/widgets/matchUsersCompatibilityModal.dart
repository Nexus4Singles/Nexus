import 'package:Nexus/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/models/user.dart';

class MatchedUsersCompatibilityModal extends StatelessWidget {
  final UserModel userModel;
  const MatchedUsersCompatibilityModal({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: Get.height / 1.7,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(20)),
      child: userModel.compatibilitySetted == null ||
              userModel.compatibilitySetted == false
          ? Center(
              child: Text(
              "${userModel.username.toTitleCase().toTitleCase()} has not set their compatibility data",
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
                        ? "${userModel.username.toTitleCase().toTitleCase()} has never been married"
                        : "${userModel.username.toTitleCase().toTitleCase()} has been married before",
                  ),
                  optionsMenu(
                      userModel.compatibility!.haveKids!.toLowerCase() == "no"
                          ? "${userModel.username.toTitleCase()} doesn't have kids"
                          : "${userModel.username.toTitleCase()} has kids"),
                  optionsMenu(
                      "${userModel.username.toTitleCase()} has an ${userModel.compatibility!.genotype} Genotype"),
                  optionsMenu(
                      "${userModel.username.toTitleCase()} is an ${userModel.compatibility!.personalityType}"),
                  optionsMenu(userModel.compatibility!.regularSourceOfIncome!
                              .toLowerCase() ==
                          "yes"
                      ? "${userModel.username.toTitleCase()} has a regular source of income"
                      : "${userModel.username.toTitleCase()} doesn't have a regular source of income"),
                  optionsMenu(
                    "${userModel.username.toTitleCase()} ${userModel.compatibility!.marrySomeoneNotFS!.contains("Yes") ? "can" : "cannot"} date or marry someone who is not yet financially stable",
                  ),
                  optionsMenu(
                    "${userModel.username.toTitleCase()} ${userModel.compatibility!.longDistance!.contains("Yes") ? "is" : "is not"} open to a long distance relationship",
                  ),
                  optionsMenu(
                    "${userModel.username.toTitleCase()} ${userModel.compatibility!.believeInCohiabiting!.toLowerCase().contains("yes") ? "believes" : "doesn't believe"} in cohabiting before marriage",
                  ),
                  optionsMenu(
                    "${userModel.username.toTitleCase()} ${userModel.compatibility!.shouldChristianSpeakInTongue!.toLowerCase().contains("yes") ? "believes" : "doesn't believe"} every Christian should desire to speak in tongues",
                  ),
                  optionsMenu(
                    "${userModel.username.toTitleCase()} ${userModel.compatibility!.believeInTithing!.toLowerCase().contains("yes") ? "believes" : "doesn't believe"} in tithing",
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
