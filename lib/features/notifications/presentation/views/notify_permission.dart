import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Nexus/core/assets.dart';
import 'package:Nexus/core/size_boxes.dart';
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
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const Spacer(),
            SvgPicture.asset("$svgPath/bell.svg"),
            const SizedBoxH15(),
            Text("You haven’t received any notifications yet.",
                textAlign: TextAlign.center, style: textStyle14),
            const Spacer(),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
