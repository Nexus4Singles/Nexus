import 'package:flutter/material.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';

class ChatContainer extends StatelessWidget {
  final String image;
  final String name;
  final String time;
  final String text;
  final String cont;
  const ChatContainer(
      {super.key,
      required this.image,
      required this.name,
      required this.time,
      required this.text,
      required this.cont});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: white,
      ),
      padding: const EdgeInsets.symmetric(),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(image),
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
            ],
          ),
          SizedBoxW10(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: textStyle14.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    time,
                    style: textStyle12.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: textStyle12.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: primary),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      cont,
                      style: textStyle12.copyWith(color: white),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
