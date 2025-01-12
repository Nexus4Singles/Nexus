import 'dart:async';

import 'package:Nexus/core/constant.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/text_field.dart';
import 'package:Nexus/core/utils/device.dart';
import 'package:Nexus/core/utils/toast.dart';
import 'package:Nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:Nexus/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../core/colors.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({super.key});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  String state = '';
  String eduLevel = '';
  String profession = '';
  String country = '';
  String church = '';
  String churchValue = '';

  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController cityController = TextEditingController();
  TextEditingController churchController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  final TextEditingController instagramController = TextEditingController();
  final TextEditingController xController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController telegramController = TextEditingController();
  final TextEditingController snapchatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    instagramController.text = "@";
    xController.text = "@";
    facebookController.text = "@";
    telegramController.text = "@";
    snapchatController.text = "@";
    whatsappController.text = "+";
    _init();
  }

  FutureOr _init() {
    Provider.of<AuthNotifier>(context, listen: false).getProfile();
  }

  @override
  void dispose() {
    super.dispose();
    countryController.dispose();
    cityController.dispose();
    instagramController.dispose();
    xController.dispose();
    whatsappController.dispose();
    facebookController.dispose();
    telegramController.dispose();
    snapchatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: width(context) * .5,
            child: LinearProgressIndicator(
              value: 0.95,
              backgroundColor: newGrey,
              color: primary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  //Add validation
                  if (isNotEmpty()) {
                    model.updateProfile(
                      map: {
                        kINSTAGRAMUSERNAME: instagramController.text,
                        kTWITTERUSERNAME: xController.text,
                        kPHONENUMBER: whatsappController.text,
                        kFACEBOOKUSERNAME: facebookController.text,
                        kTELEGRAMUSERNAME: telegramController.text,
                        kSNAPCHATUSERNAME: snapchatController.text,
                        kREGPROGRESS: 'completed',
                      },
                      onCompleted: () {
                        Get.toNamed(AppRoutes.regSuccessful);
                      },
                    );
                  } else {
                    AppToast().showErrorToast(
                        "Please fill at least one social media platform");
                  }
                },
                child: Text(
                  'Next',
                  style: textStyle14.copyWith(
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                ),
              ),
            ),
            const SizedBoxW20(),
          ],
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
            ),
            child: Builder(builder: (context) {
              return Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Contact Information',
                      style: textStyle8.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: black),
                    ),
                    const SizedBoxH15(),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Kindly provide the details of the social media platforms you feel comfortable sharing, where users can easily contact you in case you're away from the app and unable to see messages.",
                              style: textStyle14.copyWith(
                                color: black.withOpacity(.8),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBoxH40(),
                    buildSocialMediaField(
                        "Instagram", instagramController, TextInputType.text),
                    const SizedBoxH15(),
                    buildSocialMediaField("X", xController, TextInputType.text),
                    const SizedBoxH15(),
                    buildSocialMediaField(
                      "WhatsApp",
                      whatsappController,
                      TextInputType.phone,
                      hintText: "Please add your country code (+)",
                    ),
                    const SizedBoxH15(),
                    buildSocialMediaField(
                        "Facebook", facebookController, TextInputType.text),
                    const SizedBoxH15(),
                    buildSocialMediaField(
                        "Telegram", telegramController, TextInputType.text),
                    const SizedBoxH15(),
                    buildSocialMediaField(
                        "Snapchat", snapchatController, TextInputType.text),
                    const SizedBoxH15(),
                    const SizedBoxH15(),
                    const SizedBoxH40(),
                  ],
                ),
              );
            }),
          ),
        ),
      );
    });
  }

  bool isNotEmpty() {
    return (instagramController.text.isNotEmpty &&
            instagramController.text != '@') ||
        (xController.text.isNotEmpty && xController.text != '@') ||
        (whatsappController.text.isNotEmpty &&
            whatsappController.text != '+') ||
        (facebookController.text.isNotEmpty &&
            facebookController.text != '@') ||
        (telegramController.text.isNotEmpty &&
            telegramController.text != '@') ||
        (snapchatController.text.isNotEmpty && snapchatController.text != '@');
  }

  Widget buildSocialMediaField(
    String label,
    TextEditingController controller,
    TextInputType inputType, {
    String hintText = "Username",
  }) {
    return Row(
      //  crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          getSocialMediaIcon(label),
          width: 35,
          height: 35,
        ),
        const SizedBoxW10(),
        Expanded(
          child: CustomTextField(
            controller: controller,
            keyboardType: inputType,
            hintText: hintText,
            onChanged: (value) {
              if (label == "WhatsApp" && !value.startsWith("+")) {
                controller.text = "+$value";
                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length),
                );
              }
              if (label != "WhatsApp" && !value.startsWith("@")) {
                controller.text = "@$value";
                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length),
                );
              }
            },
          ),
        ),
      ],
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
}
