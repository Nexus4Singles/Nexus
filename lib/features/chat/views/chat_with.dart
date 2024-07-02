// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:nexus/core/colors.dart';
// import 'package:nexus/core/models/chats_model.dart';
// import 'package:nexus/core/size_boxes.dart';
// import 'package:nexus/core/style.dart';
// import 'package:nexus/features/chat/controllers/chat_ctr.dart';
// import 'package:nexus/features/home/presentation/views/user_details.dart';
// import '../../../core/assets.dart';
// import '../../../core/models/message_model.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
//
// class ChatWithScreen extends StatefulWidget {
//   final ChatModel chatModel;
//   const ChatWithScreen({
//     super.key,
//     required this.chatModel,
//   });
//
//   @override
//   State<ChatWithScreen> createState() => _ChatWithScreenState();
// }
//
// class _ChatWithScreenState extends State<ChatWithScreen> {
//   var ctr = Get.put(ChatCtr());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           leadingWidth: 32,
//           title: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Get.to(() =>
//                       UserDetailScreen(userModel: widget.chatModel.userModel!));
//                 },
//                 child: CircleAvatar(
//                     backgroundImage:
//                         NetworkImage(widget.chatModel.userModel!.photos![0])),
//               ),
//               const SizedBoxW10(),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.chatModel.userModel!.username,
//                     style: textStyle14.copyWith(
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     'online',
//                     style: textStyle12,
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//             stream: ctr.getMyConversations(widget.chatModel.messageID),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return const Center(child: Text("No Message yet!."));
//               } else {
//                 var data = snapshot.data!.docs;
//                 final message = data
//                     .map((e) =>
//                         MessageModel.fromJson(e.data() as Map<String, dynamic>))
//                     .toList();
//                 // List<ChatMessage> messages = <ChatMessage>[];
//                 List<types.Message> messages = <types.Message>[];
//                 for (var element in message) {
//                   if (element.messageType == "image") {
//                     messages.add(types.ImageMessage(
//                         author: types.User(id: element.sentBy),
//                         id: element.id,
//                         createdAt:
//                             element.timestamp.toDate().millisecondsSinceEpoch,
//                         uri: element.media,
//                         name: element.message,
//                         size: 0));
//                   } else if (element.messageType == "Video") {
//                     messages.add(types.VideoMessage(
//                         createdAt:
//                             element.timestamp.toDate().millisecondsSinceEpoch,
//                         author: types.User(id: element.sentBy),
//                         id: element.id,
//                         uri: element.media,
//                         metadata: {'text': element.message},
//                         name: element.media,
//                         size: 0));
//                   } else {
//                     messages.add(types.TextMessage(
//                         author: types.User(id: element.sentBy),
//                         id: element.id,
//                         createdAt:
//                             element.timestamp.toDate().millisecondsSinceEpoch,
//                         text: element.message));
//                   }
//                 }
//                 return Chat(
//                     theme: DefaultChatTheme(
//                         sentMessageBodyTextStyle:
//                             textStyle14.copyWith(color: white),
//                         receivedMessageBodyTextStyle: textStyle14,
//                         inputTextStyle: textStyle14,
//                         inputPadding: EdgeInsets.zero,
//                         inputMargin: EdgeInsets.zero,
//                         inputTextColor: black,
//                         sendButtonIcon: CircleAvatar(
//                           backgroundColor: red,
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: SvgPicture.asset("$svgPath/send.svg"),
//                           ),
//                         ),
//                         sendButtonMargin: EdgeInsets.zero,
//                         inputTextDecoration: InputDecoration(
//                             hintText: "Send a message",
//                             hintStyle: const TextStyle(color: Colors.grey),
//                             prefixIcon: PopupMenuButton<Map<String, IconData>>(
//                               position: PopupMenuPosition.over,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12)),
//                               onSelected: (item) {},
//                               child: Obx(
//                                 () => Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: CircleAvatar(
//                                       backgroundColor: secondaryDark,
//                                       backgroundImage:
//                                           FileImage(ctr.imageFile.value),
//                                       child: ctr.imageFile.value.path.isEmpty
//                                           ? const Icon(
//                                               Icons.add_box_rounded,
//                                               color: Colors.white,
//                                             )
//                                           : const SizedBox()),
//                                 ),
//                               ),
//                               itemBuilder: (BuildContext context) {
//                                 return {
//                                   'Audio': Iconsax.microphone5,
//                                   'Video': Iconsax.video_add5,
//                                   'Image': Iconsax.image1,
//                                 }.entries.map((entry) {
//                                   return PopupMenuItem<Map<String, IconData>>(
//                                     value: {
//                                       entry.key: entry.value
//                                     }, // Map as value
//                                     textStyle:
//                                         textStyle14.copyWith(color: black),
//                                     child: InkWell(
//                                       onTap: () {
//                                         entry.key == "Image"
//                                             ? ctr.pickImage()
//                                             : entry.key == "Video"
//                                                 ? ctr.pickVideo()
//                                                 : ctr.pickVideo();
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(entry.value),
//                                           const SizedBox(width: 8),
//                                           Text(entry.key),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }).toList();
//                               },
//                               // ... rest of your code ...
//                             ),
//                             contentPadding: EdgeInsets.zero,
//                             filled: true,
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(100),
//                                 borderSide: const BorderSide(color: grey))),
//                         inputBackgroundColor: Colors.transparent,
//                         primaryColor: whiteblue,
//                         secondaryColor: babyPink),
//                     messages: messages,
//                     onAttachmentPressed: () {},
//                     onSendPressed: (message) {
//                       ctr.sendMessage(widget.chatModel.messageID, message.text);
//                     },
//                     user: types.User(id: ctr.auth.currentUser!.uid));
//               }
//             }));
//   }
// }
//
// // DashChat(
// //                   currentUser: ChatUser(id: ctr.auth.currentUser!.uid),
// //                   inputOptions: InputOptions(
// //                       textInputAction: TextInputAction.newline,
// //                       alwaysShowSend: true,
// //                       sendButtonBuilder: (val) {
// //                         return InkWell(
// //                           onTap: val,
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(8.0),
// //                             child: CircleAvatar(
// //                               backgroundColor: primary,
// //                               child: SvgPicture.asset("$svgPath/send.svg"),
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                       inputDecoration: InputDecoration(
// //                           hintText: "Send a message",
// //                           hintStyle: const TextStyle(color: Colors.grey),
// //                           prefixIcon: PopupMenuButton<Map<String, IconData>>(
// //                             position: PopupMenuPosition.over,
// //                             shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(12)),
// //                             onSelected: (item) {},
// //                             child: Obx(
// //                               () => Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: CircleAvatar(
// //                                     backgroundColor: primary,
// //                                     backgroundImage:
// //                                         FileImage(ctr.imageFile.value),
// //                                     child: ctr.imageFile.value.path.isEmpty
// //                                         ? const Icon(
// //                                             Icons.add_box_rounded,
// //                                             color: Colors.white,
// //                                           )
// //                                         : const SizedBox()),
// //                               ),
// //                             ),
// //                             itemBuilder: (BuildContext context) {
// //                               return {
// //                                 'Audio': Iconsax.microphone5,
// //                                 'Video': Iconsax.video_add5,
// //                                 'Image': Iconsax.image1,
// //                               }.entries.map((entry) {
// //                                 return PopupMenuItem<Map<String, IconData>>(
// //                                   value: {
// //                                     entry.key: entry.value
// //                                   }, // Map as value
// //                                   textStyle: textStyle14.copyWith(color: black),
// //                                   child: InkWell(
// //                                     onTap: () {
// //                                       entry.key == "Image"
// //                                           ? ctr.pickImage()
// //                                           : entry.key == "Video"
// //                                               ? ctr.pickVideo()
// //                                               : ctr.pickVideo();
// //                                     },
// //                                     child: Row(
// //                                       children: [
// //                                         Icon(entry.value),
// //                                         const SizedBox(width: 8),
// //                                         Text(entry.key),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 );
// //                               }).toList();
// //                             },
// //                             // ... rest of your code ...
// //                           ),
// //                           contentPadding: EdgeInsets.zero,
// //                           filled: true,
// //                           border: OutlineInputBorder(
// //                               borderRadius: BorderRadius.circular(100),
// //                               borderSide: const BorderSide(color: grey)))),
// //                   messageOptions: MessageOptions(
// //                       onLongPressMessage: (message) {
// //                         openModal(context, message);
// //                       },
// //                       showOtherUsersAvatar: false,
// //                       containerColor: babyPink,
// //                       currentUserContainerColor: whiteblue),
// //                   onSend: (ChatMessage message) {
// //                     ctr.sendMessage(widget.chatModel.messageID, message.text);
// //                   },
// //                   messages: messages,
// //                 );
//
// var listOfOptions = [
//   CupertinoActionSheetAction(
//     child: const Text('Action 1'),
//     onPressed: () {
//       // Navigator.pop(context);
//       print('Action 1 selected');
//     },
//   ),
//   CupertinoActionSheetAction(
//     child: const Text('Action 2'),
//     onPressed: () {
//       // Navigator.pop(context);
//       print('Action 2 selected');
//     },
//   ),
//   const Text("")
// ];
