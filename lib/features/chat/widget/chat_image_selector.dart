import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/features/chat/controllers/chat_ctr.dart';
import 'package:nexus/router.dart';
import '../../../../core/colors.dart';

class ChatImageSelector extends StatelessWidget {
  final File imagePath;
  final String message;
  final String messageID;
  ChatImageSelector(
      {super.key,
      required this.imagePath,
      required this.message,
      required this.messageID});

  var ctr = Get.put(ChatCtr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.clear)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBoxH40(),
          Center(
            child: Text("Preview your Image before sending",
                style: textStyle14.copyWith(fontWeight: FontWeight.w700)),
          ),
          const SizedBoxH20(),
          Container(
            height: Get.height / 2,
            width: Get.width / 1.2,
            decoration: BoxDecoration(
                boxShadow: [boxShadow],
                border: Border.all(
                    color: white,
                    width: 5,
                    strokeAlign: BorderSide.strokeAlignOutside),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: AssetImage(imagePath.path), fit: BoxFit.cover)),
          ),
          Transform.translate(
            offset: const Offset(0, 50),
            child: Column(
              children: [
                Text(
                  "Very nice photo!",
                  style: textStyle14.copyWith(color: ash),
                ),
                const SizedBoxH20(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomTextField(
                      radius: 100,
                      fillColor: grey,
                      suffixIcon: InkWell(
                        onTap: () {
                          ctr.sendMessage(messageID, message);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: black,
                            child: SvgPicture.asset("$svgPath/send.svg"),
                          ),
                        ),
                      ),
                      controller: TextEditingController(),
                      hintText: "Send a message"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
