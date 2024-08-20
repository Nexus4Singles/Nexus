import 'package:Nexus/core/services/fcm.dart';
import 'package:Nexus/features/home/presentation/widgets/cache_network_widget.dart';
import 'package:Nexus/features/match/presentation/widgets/matched_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/utils/empty_state.dart';
import 'package:Nexus/features/chat/controllers/chat_ctr.dart';
import 'package:Nexus/features/chat/widget/chat_container.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/features/subscription/helpers/subscription_helper.dart';
import 'package:Nexus/features/subscription/widgets/restriction_modal.dart';
import 'package:provider/provider.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import '../../../router.dart';
import '../../subscription/provider/subscription_provider.dart';
import 'chat_rep.dart';

class ChatsScreen extends StatefulWidget  {
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
        title: Text('Chats', style: textStyle18.copyWith(fontWeight: FontWeight.bold)),
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
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Matches',
                        style: textStyle18.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBoxH15(),
                      ctr.allChatUsers.isNotEmpty
                          ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            ...ctr.allChatUsers.map((users) {
                              return GestureDetector(
                                onTap: () async {
                                  Get.to(() => ChatWithScreen(chatModel: users));

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
                      )
                          : Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: Center(
                                  child: Text(
                                "You don’t have any matches yet",
                                style: textStyle14.copyWith(color: dustyGrey),
                              )),
                            ),
                      const SizedBoxH40(),
                      Text('Chats', style: textStyle18.copyWith(fontWeight: FontWeight.w800)),
                      const SizedBoxH10(),
                      ctr.allChatUsers.where((val) => val.lastMessage.isNotEmpty).isNotEmpty
                          ? ListView(
                              shrinkWrap: true,
                              children: [
                                ...ctr.allChatUsers
                                    .where((val) => val.lastMessage.isNotEmpty)
                                    .map((val) {
                                  return ChatContainer(
                                    image: val.userModel!.photos![0],
                                    name: val.userModel!.username,
                                    time: val.timestamp.toDate(),
                                    text: val.lastMessage,
                                    count: ctr.auth.currentUser!.uid == val.userSentLastMessage
                                        ? 0
                                        : val.unreadCount,
                                    onPress: () {
                                      Get.to(() => ChatWithScreen(chatModel: val));
                                    },
                                  );
                                }).toList(),
                              ],
                            )
                          : SizedBox(
                              height: Get.height / 2,
                              child: const Center(
                                child: EmptyStateWidget(
                                    shouldShowImage: false,
                                    message: 'You will see your chats here'),
                              ),
                            )
                    ],
                  ),
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
