import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/device.dart';
import 'package:Nexus/router.dart';

class CompatabiltyModal extends StatelessWidget {
  const CompatabiltyModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBoxH15(),
        Text(
          'Please take one (1) minute to answer these questions to help us know more about you',
          style: textStyle14.copyWith(
            color: primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBoxH15(),
        SizedBox(
          width: width(context) * .4,
          child: CustomButton(
            hPadding: 10,
            vPadding: 10,
            onPressed: () {
              Navigator.of(context).pop();
              Get.toNamed(AppRoutes.compatibilityQuiz);
            },
            text: 'Start',
          ),
        ),
      ],
    );
  }
}
