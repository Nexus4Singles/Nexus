import 'package:flutter/material.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/button_outline.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/sadface.png'),
            SizedBoxH20(),
            Text(
              'We are sad to see you go. If you want to\npermanently delete your account, click Delete',
              style:
                  textStyle16.copyWith(fontWeight: FontWeight.w600, color: ash),
            ),
            SizedBoxH25(),
            CustomButton(
              onPressed: () {},
              text: 'Keep Account',
              textColor: white,
            ),
            SizedBoxH15(),
            CustomButtonOut(
              onPressed: () {},
              bgColor: primary,
              text: 'Delete',
              textColor: primary,
            ),
          ],
        ),
      ),
    );
  }
}
