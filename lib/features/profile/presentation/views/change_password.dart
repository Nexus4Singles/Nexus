import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/text_field.dart';
import 'package:Nexus/features/profile/presentation/controllers/profile_ctr.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final ctr = Get.put(ProfileCtr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Change Password',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 54,
          child: CustomButton(
            onPressed: () {
              ctr.changePassword();
            },
            text: 'Update Password',
            textColor: white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBoxH40(),
            CustomTextField(
                controller: ctr.currentPassword, hintText: 'Current Password'),
            const SizedBoxH20(),
            CustomTextField(
                controller: ctr.newPassword, hintText: 'New Password'),
            const SizedBoxH20(),
            CustomTextField(
                controller: ctr.coNewPassword, hintText: 'Confirm Password'),
            const SizedBoxH25(),
            const SizedBoxH40(),
          ],
        ),
      ),
    );
  }
}
