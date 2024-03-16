import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
// import 'package:nexus/core/utils/device.dart';

class MatchedUserCard extends StatelessWidget {
  final String age;
  final String name;
  final String location;
  final VoidCallback onPress;
  const MatchedUserCard({
    super.key,
    required this.name,
    required this.age,
    required this.onPress,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width(context) * .45,
      padding: EdgeInsets.all(15.sp),
      height: 317.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: black,
        image: const DecorationImage(
          fit: BoxFit.cover,
          opacity: .8,
          image: AssetImage(
            'assets/images/user1.png',
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '$name, $age',
            style: textStyle16.copyWith(
              color: white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              const Icon(
                Iconsax.location5,
                color: white,
                size: 14,
              ),
              const SizedBoxW5(),
              Text(
                location,
                style: textStyle12.copyWith(
                  color: white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
