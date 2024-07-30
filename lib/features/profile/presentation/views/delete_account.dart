import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/profile/presentation/controllers/profile_ctr.dart';

class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});

  final ctr = Get.put(ProfileCtr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(backgroundColor: white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('$svgPath/sad.svg'),
            const SizedBoxH20(),
            Text(
              "We are sad to see you go but we would be more excited if you're leaving because you found your partner here. If this is the case, kindly inform us by sending your story to",
              textAlign: TextAlign.center,
              style:
                  textStyle14.copyWith(fontWeight: FontWeight.w500, color: ash),
            ),
            Text(
              "contact@nexus4singles",
              textAlign: TextAlign.center,
              style: textStyle16.copyWith(
                  fontWeight: FontWeight.w800, color: black),
            ),
            const SizedBoxH25(),
            CustomButton(
              onPressed: () {
                ctr.deleteAccount();
              },
              bgColor: primary,
              text: 'Delete',
              textColor: white,
            ),
            const SizedBoxH40(),
            const SizedBoxH40(),
          ],
        ),
      ),
    );
  }
}
