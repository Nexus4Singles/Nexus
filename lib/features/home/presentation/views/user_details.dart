import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/features/auth/presentation/widgets/record_completed.dart';
import 'package:nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:nexus/features/home/presentation/views/photo_view.dart';
import 'package:nexus/features/home/presentation/widgets/coming_soon_modal.dart';
import 'package:nexus/features/profile/presentation/widgets/text_container.dart';
import 'package:provider/provider.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  FutureOr _init() {
    player = AudioPlayer();
    player2 = AudioPlayer();
    player3 = AudioPlayer();
  }

  late AudioPlayer player;
  late AudioPlayer player2;
  late AudioPlayer player3;
  late Duration duration;
  late Duration playerPosition;

  Future _setAudioPlayer() async {
    var currentUser =
        Provider.of<HomeNotifier>(context, listen: false).currentUser!;

    // if (playerId == '1') {
    await player.setUrl(currentUser.relationshipWithGod!);

    player.durationStream.listen((d) {
      duration = d!;
    });

    player.positionStream.listen((p) {
      playerPosition = p;
    });
    // } else if (playerId == '2') {
    await player2.setUrl(currentUser.roleOfHusband!);

    player2.durationStream.listen((d) {
      duration = d!;
    });

    player2.positionStream.listen((p) {
      playerPosition = p;
    });
    // } else {
    await player3.setUrl(currentUser.bestQualotiesOrTraits!);

    player3.durationStream.listen((d) {
      duration = d!;
    });

    player3.positionStream.listen((p) {
      playerPosition = p;
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(builder: (context, model, _) {
      return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          backgroundColor: black,
          leading: const SizedBox(
            width: 20,
          ),
          toolbarHeight: 00,
        ),
        body: Container(
          decoration: BoxDecoration(
            // color: black,
            image: DecorationImage(
              image: NetworkImage(model.selectedUser!.profileUrl!),
              opacity: .1,
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SafeArea(
                      bottom: false,
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            () => PhotoViewScreen(
                              selectedIndex: 0,
                              photos: model.selectedUser!.photos!,
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                          height: height(context) * .5,
                          width: width(context),
                          fit: BoxFit.cover,
                          imageUrl: model.selectedUser!.profileUrl!,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  const SizedBox(
                            width: 30,
                            height: 30,
                            // child: CircularProgressIndicator(
                            //   value: downloadProgress.progress,
                            //   color: primary,
                            // ),
                          ),
                          errorWidget: (context, url, error) => Container(),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      child: SafeArea(
                        child: BackButton(
                          color: white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: width(context),
                        padding: EdgeInsets.all(20.sp),
                        decoration: BoxDecoration(
                          color: black.withOpacity(.3),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${model.selectedUser!.username}, ${model.selectedUser!.age}',
                              style: headerStyle.copyWith(
                                fontSize: 22.sp,
                                color: white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Iconsax.location5,
                                  color: white,
                                  size: 14,
                                ),
                                const SizedBoxW10(),
                                Text(
                                  '${model.selectedUser!.stateOfOrigin!} ${model.selectedUser!.country}',
                                  style: textStyle12.copyWith(
                                    color: white,
                                  ),
                                )
                              ],
                            ),
                            const SizedBoxH10(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showModal();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: white,
                                    radius: 25,
                                    child: Image.asset(
                                      'assets/icons/refresh-w.png',
                                    ),
                                  ),
                                ),
                                const SizedBoxW20(),
                                InkWell(
                                  onTap: () {
                                    showModal();
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/close.svg',
                                  ),
                                ),
                                const SizedBoxW20(),
                                InkWell(
                                  onTap: () {
                                    showModal();
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/fav.svg',
                                  ),
                                ),
                                const SizedBoxW20(),
                                InkWell(
                                  onTap: () {
                                    showModal();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: white,
                                    radius: 25,
                                    child: Image.asset(
                                      'assets/icons/bookmark-w.png',
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: width(context),
                  // height: height(context),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBoxH20(),
                      Text(
                        'About',
                        style: textStyle18.copyWith(
                          fontWeight: FontWeight.w500,
                          color: black,
                        ),
                      ),
                      const SizedBoxH15(),
                      Row(
                        children: [
                          Text(
                            'State of Origin: ',
                            style: textStyle18.copyWith(
                                fontWeight: FontWeight.w500, color: ash),
                          ),
                          Text(
                            model.selectedUser!.stateOfOrigin ?? '',
                            style: textStyle18.copyWith(
                                fontWeight: FontWeight.w500, color: black),
                          ),
                        ],
                      ),
                      const SizedBoxH10(),
                      Row(
                        children: [
                          Text(
                            'Education Level: ',
                            style: textStyle18.copyWith(
                                fontWeight: FontWeight.w500, color: ash),
                          ),
                          Text(
                            model.selectedUser!.educationLevel ?? '',
                            style: textStyle18.copyWith(
                                fontWeight: FontWeight.w500, color: black),
                          ),
                        ],
                      ),
                      const SizedBoxH10(),
                      Row(
                        children: [
                          Text(
                            'Profession/Industry: ',
                            style: textStyle18.copyWith(
                                fontWeight: FontWeight.w500, color: ash),
                          ),
                          Text(
                            model.selectedUser!.profession ?? '',
                            style: textStyle18.copyWith(
                                fontWeight: FontWeight.w500, color: black),
                          ),
                        ],
                      ),
                      const SizedBoxH10(),
                      Row(
                        children: [
                          Text(
                            'Church: ',
                            style: textStyle18.copyWith(
                                fontWeight: FontWeight.w500, color: ash),
                          ),
                          Text(
                            model.selectedUser!.city ?? '',
                            style: textStyle18.copyWith(
                                fontWeight: FontWeight.w500, color: black),
                          ),
                        ],
                      ),
                      const SizedBoxH30(),
                      Text(
                        'Hobbies / Interests',
                        style: textStyle18.copyWith(
                          fontWeight: FontWeight.w500,
                          color: black,
                        ),
                      ),
                      const SizedBoxH10(),
                      Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: [
                          for (var hob in model.selectedUser!.hobbies!)
                            TextContainer(
                              text: hob,
                            ),
                        ],
                      ),
                      const SizedBoxH30(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Most Desired Qualities',
                            style: textStyle18.copyWith(
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBoxH10(),
                      Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: [
                          for (var des in model.selectedUser!.desiredQualities!)
                            TextContainer(
                              text: des,
                            ),
                        ],
                      ),
                      const SizedBoxH40(),
                      Text(
                        'Audio Recording',
                        style: textStyle18.copyWith(
                          fontWeight: FontWeight.w500,
                          color: black,
                        ),
                      ),
                      const SizedBoxH15(),
                      Text(
                        '1. The summary of my relationship with God',
                        style: textStyle14.copyWith(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBoxH10(),
                      AudioFilePlayer(
                        player: player,
                        onPlay: () async {
                          player.play();
                        },
                        onPause: () async {
                          player.pause();
                        },
                      ),
                      const SizedBoxH25(),
                      Text(
                        '2. My view on Gender roles in marriage',
                        style: textStyle14.copyWith(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBoxH10(),
                      AudioFilePlayer(
                        player: player2,
                        onPlay: () async {
                          player2.play();
                        },
                        onPause: () async {
                          player2.pause();
                        },
                      ),
                      const SizedBoxH25(),
                      Text(
                        '3. Favourite qualities or traits about myself',
                        style: textStyle14.copyWith(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBoxH10(),
                      AudioFilePlayer(
                        player: player3,
                        onPlay: () async {
                          player3.play();
                        },
                        onPause: () async {
                          player3.pause();
                        },
                      ),
                      const SizedBoxH30(),
                      Text(
                        'Gallery',
                        style: textStyle18.copyWith(
                          fontWeight: FontWeight.w500,
                          color: black,
                        ),
                      ),
                      const SizedBoxH10(),
                      Wrap(
                        runSpacing: 15,
                        spacing: 15,
                        children: [
                          for (var item in model.selectedUser!.photos!)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: InkWell(
                                onTap: () {
                                  int index =
                                      model.selectedUser!.photos!.indexOf(item);
                                  Get.to(() => PhotoViewScreen(
                                      selectedIndex: index,
                                      photos: model.selectedUser!.photos!));
                                },
                                child: CachedNetworkImage(
                                  width: width(context) * .4,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                  imageUrl: item,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      color: primary,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBoxH40(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void showModal() {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog.adaptive(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: const ComingSoonModal(
            text:
                'You will be able to view profile recommendations here as soon as we launch fully.',
          ),
        );
      },
    );
  }
}
