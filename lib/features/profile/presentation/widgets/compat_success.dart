import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';

class CompatibilitySuccessful extends StatelessWidget {
  const CompatibilitySuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Thanks for your response!! \n\nOnly matched users will be able to see your responses and you will be able to see theirs too.',
              style: textStyle14.copyWith(
                color: white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
