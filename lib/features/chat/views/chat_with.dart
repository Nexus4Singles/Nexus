import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/models/chats_model.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/chat/controllers/chat_ctr.dart';

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
              CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.chatModel.userModel!.photos![0])),
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
                  inputOptions: InputOptions(),
                  messageOptions: const MessageOptions(
                      showOtherUsersAvatar: false,
                      containerColor: babyPink,
                      currentUserContainerColor: whiteblue),
                  onSend: (ChatMessage message) {},
                  messages: messages,
                );
              }
            }));
  }
}

// Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: whiteblue,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: const Column(
//                   children: [
//                     Text('😊 I noticed we just matched . How are you \ndoing?'),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBoxH10(),
//             Align(
//               alignment: Alignment.topRight,
//               child: Text(
//                 '3:50 PM',
//                 style: textStyle12,
//               ),
//             ),
//             const SizedBoxH10(),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: babyPink,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: const Column(
//                   children: [
//                     Text(
//                         'Hello! Im doing well, thank you. Its \ngreat to connect with someone who \nshares the same faith. How about \nyou?'),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBoxH10(),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Text(
//                 '3:50 PM',
//                 style: textStyle12,
//               ),
//             ),
//             const SizedBoxH10(),
//             Align(
//               alignment: Alignment.topRight,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: whiteblue,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: const Column(
//                   children: [
//                     Text(
//                         'Im good too, thanks! Yeah, its refreshing to\nfind someone who values their faith. So, \nwhat drew you to this app?'),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBoxH10(),
//             Align(
//               alignment: Alignment.topRight,
//               child: Text(
//                 '3:50 PM',
//                 style: textStyle12,
//               ),
//             ),
//             const SizedBoxH10(),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: babyPink,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: const Column(
//                   children: [
//                     Text(
//                         'Hello! Im doing well, thank you. Its \ngreat to connect with someone who \nshares the same faith. How about \nyou?'),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBoxH10(),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Text(
//                 '3:50 PM',
//                 style: textStyle12,
//               ),
//             ),
//             const SizedBoxH40(),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       suffixIcon: const Icon(Icons.send_rounded),
//                       hintText: 'Send message',
//                       hintStyle: textStyle14.copyWith(
//                         color: otherGrey,
//                         fontSize: 14,
//                       ),
//                       fillColor: black,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                         borderSide: const BorderSide(color: warGrey),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                         borderSide: const BorderSide(color: warGrey),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBoxW10(),
//                 Container(
//                   decoration: const BoxDecoration(
//                       shape: BoxShape.circle, color: primary),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                   child: const Icon(
//                     Icons.add_box_rounded,
//                     color: white,
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
