import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nexus/features/subscription/views/subscription.dart';
import '../../../core/colors.dart';
import '../../../core/utils/empty_state.dart';

restrictionModal(
    {context,
    dismisable,
    text = 'This is a premium feature. Subscribe now to use this feature.'}) {
  final size = MediaQuery.of(context).size;
  showAdaptiveDialog(
    context: context,
    barrierDismissible: dismisable,
    builder: (context) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: size.height * 0.27),
        child: Stack(children: [
          Dialog(
            //insetPadding: EdgeInsets.only(top: 10),
            backgroundColor: white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: SizedBox(
              height: Get.height / 2.7,
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
          ),
          Positioned(
            top: size.height * 0.042,
            right: size.height * 0.059,
            child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.clear,
                  color: primary,
                )),
          ),
        ]),
      );
    },
  );
}
