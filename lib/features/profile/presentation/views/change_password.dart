import 'package:flutter/material.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CustomTextField(
                controller: TextEditingController(),
                hintText: 'Current Password'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot password',
                  style: textStyle10.copyWith(
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                )
              ],
            ),
            const SizedBoxH20(),
            CustomTextField(
                controller: TextEditingController(), hintText: 'New Password'),
            const SizedBoxH20(),
            CustomTextField(
                controller: TextEditingController(),
                hintText: 'Confirm Password'),
            const SizedBoxH25(),
            const SizedBoxH40(),
            CustomButton(
              onPressed: () {},
              text: 'save',
              textColor: white,
            )
          ],
        ),
      ),
    );
  }
}
