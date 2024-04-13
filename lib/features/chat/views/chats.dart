import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nexus/features/chat/widget/chat_container.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/features/home/presentation/widgets/coming_soon.dart';

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
          ],
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: .2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
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
                  const SizedBoxH20(),
                  ChatContainer(
                    image: 'assets/images/mofesala.png',
                    name: 'Mofesolamisi',
                    time: '23 mins',
                    text: 'Hi 👋, you good?',
                    cont: '2',
                    onPress: () {
                      // Get.toNamed(AppRoutes.chatWith);
                    },
                  ),
                  const SizedBoxH20(),
                  ChatContainer(
                    image: 'assets/images/mofesala.png',
                    name: 'Mofesolamisi',
                    time: '23 mins',
                    text: 'Hi 👋, you good?',
                    cont: '2',
                    onPress: () {
                      // Get.toNamed(AppRoutes.chatWith);
                    },
                  ),
                  const SizedBoxH20(),
                  ChatContainer(
                    image: 'assets/images/mofesala.png',
                    name: 'Sarah',
                    time: '30 min',
                    text: 'and what do you think about the idea ...',
                    cont: '2',
                    onPress: () {
                      // Get.toNamed(AppRoutes.chatWith);
                    },
                  ),
                ],
              ),
            ),
          ),
          const ComingSoonWidget(
            text:
                'You will be able to chat with your MATCH list here as soon as we launch',
          )
        ],
      ),
    );
  }
}
