import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/size_boxes.dart';

import '../../../../core/colors.dart';
import '../../../../core/style.dart';

class NotifyPermission extends StatelessWidget {
  const NotifyPermission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Notifications',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("$svgPath/notify.svg"),
          const SizedBoxH15(),
          Text("Enable Notifications",
              style: textStyle18.copyWith(
                  fontSize: 24, fontWeight: FontWeight.w600)),
          const SizedBoxH5(),
          Text(
              "Get push-notifications when you get a match or receive a message",
              textAlign: TextAlign.center,
              style: textStyle14),
          const SizedBoxH15(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              onPressed: () {},
              text: "I want to be notified",
            ),
          )
        ],
      ),
    );
  }
}
