import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nexus/core/models/user.dart';

import '../../../../core/colors.dart';

class ReportCtr extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  TextEditingController reportController = TextEditingController();
  var warningMessage = "".obs;

  submitReport(UserModel userModel) async {
    try {
      EasyLoading.show();
      var reportID = DateTime.now().millisecondsSinceEpoch;
      await db.collection("reports").doc(reportID.toString()).set({
        'id': reportID.toString(),
        'createdAt': Timestamp.now(),
        "reporter_id": auth.currentUser!.uid,
        "reported": userModel.username,
        "reported_id": userModel.id,
        "reason": reportController.text.trim()
      });
      Get.back();
      Get.snackbar("Submitted Successfully",
          "Your report has been submitted successfully",
          colorText: white, backgroundColor: black);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  void _checkWordLimit() {
    final text = reportController.text;
    final words = text
        .trim()
        .split(RegExp(r'\s+'))
        .where((String word) => word.isNotEmpty)
        .toList();

    if (words.length > 100) {
      warningMessage.value = 'You have exceeded the 100-word limit';
      final truncatedText = words.take(100).join(' ');
      reportController.text = truncatedText;
      reportController.selection = TextSelection.fromPosition(
        TextPosition(offset: reportController.text.length),
      );
    } else {
      warningMessage.value = '';
    }
  }

  @override
  void onInit() {
    reportController.addListener(_checkWordLimit);
    super.onInit();
  }
}
