import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/text_field.dart';
import '../../../core/models/chats_model.dart';
import '../controllers/chat_ctr.dart';

class ImageSelectedContainer extends StatelessWidget {
  final ChatModel chatModel;
  final File imageFile;
  ImageSelectedContainer(
      {super.key, required this.imageFile, required this.chatModel});

  final ctr = Get.put(ChatCtr());
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: FileImage(imageFile), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      ctr.imageFile.value = File('');
                      ctr.chatController.clear();
                      Get.back();
                    },
                    icon: const CircleAvatar(
                      backgroundColor: white,
                      child: Icon(
                        Icons.close,
                        color: black,
                        size: 20,
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        fillColor: white,
                        borderColor: Colors.transparent,
                        controller: ctr.chatController,
                        hintText: "Add a message"),
                  ),
                  const SizedBoxW10(),
                  InkWell(
                    onTap: () {
                      ctr.sendMessage(chatModel.messageID,
                          ctr.chatController.text, chatModel.userModel!);
                      Get.back();
                    },
                    child: CircleAvatar(
                        radius: 24,
                        backgroundColor: primary,
                        child: SvgPicture.asset('$svgPath/send.svg')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
