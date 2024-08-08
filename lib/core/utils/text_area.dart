import 'package:flutter/material.dart';

import '../colors.dart';
import '../style.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final int maxLines;
  final int minLines;
  final double height;
  final TextStyle? hintStyle;
  final double borderRadius;
  final Color? fillColor;
  final bool? isFilled;
  final Color? borderColor;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? padding;

  const CustomTextArea({
    Key? key,
    required this.controller,
    this.hintText = '',
    this.maxLines = 10,
    this.minLines = 5,
    this.height = 150.0,
    this.hintStyle,
    this.errorText,
    this.borderRadius = 16.0,
    this.fillColor = white,
    this.borderColor,
    this.isFilled = true,
    this.onChanged,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height,
        child: TextField(
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            hintStyle: textStyle14.copyWith(
              color: otherGrey,
              fontSize: 14,
            ),
            fillColor: fillColor,
            filled: isFilled,
            contentPadding: const EdgeInsets.all(15),
            border: outlineInputBorder.copyWith(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor ?? textBorderColor,
              ),
            ),
            enabledBorder: outlineInputBorder.copyWith(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor ?? textBorderColor,
              ),
            ),
            focusedBorder: outlineInputBorder.copyWith(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: textBorderColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
