import 'dart:io';
import 'package:Nexus/features/subscription/provider/subscription_provider.dart';
import 'package:Nexus/features/subscription/widgets/restriction_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/assets.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/models/chats_model.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/text_field.dart';
import '../controllers/chat_ctr.dart';
import 'package:provider/provider.dart';

class ImageSelectedContainer extends StatelessWidget {
  final ChatModel chatModel;
  final File imageFile;

  ImageSelectedContainer({
    super.key,
    required this.imageFile,
    required this.chatModel,
  });

  final ctr = Get.put(ChatCtr());
  @override
  Widget build(BuildContext context) {
    final subProvider = Provider.of<SubscriptionProvider>(
      context,
      listen: false,
    );

    void handleSendMessage() {
      // Check if the user has used their one free text
      if (subProvider.usedOneFreeText) {
        // If the user has subscribed before but is no longer on a premium subscription
        if (subProvider.prevSubscribed && !subProvider.onPremium) {
          restrictionModal(
            context: context,
            dismisable: true,
            text:
                'Your subscription has expired!\nKindly subscribe to be able to send messages\nand use other features.',
          );
          return;
        }
        // If the user hasn't subscribed before and they're not chatting with the entitled user
        else if (!subProvider.prevSubscribed &&
            subProvider.entitledUser != chatModel.userModel!.id) {
          restrictionModal(
            context: context,
            dismisable: true,
            text:
                'You have used up your limit of one (1) chat per matched user on our free version.\nKindly subscribe to chat with other matched users.',
          );
          return;
        }
      }

      ctr.sendMessage(
        chatModel.messageID,
        ctr.chatController.text,
        chatModel.userModel!,
      );
      Get.back();
    }

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
                  ),
                )
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
                      hintText: "Add a message",
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  const SizedBoxW10(),
                  InkWell(
                    onTap: handleSendMessage,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: primary,
                      child: SvgPicture.asset('$svgPath/send.svg'),
                    ),
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
