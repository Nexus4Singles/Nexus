import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/models/user.dart';

import '../../features/match/presentation/widgets/matchUsersCompatibilityModal.dart';
import '../colors.dart';

compatibilityModal(context, UserModel userModel) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MatchedUsersCompatibilityModal(userModel: userModel)),
        ),
      );
    },
  );
}
