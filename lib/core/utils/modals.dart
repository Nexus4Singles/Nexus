import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/utils/empty_state.dart';

import '../../features/home/presentation/widgets/coming_soon_modal.dart';
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

subscribeModal(context) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: Get.height / 3,
              child: EmptyStateWidget(
                  buttonText: "Subscribe",
                  buttonFunc: () {},
                  message:
                      'This is a premium feature. The free version of Nexus allows you to search by City & Country of Residence. Subscribing gives you access to use advanced filters to narrow down your search.'),
            )),
      );
    },
  );
}

void comingSoonModal(String text, context) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog.adaptive(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: ComingSoonModal(text: text),
      );
    },
  );
}
