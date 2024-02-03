import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.settings);
              },
              child: CircleAvatar(
                radius: 25.r,
              ),
            ),
            const SizedBoxW10(),
            Text(
              'Hi Ayo 👋',
              style: headerStyle.copyWith(
                fontSize: 20.sp,
              ),
            )
          ],
        ),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.notification);
          },
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              const Icon(Iconsax.notification5),
              Positioned(
                top: -10,
                right: -5,
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  decoration: const BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '21',
                    textAlign: TextAlign.center,
                    style: textStyle10.copyWith(
                      color: white,
                      fontSize: 6.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
