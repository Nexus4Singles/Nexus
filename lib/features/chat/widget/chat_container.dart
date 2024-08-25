import 'package:Nexus/features/home/presentation/widgets/cache_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/colors.dart';
import '../../../core/style.dart';

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
        leading: CacheNetworkWidget(
          imgUrl: image,
          height: 48,
          width: 48,
          isNotCircle: false,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: textStyle12, overflow: TextOverflow.ellipsis),
            Container(
              padding: const EdgeInsets.only(right: 20),
              child: count.isGreaterThan(0)
                  ? CircleAvatar(
                      radius: 12,
                      backgroundColor: red,
                      child: Text(
                        '$count',
                        style: textStyle12.copyWith(color: Colors.white),
                      ),
                    )
                  : const SizedBox(),
            ),
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
