import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Nexus/features/subscription/views/subscription.dart';
import '../../../core/colors.dart';
import '../../../core/utils/empty_state.dart';

restrictionModal(
    {context,
    dismisable,
    text = 'This is a premium feature. Subscribe now to use this feature.'}) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: dismisable,
    builder: (context) {
      return Dialog(
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: SizedBox(
          height: Get.height / 3.19,
          child: EmptyStateWidget(
              showClose: true,
              buttonText: "Subscribe",
              buttonFunc: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SubscriptionScreen()),
                );
              },
              message: text),
        ),
      );
    },
  );
}
