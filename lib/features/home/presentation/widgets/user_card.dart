import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';

class UserCard extends StatelessWidget {
  final String image;
  final String name;
  final String age;
  final String location;
  final VoidCallback onRefresh;
  final VoidCallback onClosed;
  final VoidCallback onLike;
  final VoidCallback onSaved;
  final VoidCallback onClick;
  const UserCard({
    super.key,
    required this.name,
    required this.location,
    required this.age,
    required this.image,
    required this.onClosed,
    required this.onLike,
    required this.onRefresh,
    required this.onSaved,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: height(context) * .68,
        width: width(context),
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            boxShadow,
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height(context) * .55,
              width: width(context),
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                  opacity: .4,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name, $age',
                    style: headerStyle.copyWith(
                      fontSize: 30.sp,
                      color: white,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.location5,
                        color: white,
                      ),
                      const SizedBoxW10(),
                      Text(
                        location,
                        style: textStyle16.copyWith(
                          color: white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(11.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: onRefresh,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primary)),
                      child: SvgPicture.asset(
                        '$svgPath/back.svg',
                        width: 24,
                        color: primary.withOpacity(0.6),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onClosed,
                    child: SvgPicture.asset(
                      'assets/icons/close.svg',
                    ),
                  ),
                  InkWell(
                    onTap: onLike,
                    child: SvgPicture.asset(
                      'assets/icons/fav.svg',
                    ),
                  ),
                  InkWell(
                    onTap: onSaved,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primary)),
                      child: SvgPicture.asset(
                        '$svgPath/bookmark.svg',
                        width: 24,
                        color: primary.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
