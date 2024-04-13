import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';

class PrivacyItem extends StatelessWidget {
  final String title;
  final String desc;
  const PrivacyItem({
    super.key,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle14,
        ),
        const SizedBoxH5(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.sp, top: 5.sp),
              child: const Icon(
                Icons.circle,
                size: 8,
              ),
            ),
            const SizedBoxW10(),
            Expanded(
                child: Text(
              desc,
              style: textStyle14,
            )),
          ],
        ),
      ],
    );
  }
}
