import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/models/chats_model.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/modals.dart';
import 'package:nexus/features/chat/controllers/chat_ctr.dart';
import 'package:nexus/features/home/presentation/views/user_details.dart';
import '../../../core/models/message_model.dart';
import '../../profile/presentation/views/report_user.dart';

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
  void initState() {
    if (ctr.exploreCtr.myProfile.value.usersChatWarning == null) {
      Future.delayed(
          const Duration(milliseconds: 100), () => chatWarningModal(context));
      ctr.setUserTohaveShowWarning(widget.chatModel.userModel!.id);
    } else {
      if (!ctr.exploreCtr.myProfile.value.usersChatWarning!
          .contains(widget.chatModel.userModel!.id)) {
        Future.delayed(
            const Duration(milliseconds: 100), () => chatWarningModal(context));
        ctr.setUserTohaveShowWarning(widget.chatModel.userModel!.id);
      } else {}
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 32,
          actions: [
            InkWell(
              onTap: () {
                EasyLoading.showToast("Coming Soon",
                    maskType: EasyLoadingMaskType.black);
              },
              child: const Icon(
                Iconsax.call,
                color: primary,
              ),
            ),
            const SizedBoxW20(),
            InkWell(
              child: const Icon(Icons.report),
              onTap: () {
                Get.to(
                    () => ReportUser(userModel: widget.chatModel.userModel!));
              },
            ),
            const SizedBoxW15()
          ],
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      customProperties: {"id": element.id},
                      medias: element.media.isEmpty
                          ? []
                          : [
                              ChatMedia(
                                  url: element.media,
                                  fileName: element.media,
                                  type: element.messageType == "Video"
                                      ? MediaType.video
                                      : MediaType.image)
                            ],
                      user: ChatUser(id: element.sentBy, profileImage: ""),
                      createdAt: element.timestamp.toDate()));
                }
                return DashChat(
                  currentUser: ChatUser(id: ctr.auth.currentUser!.uid),
                  inputOptions: InputOptions(
                      textController: ctr.chatController,
                      textInputAction: TextInputAction.newline,
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
                            onSelected: (item) {},
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
                                          ? ctr.pickImage(widget.chatModel)
                                          : entry.key == "Video"
                                              ? ctr.pickVideo(widget.chatModel)
                                              : () {};
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
                  messageOptions: MessageOptions(
                      onLongPressMessage: (message) {
                        if (widget.chatModel.userModel!.id == message.user.id) {
                        } else {
                          openModal(context, message);
                        }
                      },
                      showOtherUsersAvatar: false,
                      containerColor: babyPink,
                      currentUserContainerColor: whiteblue),
                  onSend: (ChatMessage message) {
                    ctr.sendMessage(widget.chatModel.messageID, message.text,
                        widget.chatModel.userModel!);
                  },
                  messages: messages,
                );
              }
            }));
  }

  openModal(context, ChatMessage message) {
    var ctr = Get.put(ChatCtr());
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
            title: const Text('Options for Chat'),
            actions: [
              CupertinoActionSheetAction(
                child: const Text('Reply'),
                onPressed: () {
                  EasyLoading.showToast("Coming soon");
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Copy Message'),
                onPressed: () {
                  Get.back();
                  Clipboard.setData(ClipboardData(text: message.text));
                  EasyLoading.showToast("Message copied");
                },
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: const Text('Delete'),
                onPressed: () {
                  ctr.deleteAMessage(widget.chatModel.messageID,
                      message.customProperties!['id']);
                  Get.back();
                },
              ),
            ]);
      },
    );
  }
}
