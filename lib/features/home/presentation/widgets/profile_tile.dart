import 'package:Nexus/features/home/presentation/change_notifier/bottom_nav.dart';
import 'package:Nexus/features/home/presentation/widgets/cache_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../../../core/size_boxes.dart';
import '../../../../core/style.dart';
import '../../../../router.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/notification_controller.dart';

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
                Provider.of<BottomNavModel>(context, listen: false).jumpToNavPage(4);
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
