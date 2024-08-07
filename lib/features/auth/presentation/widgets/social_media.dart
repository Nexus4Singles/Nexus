import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Nexus/core/assets.dart';
import 'package:Nexus/core/utils/helper.dart';
import 'package:Nexus/core/size_boxes.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            BaseHelper.launchBrowser(
                'https://www.facebook.com/nexusgodlydatingapp?mibextid=kFxxJD');
          },
          child: SvgPicture.asset(
            '$svgPath/fb.svg',
            width: 32,
            color: const Color(0xff1877F2),
          ),
        ),
        const SizedBoxW15(),
        InkWell(
          onTap: () {
            BaseHelper.launchBrowser('https://twitter.com/nexus4singles');
          },
          child: SvgPicture.asset(
            '$svgPath/x.svg',
            width: 32,
          ),
        ),
        const SizedBoxW15(),
        InkWell(
          onTap: () {
            BaseHelper.launchBrowser(
                'https://www.instagram.com/nexus4singles?igsh=N25rZWRoYmtpbGNv&utm_source=qr');
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
