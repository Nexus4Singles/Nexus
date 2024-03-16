import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';

class NoFilterWidget extends StatelessWidget {
  const NoFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/oops.png',
        ),
        const SizedBoxH20(),
        Text(
          'There are currently no profile matching your request!',
          style: headerStyle.copyWith(fontSize: 14.sp),
        ),
        const SizedBoxH20(),
        Text(
          'Go to filters to change search options',
          style: textStyle14.copyWith(
            color: otherGrey,
          ),
        ),
        const SizedBoxH20(),
        CustomButton(
          onPressed: () {},
          text: 'Go to Filters',
        ),
      ],
    );
  }
}
