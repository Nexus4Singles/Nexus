import 'package:Nexus/features/chat/widget/block_user_modal.dart';
import 'package:Nexus/features/subscription/helpers/subscription_helper.dart';
import 'package:Nexus/features/home/presentation/widgets/cache_network_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:Nexus/core/assets.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/models/chats_model.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/modals.dart';
import 'package:Nexus/features/chat/controllers/chat_ctr.dart';
import 'package:Nexus/features/home/presentation/views/user_details.dart';
import 'package:provider/provider.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/message_model.dart';
import '../../../core/services/fcm.dart';
import '../../home/presentation/views/photo_view.dart';
import '../../subscription/provider/subscription_provider.dart';
import '../../subscription/widgets/restriction_modal.dart';

class ChatWithScreen extends StatefulWidget {
  final ChatModel chatModel;

  const ChatWithScreen({
    super.key,
    required this.chatModel,
  });

  @override
  State<ChatWithScreen> createState() => _ChatWithScreenState();
}

class _ChatWithScreenState extends State<ChatWithScreen>
    with WidgetsBindingObserver {
  var ctr = ChatCtr.instance;

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initChatState();
      logger.i('updated from chatscreen on init');

      FCMService.clearNotificationsForConversation(widget.chatModel.messageID);
      if (ctr.exploreCtr.myProfile.value.usersChatWarning == null) {
        chatWarningModal(context);
        ctr.setUserToHaveShowWarning(widget.chatModel.userModel!.id);
      } else {
        if (!ctr.exploreCtr.myProfile.value.usersChatWarning!
            .contains(widget.chatModel.userModel!.id)) {
          chatWarningModal(context);
          ctr.setUserToHaveShowWarning(widget.chatModel.userModel!.id);
        }
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('activeChatUserId', '');
    logger.i('cleared from chatscreen on dispose');
    _textController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // When the app resumes, ensure the chat state is updated
      logger.i('lifecycle-> resumed');
      await _initChatState();
      logger.i('updated from chatscreen on resume');
    }
  }

  Future<void> _initChatState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('activeChatUserId', widget.chatModel.userModel!.id);
    final usrId = prefs.getString('activeChatUserId');
    logger.i('Active chat user ID set to: $usrId');
  }

  @override
  Widget build(BuildContext context) {
    final subProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    var myProfile = ctr.exploreCtr.myProfile.value;

    final isUserBlocked =
        widget.chatModel.userModel?.blocked?.contains(myProfile.id) ?? false;
    final isIBlockedUser =
        myProfile.blocked?.contains(widget.chatModel.userModel?.id) ?? false;

    final isBlocked = isUserBlocked || isIBlockedUser;

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
              child: const Icon(Icons.more_vert_rounded),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.r),
                    ),
                  ),
                  showDragHandle: true,
                  builder: (context) {
                    return BlockUserModal(chatModel: widget.chatModel);
                  },
                );
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
                child: CacheNetworkWidget(
                                  imgUrl: widget.chatModel.userModel!.photos != null &&
                                          widget.chatModel.userModel!.photos!.isNotEmpty
                                      ? widget.chatModel.userModel!.photos![0]
                                      : 'https://i.pinimg.com/474x/76/68/4a/76684ac1fccf120998c15dcc094a07ad.jpg',
                  height: 40,
                  width: 40,
                  isNotCircle: false,
                ),
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
        body: isBlocked
            ? const Center(
                child: Text("Blocked!!!"),
              )
            : StreamBuilder<QuerySnapshot>(
                stream: ctr.getMyConversations(widget.chatModel.messageID),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text("No Message yet!."));
                  } else {
                    var data = snapshot.data!.docs;
                    final message = data
                        .map((e) => MessageModel.fromJson(
                            e.data() as Map<String, dynamic>))
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
                        textController: _textController,
                        textInputAction: TextInputAction.newline,
                        alwaysShowSend: true,
                        textCapitalization: TextCapitalization.sentences,
                        sendButtonBuilder: (val) {
                          return InkWell(
                            onTap: () {
                              // Trigger the send action with current message
                              var message = ChatMessage(
                                text: _textController.text,
                                customProperties: {},
                                medias: [],
                                user: ChatUser(
                                    id: ctr.auth.currentUser!.uid,
                                    profileImage: ""),
                                createdAt: DateTime.now(),
                              );
                              // handle sending or restrictions
                              if (subProvider.isRestricted == true) {
                                restrictionModal(
                                    context: context,
                                    dismisable: true,
                                    showButton: false,
                                    text: 'Your'
                                        ' device is already linked to an active subscription. Please log in to Google Play Store Account/Apple ID account associated to your subscription &\nRestart the app then head to Settings -> '
                                        'Your Subscription -> Restore Subscription.');
                              } else {
                                _handleSendMessage(message, subProvider);
                              }
                            },
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
                              borderRadius: BorderRadius.circular(12),
                            ),
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
                            borderSide: const BorderSide(color: grey),
                          ),
                        ),
                      ),
                      messageOptions: MessageOptions(
                        onLongPressMessage: (message) {
                          if (widget.chatModel.userModel!.id ==
                              message.user.id) {
                          } else {
                            openModal(context, message);
                          }
                        },
                        onTapMedia: (media) {
                          if (media.type == MediaType.image) {
                            Get.to(() => PhotoViewScreen(
                                  selectedIndex: 0,
                                  photos: [media.url],
                                ));
                          }
                        },
                        showOtherUsersAvatar: false,
                        containerColor: babyPink,
                        currentUserContainerColor: whiteblue,
                      ),
                      onSend: (ChatMessage message) {
                        // Handle sending or showing restriction modal
                        if (subProvider.isRestricted == true) {
                          restrictionModal(
                              context: context,
                              dismisable: true,
                              showButton: false,
                              text: 'Please'
                                  ' log in or switch to the Google Play Store Account/Apple ID account associated to your subscription &\nRestart the app then head to Settings -> '
                                  'Your Subscription -> Restore Subscription.');
                        } else {
                          _handleSendMessage(message, subProvider);
                        }
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

  void _handleSendMessage(
    ChatMessage message,
    SubscriptionProvider subProvider,
  ) async {
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
          subProvider.entitledUser != widget.chatModel.userModel?.id) {
        restrictionModal(
          context: context,
          dismisable: true,
          text:
              'You have used up your limit of one (1) chat per matched user on our free version.\nKindly subscribe to chat with other matched users.',
        );
        return;
      }
    }

    // If the user is allowed to send a message (premium or within the allowed free text)
    ctr.sendMessage(
        widget.chatModel.messageID, message.text, widget.chatModel.userModel!);
    _textController.text = '';

    // If the user is using their one free text, update the status
    if (!subProvider.usedOneFreeText && !subProvider.prevSubscribed) {
      subProvider.usedOneFreeText = true;
      subProvider.entitledUser = widget.chatModel.userModel?.id;
      await SubscriptionHelper.updateFreeTextStatus(
        subProvider.currentUser,
        true,
        context,
        widget.chatModel.userModel?.id,
      );
    }
  }
}
