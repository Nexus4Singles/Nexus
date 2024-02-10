import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus/chat/widget/chat_container.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/router.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Chats',
              style: textStyle18.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: black,
              ),
            ),
            const SizedBoxW40(),
            SvgPicture.asset(
              'assets/icons/adjust.svg',
            ),
          ],
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
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
              style: textStyle18.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBoxH15(),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primary,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/temi.png',
                  ),
                ),
                const SizedBoxW15(),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primary,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/mofe.png',
                  ),
                ),
                const SizedBoxW15(),
                Image.asset(
                  'assets/images/jessica.png',
                ),
                const SizedBoxW15(),
                Image.asset(
                  'assets/images/mariam.png',
                ),
              ],
            ),
            const SizedBoxH20(),
            Text(
              'Chats',
              style: textStyle18.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBoxH10(),
            TextButton(
              onPressed: () {
                Get.toNamed(
                  AppRoutes.chatWith,
                );
              },
              child: const ChatContainer(
                image: 'assets/images/mofesala.png',
                name: 'Mofesolamisi',
                time: '23 mins',
                text: 'Hi 👋, you good?',
                cont: '2',
              ),
            ),
            const SizedBoxH10(),
            const ChatContainer(
              image: 'assets/images/mofesala.png',
              name: 'Mofesolamisi',
              time: '23 mins',
              text: 'Hi 👋, you good?',
              cont: '2',
            ),
            const SizedBoxH10(),
            const ChatContainer(
              image: 'assets/images/mofesala.png',
              name: 'Sarah',
              time: '30 min',
              text: 'and what do you think about the idea ...',
              cont: '2',
            ),
            const SizedBoxH10(),
            const ChatContainer(
              image: 'assets/images/mofesala.png',
              name: 'Ashabi',
              time: '23 mins',
              text: 'Hello, i want to make enquireies ...',
              cont: '2',
            ),
            const SizedBoxH10(),
            const ChatContainer(
              image: 'assets/images/mofesala.png',
              name: 'Ashabi',
              time: '45 min',
              text: 'Hi 👋, you good?',
              cont: '2',
            ),
          ],
        ),
      ),
    );
  }
}
