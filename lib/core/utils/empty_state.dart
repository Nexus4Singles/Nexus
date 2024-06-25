import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/style.dart';

class EmptyStateWidget extends StatelessWidget {
  final String svgAssetPath;
  final String message;

  const EmptyStateWidget({
    Key? key,
    this.svgAssetPath = "",
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgAssetPath.isEmpty ? "$svgPath/Empty.svg" : svgAssetPath,
            height: 100, // Adjust size as needed
            width: 100,
          ),
          Text(
            message,
            style: textStyle18,
          ),
        ],
      ),
    );
  }
}
