import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/features/auth/presentation/widgets/record_completed.dart';
import 'package:nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:nexus/features/home/presentation/views/photo_view.dart';
import 'package:nexus/features/profile/presentation/widgets/compatibility_modal.dart';
import 'package:nexus/features/profile/presentation/widgets/text_container.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    var currentUser =
        Provider.of<HomeNotifier>(context, listen: false).currentUser!;
    if (currentUser.compatibilitySetted == null ||
        currentUser.compatibilitySetted == false) {
      Future.delayed(const Duration(seconds: 1), () {
        _setAudioPlayer();
        showAdaptiveDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog.adaptive(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                'Compatibility Quiz',
                style: textStyle16,
              ),
              content: const CompatabiltyModal(),
            );
          },
        );
      });
    }

// ada(context: context, builder: )
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
    return Consumer<HomeNotifier>(builder: (context, homeModel, _) {
      return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          leading: const SizedBox.shrink(),
          title: Text(
            'Your Profile',
            style: textStyle18.copyWith(
                fontSize: 24, fontWeight: FontWeight.w700, color: black),
          ),
          centerTitle: true,
          foregroundColor: black,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 55.r,
                    backgroundImage: NetworkImage(
                      homeModel.currentUser!.profileUrl!,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${homeModel.currentUser!.username}, ${homeModel.currentUser!.age}',
                        style: textStyle8.copyWith(
                            color: black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBoxH5(),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/location.svg'),
                          const SizedBoxW5(),
                          Text(
                            '${homeModel.currentUser!.city}, ${homeModel.currentUser!.country}',
                            style: textStyle16.copyWith(
                                fontWeight: FontWeight.w300, color: black),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBoxH25(),
              Text(
                'About',
                style: textStyle18.copyWith(
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
              const SizedBoxH5(),
              Row(
                children: [
                  Text(
                    'State of Origin: ',
                    style: textStyle18.copyWith(
                        fontWeight: FontWeight.w500, color: ash),
                  ),
                  Text(
                    homeModel.currentUser!.stateOfOrigin ?? '',
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
                    homeModel.currentUser!.educationLevel ?? '',
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
                    homeModel.currentUser!.profession ?? '',
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
                    homeModel.currentUser!.churchName ?? '',
                    style: textStyle18.copyWith(
                        fontWeight: FontWeight.w500, color: black),
                  ),
                ],
              ),
              const SizedBoxH25(),
              Text(
                'Hobbies / Interests',
                style: textStyle18.copyWith(
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
              const SizedBoxH10(),
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  for (var hob in homeModel.currentUser!.hobbies!)
                    TextContainer(
                      text: hob,
                    ),
                ],
              ),
              const SizedBoxH25(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Most Desired Qualities',
                    style: textStyle18.copyWith(
                      fontWeight: FontWeight.w700,
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
                  for (var des in homeModel.currentUser!.desiredQualities!)
                    TextContainer(
                      text: des,
                    ),
                ],
              ),
              const SizedBoxH25(),
              Text(
                'Audio Recording',
                style: textStyle18.copyWith(
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
              const SizedBoxH15(),
              Text(
                '1. The summary of my relationship with God',
                style: textStyle14.copyWith(
                    color: black, fontSize: 14, fontWeight: FontWeight.w700),
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
                    color: black, fontSize: 14, fontWeight: FontWeight.w700),
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
                    color: black, fontSize: 14, fontWeight: FontWeight.w700),
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
              const SizedBoxH25(),
              Text(
                'Gallery',
                style: textStyle18.copyWith(
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
              const SizedBoxH10(),
              Wrap(
                runSpacing: 15,
                spacing: 15,
                children: [
                  for (var item in homeModel.currentUser!.photos!)
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => PhotoViewScreen(
                            selectedIndex: 0,
                            photos: homeModel.currentUser!.photos!,
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: CachedNetworkImage(
                          width: width(context) * .4,
                          height: 100.h,
                          fit: BoxFit.cover,
                          imageUrl: item,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: primary,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBoxH40(),
              const SizedBoxH40(),
            ],
          ),
        ),
      );
    });
  }
}
