import 'package:flutter/material.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';

class CustomTextFieldPassword extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obsecure;
  final bool? readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool? isMulti;
  final bool? autofocus;
  final bool? enabled;
  final String? errorText;
  final String? label;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? minLine;
  final int? maxLength;
  final double? radius;
  final TextInputAction? action;
  final Color? borderColor;
  final Color? fillColor;
  final bool? isFilled;
  const CustomTextFieldPassword({
    Key? key,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.obsecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    this.label,
    this.maxLength,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.minLine,
    this.radius = 16,
    this.action,
    this.borderColor,
    this.fillColor = white,
    this.isFilled = true,
  }) : super(key: key);

  @override
  CustomTextFieldPasswordState createState() => CustomTextFieldPasswordState();
}

class CustomTextFieldPasswordState extends State<CustomTextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    // bool isDark = Provider.of<ThemeProvider>(context, listen: true).isDark;
    return TextFormField(
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingCompleted,
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: widget.action,
      style: textStyle14,
      obscureText: widget.obsecure,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        hintStyle: textStyle14.copyWith(
          color: otherGrey,
          fontSize: 14,
        ),
        fillColor: widget.fillColor,
        filled: widget.isFilled,
        contentPadding: const EdgeInsets.all(15),
        border: outlineInputBorder.copyWith(
          borderRadius: BorderRadius.circular(widget.radius!),
          borderSide: const BorderSide(
            color: textBorderColor,
          ),
        ),
        enabledBorder: outlineInputBorder.copyWith(
          borderRadius: BorderRadius.circular(widget.radius!),
          borderSide: const BorderSide(
            color: textBorderColor,
          ),
        ),
        focusedBorder: outlineInputBorder.copyWith(
          borderRadius: BorderRadius.circular(widget.radius!),
          borderSide: const BorderSide(
            color: textBorderColor,
          ),
        ),
      ),
    );
  }
}
