import 'package:Nexus/core/services/fcm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/empty_state.dart';
import 'package:Nexus/features/chat/controllers/chat_ctr.dart';
import 'package:Nexus/features/chat/widget/chat_container.dart';
import '../../../router.dart';
import '../../home/presentation/widgets/cache_network_widget.dart';
import 'chat_rep.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> with WidgetsBindingObserver {
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator.adaptive();
                      } else {
                        var data = snapshot.data!.docs;
                        var allChatUsers = ctr.filterChatList(data);
                        debugPrint("this is all chat${allChatUsers.length}");
                        return allChatUsers.length.isLowerThan(1)
                            ? const EmptyStateWidget(
                                shouldShowImage: false,
                                message: 'No recent matches',
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  children: [
                                    ...allChatUsers.map((users) {
                                      return InkWell(
                                        onTap: () async {
                                          Get.to(() =>
                                              ChatWithScreen(chatModel: users));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: CacheNetworkWidget(
                                            imgUrl: users.userModel!.photos![0],
                                            height: 50.r,
                                            width: 50.r,
                                            isNotCircle: false,
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
                        return allChatUsers
                                .where((val) => val.lastMessage.isNotEmpty)
                                .length
                                .isLowerThan(1)
                            ? SizedBox(
                                height: Get.height / 3,
                                child: const Center(
                                  child: EmptyStateWidget(
                                      shouldShowImage: false,
                                      message: 'No Chats Yet'),
                                ),
                              )
                            : ListView(
                                shrinkWrap: true,
                                children: [
                                  ...allChatUsers
                                      .where(
                                          (val) => val.lastMessage.isNotEmpty)
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
                                        Get.to(() =>
                                            ChatWithScreen(chatModel: val));
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

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FCMService.clearRedundantNotifs();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
