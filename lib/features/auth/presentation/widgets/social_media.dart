import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/assets.dart';
import '../../../../core/size_boxes.dart';
import '../../../../core/utils/helper.dart';

class SocialMediaWidget extends StatelessWidget {
  final bool? showOnlyInstagram;

  const SocialMediaWidget({
    super.key,
    this.showOnlyInstagram = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: showOnlyInstagram == true
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        showOnlyInstagram == true
            ? const SizedBox.shrink()
            : InkWell(
                onTap: () {
                  BaseHelper.launchBrowser(
                    'https://www.facebook.com/nexusgodlydatingapp?mibextid=kFxxJD',
                  );
                },
                child: SvgPicture.asset(
                  '$svgPath/fb.svg',
                  width: 32,
                  color: const Color(0xff1877F2),
                ),
              ),
        showOnlyInstagram == true
            ? const SizedBox.shrink()
            : const SizedBoxW15(),
        showOnlyInstagram == true
            ? const SizedBox.shrink()
            : InkWell(
                onTap: () {
                  BaseHelper.launchBrowser(
                    'https://twitter.com/nexus4singles',
                  );
                },
                child: SvgPicture.asset(
                  '$svgPath/x.svg',
                  width: 32,
                ),
              ),
        showOnlyInstagram == true
            ? const SizedBox.shrink()
            : const SizedBoxW15(),
        InkWell(
          onTap: () {
            BaseHelper.launchBrowser(
              'https://www.instagram.com/nexus4singles?igsh=N25rZWRoYmtpbGNv&utm_source=qr',
            );
          },
          child: SvgPicture.asset(
            '$svgPath/ig.svg',
            width: 32,
          ),
        ),
      ],
    );
  }
}
