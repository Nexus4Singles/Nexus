import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/features/profile/presentation/controllers/report_ctr.dart';

import '../../../../core/colors.dart';
import '../../../../core/style.dart';
import '../../../../core/text_field.dart';

class ReportUser extends StatelessWidget {
  final UserModel userModel;
  ReportUser({super.key, required this.userModel});

  var ctr = Get.put(ReportCtr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                style: textStyle12),
            const SizedBoxH25(),
            CustomTextField(
              enabled: false,
              fillColor: white,
              controller: TextEditingController(text: userModel.username),
              hintText: 'Username of the user to be reported',
            ),
            const SizedBoxH15(),
            CustomTextField(
              isMulti: true,
              isTextArea: true,
              fillColor: white,
              maxLength: 100,
              controller: ctr.reportController,
              hintText:
                  'Please state briefly why you are reporting this user (100 words max)',
            ),
            const Spacer(),
            CustomButton(
              onPressed: () {
                ctr.submitReport(userModel);
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
