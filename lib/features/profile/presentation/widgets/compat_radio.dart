import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus/core/colors.dart';
// import 'package:nexus/core/style.dart';

class CompatRadio extends StatelessWidget {
  final String val;
  final String groupVal;
  final Function(String?)? onChanged;

  const CompatRadio({
    super.key,
    required this.groupVal,
    required this.val,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.sp,
      child: RadioListTile(
        value: val,
        title: Text(
          val,
          style: GoogleFonts.sen(fontSize: 13),
          overflow: TextOverflow.ellipsis,
        ),
        contentPadding: const EdgeInsets.all(0),
        activeColor: primary,
        groupValue: groupVal,
        onChanged: onChanged,
      ),
    );
  }
}
