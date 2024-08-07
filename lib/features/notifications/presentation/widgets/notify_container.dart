import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';

class NotifyContainer extends StatelessWidget {
  final String image;
  final String text1;
  final String text2;
  const NotifyContainer({
    super.key,
    required this.image,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: white),
      padding: const EdgeInsets.symmetric(),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              image,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBoxW10(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: textStyle14.copyWith(
                    fontWeight: FontWeight.w600, color: black),
              ),
              Text(
                text2,
                style: textStyle12.copyWith(color: black),
              )
            ],
          )
        ],
      ),
    );
  }
}
