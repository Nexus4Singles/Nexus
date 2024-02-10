import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';

class ChatWithScreen extends StatefulWidget {
  const ChatWithScreen({super.key});

  @override
  State<ChatWithScreen> createState() => _ChatWithScreenState();
}

class _ChatWithScreenState extends State<ChatWithScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset('assets/images/mofesala.png'),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: green,
                    maxRadius: 5,
                  ),
                )
              ],
            ),
            const SizedBoxW20(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mofesolamisi',
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
                const SizedBoxW40(),
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    'assets/icons/adjust.svg',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  color: whiteblue,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: const Column(
                  children: [
                    Text('😊 I noticed we just matched . How are you \ndoing?'),
                  ],
                ),
              ),
            ),
            const SizedBoxH10(),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                '3:50 PM',
                style: textStyle12,
              ),
            ),
            const SizedBoxH10(),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: babyPink,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: const Column(
                  children: [
                    Text(
                        'Hello! Im doing well, thank you. Its \ngreat to connect with someone who \nshares the same faith. How about \nyou?'),
                  ],
                ),
              ),
            ),
            const SizedBoxH10(),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '3:50 PM',
                style: textStyle12,
              ),
            ),
            const SizedBoxH10(),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  color: whiteblue,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: const Column(
                  children: [
                    Text(
                        'Im good too, thanks! Yeah, its refreshing to\nfind someone who values their faith. So, \nwhat drew you to this app?'),
                  ],
                ),
              ),
            ),
            const SizedBoxH10(),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                '3:50 PM',
                style: textStyle12,
              ),
            ),
            const SizedBoxH10(),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: babyPink,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: const Column(
                  children: [
                    Text(
                        'Hello! Im doing well, thank you. Its \ngreat to connect with someone who \nshares the same faith. How about \nyou?'),
                  ],
                ),
              ),
            ),
            const SizedBoxH10(),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '3:50 PM',
                style: textStyle12,
              ),
            ),
            const SizedBoxH40(),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.send_rounded),
                      hintText: 'Send message',
                      hintStyle: textStyle14.copyWith(
                        color: otherGrey,
                        fontSize: 14,
                      ),
                      fillColor: black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: warGrey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: warGrey),
                      ),
                    ),
                  ),
                ),
                const SizedBoxW10(),
                Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: primary),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: const Icon(
                    Icons.add_box_rounded,
                    color: white,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
