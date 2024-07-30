import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/utils/text_area.dart';
import 'package:nexus/features/profile/presentation/controllers/report_ctr.dart';

import '../../../../core/colors.dart';
import '../../../../core/style.dart';
import '../../../../core/text_field.dart';

class ReportUser extends StatelessWidget {
  final UserModel userModel;
  ReportUser({super.key, required this.userModel});

  final ctr = Get.put(ReportCtr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Report User',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
                "We want to ensure the quality of users on this platform is constantly refined. Please assist us to achieve this goal by reporting any user who was toxic or manipulative to you or any user who recorded gibberish on their audio recordings just to create a profile. Thank you!",
                textAlign: TextAlign.center,
                style: textStyle10),
            const SizedBoxH25(),
            CustomTextField(
              enabled: false,
              fillColor: white,
              controller: TextEditingController(text: userModel.username),
              hintText: 'Username of the user to be reported',
            ),
            const SizedBoxH15(),
            Obx(
              () => Expanded(
                child: CustomTextArea(
                  onChanged: (val) {
                    final words = val
                        .trim()
                        .split(RegExp(r'\s+'))
                        .where((word) => word.isNotEmpty)
                        .toList();
                    if (words.length > 100) {
                      final truncatedText = words.take(100).join(' ');
                      ctr.reportController.value = TextEditingValue(
                        text: truncatedText,
                        selection: TextSelection.collapsed(
                            offset: truncatedText.length),
                      );
                    }
                  },
                  maxLines: 5,
                  errorText: ctr.warningMessage.value == ''
                      ? null
                      : ctr.warningMessage.value,
                  controller: ctr.reportController,
                  hintText:
                      'Please state briefly why you are reporting this user (100 words max)',
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              onPressed: () {
                if (ctr.reportController.text.isNotEmpty &&
                    ctr.warningMessage.value.isEmpty) {
                  ctr.submitReport(userModel);
                }
              },
              text: "Submit",
            ),
            const SizedBoxH25(),
          ],
        ),
      ),
    );
  }
}
