import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/empty_state.dart';
import 'package:nexus/features/chat/controllers/chat_ctr.dart';
import 'package:nexus/features/chat/widget/chat_container.dart';
import 'package:nexus/features/subscription/helpers/subscription_helper.dart';
import 'package:nexus/features/subscription/provider/subscription_provider.dart';
import 'package:nexus/features/subscription/widgets/restriction_modal.dart';
import 'package:provider/provider.dart';
import '../../../router.dart';
import 'chat_rep.dart';

class ChatsScreen extends StatelessWidget {
  final ctr = ChatCtr.instance;

  ChatsScreen({super.key});
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
                        debugPrint("${allChatUsers.length}");
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              ...allChatUsers.map((users) {
                                var subProvider =
                                    Provider.of<SubscriptionProvider>(context);

                                return InkWell(
                                  onTap: () async {
                                    bool hasSentMessages = ctr.allChatUsers
                                        .where(
                                            (val) => val.lastMessage.isNotEmpty)
                                        .contains(users);
                                    if (hasSentMessages) {
                                      Get.to(() =>
                                          ChatWithScreen(chatModel: users));
                                      return;
                                    }
                                    if (subProvider.onPremium == true) {
                                      Get.to(() =>
                                          ChatWithScreen(chatModel: users));
                                    } else if (subProvider.onPremium == false &&
                                        subProvider.usedOneFreeText == false) {
                                      Get.to(() =>
                                          ChatWithScreen(chatModel: users));

                                      if (hasSentMessages) {
                                        subProvider.usedOneFreeText = true;
                                        await SubscriptionHelper
                                            .updateFreeTextStatus(
                                          subProvider.currentUser,
                                          true,
                                          context,
                                        );
                                      }
                                    } else if (subProvider.onPremium == false &&
                                        subProvider.usedOneFreeText == true &&
                                        subProvider.prevSubscribed == false) {
                                      restrictionModal(
                                        context: context,
                                        dismisable: true,
                                        text:
                                            'You have used up your limit of one (1) chat per matched \nuser on our free version.\nKindly subscribe to chat with other matched users.',
                                      );
                                    } else {
                                      restrictionModal(
                                        context: context,
                                        dismisable: true,
                                        text:
                                            'Your subscription has expired!\nKindly subscribe to be able to send messages\nand use other features.',
                                      );
                                    }
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
