import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/colors.dart';
import '../../../../core/style.dart';

class ExtraContainer extends StatelessWidget {
  final String text;
  final bool icon;
  const ExtraContainer({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: grey),
      padding: EdgeInsets.all(12.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style:
                textStyle16.copyWith(fontWeight: FontWeight.w700, color: black),
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: black,
            size: 16.sp,
          ),
        ],
      ),
    );
  }
}
