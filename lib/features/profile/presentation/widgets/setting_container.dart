import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';

class SettingsContainer extends StatelessWidget {
  final String text;
  final bool icon;
  final Function() onPress;
  const SettingsContainer({
    super.key,
    required this.text,
    required this.icon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15), color: grey),
        padding: EdgeInsets.all(12.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: textStyle16.copyWith(
                  fontWeight: FontWeight.w700, color: black),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: primary,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
