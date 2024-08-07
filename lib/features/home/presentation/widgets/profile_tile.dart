import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/features/home/controllers/notification_controller.dart';
import 'package:Nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:Nexus/router.dart';

class ProfileTile extends StatelessWidget {
  final HomeNotifier model;
  const ProfileTile({
    super.key,
    required this.model,
  });

  int get notificationsLength =>
      NotificationController.instance.notifications.length;

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
                  : 'Hi ${model.currentUser!.username} 👋🏽',
              style: headerStyle.copyWith(
                fontSize: 20.sp,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
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
                      "$notificationsLength",
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
        ),
      ],
    );
  }
}
