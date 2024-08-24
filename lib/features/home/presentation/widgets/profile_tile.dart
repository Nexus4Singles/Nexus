import 'package:Nexus/features/home/presentation/widgets/cache_network_widget.dart';
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

import '../../controllers/home_controller.dart';

class ProfileTile extends StatelessWidget {
  ProfileTile({super.key});

  int get notificationsLength => NotificationController.instance.notifications.length;

  final model = HomeController.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.editProfile);
              },
              child: CacheNetworkWidget(
                height: 50.r,
                width: 50.r,
                imgUrl: model.user.value.profileUrl ?? "",
                isNotCircle: false,
              ),
            ),
            const SizedBoxW10(),
            Text(
              'Hi ${model.user.value.username} 👋🏽',
              style: headerStyle.copyWith(
                fontSize: 20.sp,
              ),
            )
          ],
        ),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.settings);
          },
          child: const Icon(
            Iconsax.setting_4,
          ),
        ),
      ],
    );
  }
}
