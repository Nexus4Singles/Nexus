import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';

class ProfileDropDown extends StatelessWidget {
  final List<String> items;
  final String val;
  final String hintText;
  final Function(String?) onChanged;
  const ProfileDropDown({
    super.key,
    required this.items,
    required this.val,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      onChanged: onChanged,
      hint: Text(
        hintText,
        style: textStyle14.copyWith(color: otherGrey),
      ),
      value: val.isNotEmpty ? val : null,
      // validator: (value) => value == null ? 'field required' : null,
      isDense: true,
      style: textStyle14,
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(
            value,
            overflow: TextOverflow.clip,
            style: textStyle14.copyWith(
              color: black,
            ),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: red, width: 1.5),
        ),
        hintText: 'Choose reason',
        isDense: true,
        hintStyle: textStyle14.copyWith(
          color: otherGrey,
          fontSize: 14.sp,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.sp,
          vertical: 10.sp,
        ),
        filled: true,
        fillColor: const Color(0xffD6D6D6),
        border: outlineInputBorder.copyWith(
            borderRadius: BorderRadius.circular(10.r)),
        enabledBorder: outlineInputBorder.copyWith(
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: outlineInputBorder.copyWith(
            borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}
