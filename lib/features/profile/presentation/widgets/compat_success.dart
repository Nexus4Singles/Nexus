import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/colors.dart';
import '../../../../core/size_boxes.dart';
import '../../../../core/style.dart';

class CompatibilitySuccessful extends StatelessWidget {
  const CompatibilitySuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Iconsax.close_circle,
                  )),
            ],
          ),
          Text(
            'Compatibility Quiz',
            style: textStyle16.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBoxH15(),
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Text(
              'Thanks for your response!! \n\nThis will help people know more about their compatibility with you. You will also be able to request access to view their own responses, when you scroll down to the end of their profiles.',
              style: textStyle14.copyWith(
                color: black,
              ),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.all(10.sp),
          //   decoration: BoxDecoration(
          //     color: primary,
          //     borderRadius: BorderRadius.circular(20.r),
          //   ),
          //   child: Text(
          //     'Thanks for your response!! \n\nOnly matched users will be able to see your responses and you will be able to see theirs too.',
          //     style: textStyle14.copyWith(
          //       color: white,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
