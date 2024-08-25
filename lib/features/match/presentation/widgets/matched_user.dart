import 'package:Nexus/features/home/presentation/widgets/cache_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';

class MatchedUserCard extends StatelessWidget {
  final String age;
  final String name, photo;
  final String location;
  final VoidCallback onPress;
  const MatchedUserCard({
    super.key,
    required this.name,
    required this.photo,
    required this.age,
    required this.onPress,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: CacheNetworkWidget(
        imgUrl: photo,
        height: 317.h,
        opacity: 0.8,
        color: black,
        borderRadius: BorderRadius.circular(15.r),
        child: Padding(
          padding: EdgeInsets.all(15.sp),
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
                  Flexible(
                    child: Text(
                      location,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle12.copyWith(
                        color: white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
