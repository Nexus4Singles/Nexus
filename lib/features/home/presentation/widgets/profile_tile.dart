import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:nexus/router.dart';

class ProfileTile extends StatelessWidget {
  final HomeNotifier model;
  const ProfileTile({
    super.key,
    required this.model,
  });

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
                backgroundImage: NetworkImage(
                  model.currentUser!.profileUrl!,
                ),
              ),
            ),
            const SizedBoxW10(),
            Text(
              model.currentUser == null
                  ? 'Hi'
                  : 'Hi ${model.currentUser!.username} 👋',
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
