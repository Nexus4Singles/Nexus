import 'package:flutter/material.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';

class VerifyAccScreen extends StatefulWidget {
  const VerifyAccScreen({super.key});

  @override
  State<VerifyAccScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Verify Account',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 100),
        child: Column(
          children: [
            CustomTextField(
                controller: TextEditingController(),
                hintText: 'Enter Email Address'),
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
