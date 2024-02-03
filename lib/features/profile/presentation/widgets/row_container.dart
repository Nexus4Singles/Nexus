import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';

class RowContainer extends StatelessWidget {
  final String text;
  final String svg;

  const RowContainer({
    super.key,
    required this.text,
    required this.svg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style:
                textStyle16.copyWith(fontWeight: FontWeight.w700, color: black),
          ),
          const SizedBox(
            width: 90,
          ),
          SvgPicture.asset(svg)
        ],
      ),
    );
  }
}
