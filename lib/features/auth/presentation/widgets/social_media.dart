import 'package:flutter/material.dart';
import 'package:nexus/core/utils/helper.dart';
import 'package:nexus/core/size_boxes.dart';

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
          child: Image.asset(
            'assets/icons/fb.png',
          ),
        ),
        const SizedBoxW15(),
        InkWell(
          onTap: () {
            BaseHelper.launchBrowser('https://twitter.com/nexus4singles');
          },
          child: Image.asset(
            'assets/icons/x.png',
          ),
        ),
        const SizedBoxW15(),
        InkWell(
          onTap: () {
            BaseHelper.launchBrowser(
                'https://www.instagram.com/nexus4singles?igsh=N25rZWRoYmtpbGNv&utm_source=qr');
          },
          child: Image.asset(
            'assets/icons/instragram.png',
          ),
        ),
      ],
    );
  }
}
