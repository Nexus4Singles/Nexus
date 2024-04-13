import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nexus/core/style.dart';

class CampaTitle extends StatelessWidget {
  final String title;
  final String num;
  const CampaTitle({
    super.key,
    required this.title,
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$num. ',
          style: textStyle14.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: textStyle14.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
