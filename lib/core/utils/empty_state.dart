import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';

class EmptyStateWidget extends StatelessWidget {
  final String svgAssetPath;
  final String message;
  final String buttonText;
  final Function? buttonFunc;

  const EmptyStateWidget({
    Key? key,
    this.svgAssetPath = "",
    this.buttonText = '',
    this.buttonFunc,
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
            textAlign: TextAlign.center,
            style: textStyle14,
          ),
          const SizedBoxH20(),
          buttonText.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: CustomButton(
                      onPressed: () {
                        buttonFunc!();
                      },
                      text: buttonText,
                      borderRadius: 100),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
