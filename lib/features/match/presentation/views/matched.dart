import 'package:Nexus/core/constant.dart';
import 'package:Nexus/features/home/presentation/widgets/cache_network_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/assets.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/modals.dart';
import 'package:Nexus/features/chat/controllers/chat_ctr.dart';
import 'package:Nexus/router.dart';

class Matched extends StatelessWidget {
  final UserModel userModel;
  final int messageID;
  final ctr = ChatCtr.instance;

  Matched({
    super.key,
    required this.userModel,
    required this.messageID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.mainNav, arguments: 0);
            },
            icon: const Icon(Icons.clear),
          ),
          const SizedBoxW10()
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBoxH10(),
            Center(
              child: Text("You and ${userModel.username} liked each other!",
                  style: textStyle14.copyWith(fontWeight: FontWeight.w700)),
            ),
            const SizedBoxH20(),
            CacheNetworkWidget(
              height: Get.height / 1.6,
              width: Get.width / 1.2,
              imgUrl: userModel!.photos != null && userModel!.photos!.isNotEmpty
                  ? userModel!.photos![0]
                  : kDEFAULTUSERPIC,
              decoration: BoxDecoration(
                boxShadow: [boxShadow],
                border: Border.all(
                  color: white,
                  width: 5,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(userModel.photos![0]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Transform.translate(
                offset: const Offset(0, 35),
                child: Image.asset("$imgPath/matched.png"),
              ),
            ),
            Column(
              children: [
                const SizedBoxH20(),
                Text(
                  "Get more information on your compatibility \nwith ${userModel.username} by clicking the button below!",
                  style: textStyle16,
                  textAlign: TextAlign.center,
                ),
                const SizedBoxH10(),
                TextButton(
                  onPressed: () {
                    compatibilityModal(context, userModel);
                  },
                  child: Text("View Compatibility Data", style: textStyle16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
