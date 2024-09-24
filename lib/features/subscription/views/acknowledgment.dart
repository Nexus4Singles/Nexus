import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import '../../../core/assets.dart';
import '../../../core/style.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile/presentation/views/change_plan.dart';
import '../helpers/subscription_helper.dart';

class AcknowledgmentScreen extends StatefulWidget {
  const AcknowledgmentScreen({super.key});

  @override
  State<AcknowledgmentScreen> createState() => _AcknowledgmentScreenState();
}

class _AcknowledgmentScreenState extends State<AcknowledgmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Color(0xffF7F7F7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("$svgPath/acknowledgement.svg",
                height: 100, // Adjust size as needed
                width: 100),
            const SizedBoxH20(),
            Text(
              'Congratulations!!!',
              style: textStyle18.copyWith(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBoxH20(),
            Text(
              'Your subscription was successful!\nThe app will relaunch automatically for your subscription to be activated!',
              textAlign: TextAlign.center,
              style: textStyle18.copyWith(fontSize: 14, height: 2),
            ),
            const SizedBoxH20(),
            CustomButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePlanScreen()));
              },
              text: 'View Subscription',
            ),
          ],
        ),
      ),
    );
  }
}
