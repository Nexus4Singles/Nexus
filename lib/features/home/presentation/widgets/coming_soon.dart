import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/features/home/presentation/widgets/coming_soon_modal.dart';

class ComingSoonWidget extends StatelessWidget {
  final String text;
  const ComingSoonWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * .8,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: iconGrey)),
      child: ComingSoonModal(
        text: text,
      ),
    );
  }
}
