import 'package:Nexus/features/home/presentation/widgets/cache_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';

class ExploreUserTile extends StatelessWidget {
  final String name;
  final String location;
  final String age;
  final String image;
  final VoidCallback onPress;
  const ExploreUserTile({
    super.key,
    required this.name,
    required this.age,
    required this.location,
    required this.onPress,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CacheNetworkWidget(
        imgUrl: image,
        color: altoGrey,
        height: 48.r,
        width: 48.r,
        isNotCircle: false,
      ),
      onTap: onPress,
      contentPadding: EdgeInsets.zero,
      title: Text('$name, $age', style: textStyle16),
      subtitle: Row(
        children: [
          const Icon(
            Iconsax.location5,
            color: otherGrey,
            size: 14,
          ),
          const SizedBoxW5(),
          Flexible(
            child: SizedBox(
              width: Get.width / 3,
              child: Text(
                location,
                overflow: TextOverflow.ellipsis,
                style: textStyle12.copyWith(color: otherGrey),
              ),
            ),
          ),
        ],
      ),
      trailing: InkWell(
        onTap: onPress,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(100)),
          child: Text(
            "View Profile",
            style: textStyle10.copyWith(color: white),
          ),
        ),
      ),
    );
  }
}
