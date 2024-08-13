import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nexus/core/utils/empty_state.dart';
import 'package:nexus/features/chat/controllers/chat_ctr.dart';
import 'package:nexus/features/chat/widget/chat_container.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import '../../../router.dart';
import 'chat_rep.dart';

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
        title: Text('Chats',
            style: textStyle18.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
        actions: [
          InkWell(
            child: SvgPicture.asset('assets/icons/adjust.svg'),
            onTap: () {
              Get.toNamed(AppRoutes.settings);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Matches',
                  style: textStyle18.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBoxH15(),
                StreamBuilder<QuerySnapshot>(
                    stream: ctr.getAllMyChats(),
                    builder: (context, snapshot) {
                      print(
                          "does this snapshot have data ==> ${snapshot.hasData}");
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator.adaptive();
                      } else {
                        var data = snapshot.data!.docs;
                        var allChatUsers = ctr.filterChatList(data);
                        debugPrint("${allChatUsers.length}");
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              ...allChatUsers.map((users) {
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
                          ),
                        );
                      }
                    }),
                const SizedBoxH40(),
                Text('Chats',
                    style: textStyle18.copyWith(fontWeight: FontWeight.w800)),
                const SizedBoxH10(),
                StreamBuilder<QuerySnapshot>(
                    stream: ctr.getAllMyChats(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox(
                          height: Get.height / 2,
                          child: const Center(
                            child: EmptyStateWidget(
                                shouldShowImage: false,
                                message: 'You will see your chats here'),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator.adaptive();
                      } else {
                        var data = snapshot.data!.docs;
                        var allChatUsers = ctr.filterChatList(data);
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            ...allChatUsers
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
                        );
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
