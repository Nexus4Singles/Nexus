import 'package:flutter/material.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/style.dart';

class TextContainer extends StatelessWidget {
  final String text;

  const TextContainer({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        text,
        style: textStyle14.copyWith(
            color: white, fontWeight: FontWeight.w500, fontSize: 13),
      ),
    );
  }
}
