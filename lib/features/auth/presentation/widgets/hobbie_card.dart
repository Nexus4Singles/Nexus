import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/style.dart';

class HobbieCard extends StatelessWidget {
  final String text;
  final bool isChecked;
  final VoidCallback onPress;
  const HobbieCard({
    super.key,
    required this.text,
    required this.isChecked,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: isChecked ? primary : newGrey,
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.all(10.sp),
        child: Text(
          text,
          style: textStyle14.copyWith(
            color: isChecked ? white : black,
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
