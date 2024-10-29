import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/home/presentation/widgets/coming_soon_modal.dart';
import '../../features/match/presentation/widgets/matchUsersCompatibilityModal.dart';
import '../../features/profile/presentation/widgets/compatibility_modal.dart';
import '../../features/subscription/views/subscription.dart';
import '../assets.dart';
import '../colors.dart';
import '../models/user.dart';
import '../style.dart';
import 'empty_state.dart';

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
              child: MatchedUsersCompatibilityModal(
                userModel: userModel,
              )),
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
  final size = MediaQuery.of(context).size;
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: size.height * 0.3),
        child: Stack(children: [
          Dialog(
            //insetPadding: EdgeInsets.only(top: 10),
            backgroundColor: white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: SizedBox(
              height: Get.height / 2.7,
              child: EmptyStateWidget(
                  buttonText: "Subscribe",
                  buttonFunc: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SubscriptionScreen()));
                  },
                  message:
                      'This is a premium feature. The free version of Nexus allows you to search by City & Country of Residence. Subscribing gives you access to use advanced filters to narrow down your search.'),
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

chatWarningModal(context) {
  showAdaptiveDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: SizedBox(
            height: Get.height / 2.7,
            child: EmptyStateWidget(
                buttonText: "",
                showClose: true,
                buttonFunc: () {},
                svgAssetPath: "$svgPath/chatWarning.svg",
                message:
                    'We highly recommend spending enough time getting to know each other here before exchanging personal contacts \n\nHappy Texting!'),
          ),
        );
      });
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
