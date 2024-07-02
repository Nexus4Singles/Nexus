import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/core/utils/modals.dart';
import 'package:nexus/features/chat/controllers/chat_ctr.dart';
import 'package:nexus/features/match/presentation/widgets/matchUsersCompatibilityModal.dart';
import 'package:nexus/router.dart';

import '../../../../core/colors.dart';

class Matched extends StatelessWidget {
  final UserModel userModel;
  final int messageID;
  Matched({super.key, required this.userModel, required this.messageID});
  var ctr = Get.put(ChatCtr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextButton(
            onPressed: () {
              compatibilityModal(context, userModel);
            },
            child: Text("View Compatibility Data", style: textStyle16)),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.mainNav);
            },
            icon: const Icon(Icons.clear)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBoxH40(),
          Center(
            child: Text("You and ${userModel.username} liked each other!",
                style: textStyle14.copyWith(fontWeight: FontWeight.w700)),
          ),
          const SizedBoxH20(),
          Container(
            height: Get.height / 2,
            width: Get.width / 1.2,
            decoration: BoxDecoration(
                boxShadow: [boxShadow],
                border: Border.all(
                    color: white,
                    width: 5,
                    strokeAlign: BorderSide.strokeAlignOutside),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: NetworkImage(userModel.photos![0]),
                    fit: BoxFit.cover)),
            child: Transform.translate(
                offset: const Offset(0, 70),
                child: Image.asset("$imgPath/matched.png")),
          ),
          Transform.translate(
            offset: const Offset(0, 50),
            child: Column(
              children: [
                Text(
                  "We are rooting for you both!",
                  style: textStyle14.copyWith(color: ash),
                ),
                const SizedBoxH20(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomTextField(
                      radius: 100,
                      fillColor: grey,
                      suffixIcon: InkWell(
                        onTap: () {
                          ctr.sendMessage(
                              messageID.toString(), ctr.chatController.text);
                          ctr.chatController.clear();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: black,
                            child: SvgPicture.asset("$svgPath/send.svg"),
                          ),
                        ),
                      ),
                      controller: ctr.chatController,
                      hintText: "Send a message"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
