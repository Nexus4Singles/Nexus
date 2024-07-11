import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:nexus/core/style.dart';
import '../../../core/colors.dart';

class ChatContainer extends StatelessWidget {
  final String image;
  final String name;
  final DateTime time;
  final String text;
  final int count;
  final VoidCallback onPress;
  const ChatContainer({
    super.key,
    required this.image,
    required this.name,
    required this.time,
    required this.text,
    required this.count,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(image),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: textStyle12, overflow: TextOverflow.ellipsis),
            count.isGreaterThan(0)
                ? Padding(
                    padding: const EdgeInsets.only(right: 12.0, bottom: 2),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: red,
                      child: Text(
                        '$count',
                        style: textStyle12.copyWith(
                            color: Colors.white, fontSize: 10),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        contentPadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: textStyle14.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(DateFormat.jm().format(time).capitalizeFirst!,
                style: textStyle12),
          ],
        ),
      ),
    );
  }
}
