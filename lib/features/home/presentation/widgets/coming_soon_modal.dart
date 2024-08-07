import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/features/auth/presentation/widgets/social_media.dart';

class ComingSoonModal extends StatelessWidget {
  final String text;
  const ComingSoonModal({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Iconsax.clipboard5,
          size: 40.sp,
          color: primary,
        ),
        const SizedBoxH15(),
        Text(
          text,
          style: textStyle14,
          textAlign: TextAlign.center,
        ),
        const SizedBoxH15(),
        Text(
          'Follow us on social media to stay updated',
          style: textStyle14,
          textAlign: TextAlign.center,
        ),
        const SizedBoxH10(),
        const SocialMediaWidget(),
      ],
    );
  }
}
