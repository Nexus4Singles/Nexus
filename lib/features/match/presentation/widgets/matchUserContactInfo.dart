import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/models/user.dart';

class MatchedUsersContactModal extends StatelessWidget {
  final UserModel userModel;
  const MatchedUsersContactModal({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: Get.height / 2.0,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: userModel.instagramUsername == null &&
              userModel.twitterUsername == null &&
              userModel.facebookUsername == null &&
              userModel.snapchatUsername == null &&
              userModel.telegramUsername == null
          ? Center(
              child: Text(
              "${userModel.username} has not set their contact information",
              textAlign: TextAlign.center,
              style: textStyle14.copyWith(color: white),
            ))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Contact informaton',
                          style: textStyle16.copyWith(
                              color: white, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      InkWell(
                        child: const Icon(Icons.clear, color: white),
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                  const SizedBoxH10(),
                  const Divider(color: white),
                  const SizedBoxH10(),
                  optionsMenu(
                      userModel.instagramUsername == null &&
                              userModel.instagramUsername == '@'
                          ? ""
                          : userModel.instagramUsername ?? "Unavailable",
                      'Instagram'),
                  optionsMenu(
                      userModel.twitterUsername == null &&
                              userModel.instagramUsername == '@'
                          ? ""
                          : userModel.twitterUsername ?? 'Unavailable',
                      'X'),
                  optionsMenu(
                      userModel.facebookUsername == null &&
                              userModel.instagramUsername == '@'
                          ? ""
                          : userModel.facebookUsername ?? "Unavailable",
                      'Facebook'),
                  optionsMenu(
                      userModel.snapchatUsername == null &&
                              userModel.instagramUsername == '@'
                          ? ""
                          : userModel.snapchatUsername ?? 'Unavailable',
                      'Snapchat'),
                  optionsMenu(
                      userModel.telegramUsername == null &&
                              userModel.instagramUsername == '@'
                          ? ""
                          : userModel.telegramUsername ?? "Unavailable",
                      'Telegram'),
                  optionsMenu(
                      userModel.phoneNumber == null &&
                              userModel.instagramUsername == '+'
                          ? "Unavailable"
                          : userModel.phoneNumber ?? 'Unavailable',
                      'WhatsApp'),
                ],
              ),
            ),
    );
  }
}

optionsMenu(String text, String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          getSocialMediaIcon(label),
          width: 35,
          height: 35,
        ),
        const SizedBoxW5(),
        Flexible(
          child: Text(
            text,
            style: textStyle14.copyWith(color: white),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    ),
  );
}

String getSocialMediaIcon(String platform) {
  switch (platform) {
    case "Instagram":
      return 'assets/icons/ig.svg';
    case "X":
      return 'assets/icons/x.svg';
    case "WhatsApp":
      return 'assets/icons/whatsapp.svg';
    case "Facebook":
      return 'assets/icons/facebook.svg';
    case "Telegram":
      return 'assets/icons/tg.svg';
    case "Snapchat":
      return 'assets/icons/snapchat-logo.svg';
    default:
      return 'assets/icons/sms1.svg';
  }
}
