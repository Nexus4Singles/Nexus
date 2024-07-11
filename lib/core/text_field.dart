import 'package:flutter/material.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool? obsecure;
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
  final bool? autoCorrect;
  final bool? isTextArea;
  final TextCapitalization textCapitalization;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obsecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.autoCorrect = false,
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
    this.isTextArea = false,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isTextArea! ? 200 : 54,
      decoration: BoxDecoration(
          color: widget.fillColor,
          border: Border.all(
            color: widget.borderColor ?? textBorderColor,
          ),
          borderRadius: BorderRadius.circular(widget.radius!)),
      child: TextFormField(
        enabled: widget.enabled,
        maxLength: widget.isTextArea! ? null : widget.maxLength,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingCompleted,
        controller: widget.controller,
        maxLines: null,
        minLines: widget.minLine,
        validator: widget.validator,
        textInputAction: widget.action,
        style: textStyle14,
        autocorrect: widget.autoCorrect!,
        textCapitalization: widget.textCapitalization,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // obscureText: widget.obsecure! ? true : false,
        decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            hintText: widget.hintText,
            isDense: true,
            isCollapsed: true,
            counter: const SizedBox(),
            hintStyle: textStyle14.copyWith(
              color: otherGrey,
              fontSize: 14,
            ),
            fillColor: widget.fillColor,
            filled: widget.isFilled,
            contentPadding: const EdgeInsets.all(15),
            border: outlineInputBorder.copyWith(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(widget.radius!),
            ),
            enabledBorder: outlineInputBorder.copyWith(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(widget.radius!),
            )),
      ),
    );
  }
}
