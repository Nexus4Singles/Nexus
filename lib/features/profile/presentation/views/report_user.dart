import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/utils/text_area.dart';
import 'package:Nexus/features/profile/presentation/controllers/report_ctr.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                  "We want to ensure the quality of users on Nexus are constantly refined. Please assist us to achieve this goal by reporting any user who was toxic or manipulative to you, or any user with inappropriate pictures or recordings. Thank you!",
                  textAlign: TextAlign.center,
                  style: textStyle12),
            ),
            const SizedBoxH25(),
            CustomTextField(
              enabled: false,
              fillColor: white,
              controller: TextEditingController(text: userModel.username),
              hintText: 'Username of the User to be Reported',
            ),
            const SizedBoxH15(),
            Obx(
              () => CustomTextArea(
                onChanged: (val) {
                  final words = val
                      .trim()
                      .split(RegExp(r'\s+'))
                      .where((word) => word.isNotEmpty)
                      .toList();
                  if (words.length > 100) {
                    ctr.warningMessage.value =
                        'You have exceeded the 100-word limit';
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
