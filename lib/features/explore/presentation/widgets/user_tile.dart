import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';

class ExploreUserTile extends StatelessWidget {
  final String name;
  final String location;
  final String age;
  final VoidCallback onPress;
  const ExploreUserTile({
    super.key,
    required this.name,
    required this.age,
    required this.location,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30.r,
            ),
            const SizedBoxW5(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name, $age',
                  style: textStyle16,
                ),
                const SizedBoxH5(),
                Row(
                  children: [
                    const Icon(
                      Iconsax.location5,
                      color: otherGrey,
                      size: 14,
                    ),
                    const SizedBoxW5(),
                    Text(
                      location,
                      style: textStyle12.copyWith(
                        color: otherGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          width: width(context) * .33,
          child: CustomButton(
            onPressed: () {},
            vPadding: 10,
            text: 'View Profile',
          ),
        ),
      ],
    );
  }
}
