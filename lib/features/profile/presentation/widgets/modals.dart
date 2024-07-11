import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/features/profile/presentation/widgets/desire_edit.dart';
import '../../../../core/colors.dart';
import 'hobbies_edit.dart';

hobbiesModal(context) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                SizedBox(height: Get.height / 1.5, child: const HobbiesEdit())),
      );
    },
  );
}

desireModal(context) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                SizedBox(height: Get.height / 1.5, child: const DesireEdit())),
      );
    },
  );
}
