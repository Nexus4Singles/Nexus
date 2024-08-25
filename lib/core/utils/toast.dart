import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';

class AppToast {
  void showToast(String label) {
    Get.snackbar(
      "Success",
      label,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      borderRadius: 10,
      isDismissible: true,
      margin: const EdgeInsets.all(20),
      colorText: white,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 2),
    );
  }

  void showErrorToast(
    String label, {
    Color? color,
    Color? textColor,
    String? header,
  }) {
    Get.snackbar(
      header ?? "Error",
      label,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color ?? primary,
      borderRadius: 10,
      isDismissible: true,
      margin: const EdgeInsets.all(20),
      colorText: textColor ?? white,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 2),
    );
  }
}
