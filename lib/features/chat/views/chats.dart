import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nexus/core/utils/empty_state.dart';
import 'package:nexus/features/chat/controllers/chat_ctr.dart';
import 'package:nexus/features/chat/views/chat_with.dart';
import 'package:nexus/features/chat/widget/chat_container.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  var ctr = Get.put(ChatCtr());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Chats',
          style: textStyle18.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: black,
          ),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
        actions: [
          SvgPicture.asset(
            'assets/icons/adjust.svg',
          ),
          const SizedBoxW15(),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: TextEditingController(),
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search_sharp),
                    radius: 25,
                    fillColor: white,
                    borderColor: black,
                  ),
                  const SizedBoxH20(),
                  Text(
                    'Recent Matches',
                    style: textStyle16.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBoxH15(),
                  ctr.allChatUsers
                          .where((val) => val.lastMessage.isEmpty)
                          .isNotEmpty
                      ? Row(
                          children: [
                            ...ctr.allChatUsers
                                .where((val) => val.lastMessage.isEmpty)
                                .map((users) {
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                      () => ChatWithScreen(chatModel: users));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: CircleAvatar(
                                    radius: 32,
                                    backgroundImage: NetworkImage(
                                        users.userModel!.photos![0]),
                                  ),
                                ),
                              );
                            }).toList()
                          ],
                        )
                      : const EmptyStateWidget(
                          message: "You don’t have any matches yet"),
                  const SizedBoxH20(),
                  Text('Chats',
                      style: textStyle18.copyWith(fontWeight: FontWeight.w500)),
                  const SizedBoxH20(),
                  ctr.allChatUsers
                          .where((val) => val.lastMessage.isNotEmpty)
                          .isNotEmpty
                      ? Column(
                          children: [
                            ...ctr.allChatUsers
                                .where((val) => val.lastMessage.isNotEmpty)
                                .map((val) {
                              return ChatContainer(
                                image: val.userModel!.photos![0],
                                name: val.userModel!.username,
                                time: val.timestamp.toDate(),
                                text: val.lastMessage,
                                count: ctr.auth.currentUser!.uid ==
                                        val.userSentLastMessage
                                    ? 0
                                    : val.unreadCount,
                                onPress: () {
                                  Get.to(() => ChatWithScreen(chatModel: val));
                                },
                              );
                            }).toList(),
                          ],
                        )
                      : const EmptyStateWidget(
                          message: 'You don’t have any chat yet')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
