import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/models/chats_model.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/chat/controllers/chat_ctr.dart';
import 'package:nexus/features/home/presentation/views/user_details.dart';

import '../../../core/models/message_model.dart';

class ChatWithScreen extends StatefulWidget {
  final ChatModel chatModel;
  const ChatWithScreen({
    super.key,
    required this.chatModel,
  });

  @override
  State<ChatWithScreen> createState() => _ChatWithScreenState();
}

class _ChatWithScreenState extends State<ChatWithScreen> {
  var ctr = Get.put(ChatCtr());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 32,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() =>
                      UserDetailScreen(userModel: widget.chatModel.userModel!));
                },
                child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.chatModel.userModel!.photos![0])),
              ),
              const SizedBoxW10(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatModel.userModel!.username,
                    style: textStyle14.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'online',
                    style: textStyle12,
                  )
                ],
              ),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: ctr.getMyConversations(widget.chatModel.messageID),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text("No Message yet!."));
              } else {
                var data = snapshot.data!.docs;
                final message = data
                    .map((e) =>
                        MessageModel.fromJson(e.data() as Map<String, dynamic>))
                    .toList();
                List<ChatMessage> messages = <ChatMessage>[];
                for (var element in message) {
                  messages.add(ChatMessage(
                      text: element.message,
                      user: ChatUser(id: element.sentBy, profileImage: ""),
                      createdAt: element.timestamp.toDate()));
                }
                return DashChat(
                  currentUser: ChatUser(id: ctr.auth.currentUser!.uid),
                  inputOptions: InputOptions(
                      alwaysShowSend: true,
                      sendButtonBuilder: (val) {
                        return InkWell(
                          onTap: val,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: primary,
                              child: SvgPicture.asset("$svgPath/send.svg"),
                            ),
                          ),
                        );
                      },
                      inputDecoration: InputDecoration(
                          hintText: "Send a message",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: PopupMenuButton<Map<String, IconData>>(
                            position: PopupMenuPosition.over,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            onSelected: (item) {
                              print('Selected: $item');
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundColor: primary,
                                  child: Icon(
                                    Icons.add_box_rounded,
                                    color: Colors.white,
                                  )),
                            ),
                            itemBuilder: (BuildContext context) {
                              return {
                                'Audio': Iconsax.microphone5,
                                'Video': Iconsax.video_add5,
                                'Image': Iconsax.image1,
                              }.entries.map((entry) {
                                return PopupMenuItem<Map<String, IconData>>(
                                  value: {
                                    entry.key: entry.value
                                  }, // Map as value
                                  textStyle: textStyle14.copyWith(color: black),
                                  child: InkWell(
                                    onTap: () {
                                      entry.key == "Image"
                                          ? ctr.pickImage()
                                          : ctr.pickImage();
                                    },
                                    child: Row(
                                      children: [
                                        Icon(entry.value),
                                        const SizedBox(width: 8),
                                        Text(entry.key),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            // ... rest of your code ...
                          ),
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(color: grey)))),
                  messageOptions: const MessageOptions(
                      showOtherUsersAvatar: false,
                      containerColor: babyPink,
                      currentUserContainerColor: whiteblue),
                  onSend: (ChatMessage message) {
                    ctr.sendMessage(widget.chatModel.messageID, message.text);
                  },
                  messages: messages,
                );
              }
            }));
  }
}

assetPopOver() {
  return PopupMenuButton<Map<String, IconData>>(
    // Use Map for value
    onSelected: (item) {
      print('Selected: $item');
    },
    itemBuilder: (BuildContext context) {
      return {
        'Audio': Icons.mic,
        'Video': Icons.videocam,
        'Image': Icons.image,
      }.entries.map((entry) {
        return PopupMenuItem<Map<String, IconData>>(
          value: {entry.key: entry.value}, // Map as value
          textStyle: textStyle14.copyWith(color: black),
          child: Row(
            children: [
              Icon(entry.value),
              const SizedBox(width: 8),
              Text(entry.key),
            ],
          ),
        );
      }).toList();
    },
    // ... rest of your code ...
  );
}
