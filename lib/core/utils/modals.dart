import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/utils/empty_state.dart';
import '../../features/home/presentation/widgets/coming_soon_modal.dart';
import '../../features/match/presentation/widgets/matchUsersCompatibilityModal.dart';
import '../../features/profile/presentation/widgets/compatibility_modal.dart';
import '../colors.dart';
import '../style.dart';

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

compatibilityQuestions(context) {
  return showAdaptiveDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog.adaptive(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Compatibility Quiz',
          style: textStyle16,
        ),
        content: const CompatabiltyModal(),
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
        child: SizedBox(
          height: Get.height / 2.5,
          child: EmptyStateWidget(
              showClose: true,
              buttonText: "Subscribe",
              buttonFunc: () {},
              message:
                  'This is a premium feature. The free version of Nexus allows you to search by City & Country of Residence. Subscribing gives you access to use advanced filters to narrow down your search.'),
        ),
      );
    },
  );
}

chatWarningModal(context) {
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
              height: Get.height / 3.0,
              child: EmptyStateWidget(
                  buttonText: "",
                  showClose: true,
                  buttonFunc: () {},
                  svgAssetPath: "$svgPath/chatWarning.svg",
                  message:
                      'We highly recommend spending enough time getting to know each other here before exchanging personal contacts \n\nHappy Texting!'),
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
