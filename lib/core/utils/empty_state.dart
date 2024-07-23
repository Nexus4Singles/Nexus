import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';

import '../colors.dart';

class EmptyStateWidget extends StatelessWidget {
  final String svgAssetPath;
  final String message;
  final String buttonText;
  final bool shouldShowImage;
  final Function? buttonFunc;

  const EmptyStateWidget({
    Key? key,
    this.svgAssetPath = "",
    this.buttonText = '',
    this.shouldShowImage = true,
    this.buttonFunc,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.clear)),
            ),
            shouldShowImage
                ? SvgPicture.asset(
                    svgAssetPath.isEmpty ? "$svgPath/Empty.svg" : svgAssetPath,
                    height: 100, // Adjust size as needed
                    width: 100)
                : const SizedBox(),
            const SizedBoxH15(),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textStyle14.copyWith(color: dustyGrey),
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
      ),
    );
  }
}
