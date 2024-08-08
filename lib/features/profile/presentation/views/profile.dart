import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:just_audio/just_audio.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/features/auth/presentation/widgets/record_completed.dart';
import 'package:Nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:Nexus/features/home/presentation/views/photo_view.dart';
import 'package:Nexus/features/profile/presentation/widgets/compatibility_modal.dart';
import 'package:Nexus/features/profile/presentation/widgets/text_container.dart';
import 'package:provider/provider.dart';
import '../../../../router.dart';
import '../../../home/controllers/home_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  var currentUser = HomeController.instance.user.value;
  var homeModel = HomeController.instance;

  FutureOr _init() {
    _setAudioPlayer();
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
  }

  AudioPlayer player = AudioPlayer();
  AudioPlayer player2 = AudioPlayer();
  AudioPlayer player3 = AudioPlayer();
  late Duration duration;
  late Duration playerPosition;

  Future _setAudioPlayer() async {
    print("this is for audio==>${currentUser.relationshipWithGod}");
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
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        leading: const SizedBox.shrink(),
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.settings);
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(
                Iconsax.setting_4,
              ),
            ),
          ),
        ],
        title: Text(
          'Your Profile',
          style: textStyle18.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 55.r,
                    backgroundImage: NetworkImage(
                      homeModel.user.value.profileUrl!,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${homeModel.user.value.username}, ${homeModel.user.value.age}',
                    style: textStyle8.copyWith(
                        color: black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBoxH5(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/location.svg'),
                      const SizedBoxW5(),
                      Flexible(
                        child: Text(
                          '${homeModel.user.value.location!.place}',
                          overflow: TextOverflow.ellipsis,
                          style: textStyle14.copyWith(
                              fontWeight: FontWeight.w300, color: black),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBoxH25(),
              Text(
                'About',
                style: textStyle16.copyWith(
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
              const SizedBoxH5(),
              Row(
                children: [
                  Text(
                    'State of Origin: ',
                    style: textStyle14.copyWith(
                        fontWeight: FontWeight.w500, color: ash),
                  ),
                  Text(
                    homeModel.user.value.stateOfOrigin ?? '',
                    style: textStyle14.copyWith(
                        fontWeight: FontWeight.w500, color: black),
                  ),
                ],
              ),
              const SizedBoxH10(),
              Row(
                children: [
                  Text(
                    'Education Level: ',
                    style: textStyle14.copyWith(
                        fontWeight: FontWeight.w500, color: ash),
                  ),
                  Text(
                    homeModel.user.value.educationLevel ?? '',
                    style: textStyle14.copyWith(
                        fontWeight: FontWeight.w500, color: black),
                  ),
                ],
              ),
              const SizedBoxH10(),
              Row(
                children: [
                  Text(
                    'Profession/Industry: ',
                    style: textStyle14.copyWith(
                        fontWeight: FontWeight.w500, color: ash),
                  ),
                  Text(
                    homeModel.user.value.profession ?? '',
                    style: textStyle14.copyWith(
                        fontWeight: FontWeight.w500, color: black),
                  ),
                ],
              ),
              const SizedBoxH10(),
              Row(
                children: [
                  Text(
                    'Church: ',
                    style: textStyle14.copyWith(
                        fontWeight: FontWeight.w500, color: ash),
                  ),
                  Text(
                    homeModel.user.value.churchName ?? '',
                    style: textStyle14.copyWith(
                        fontWeight: FontWeight.w500, color: black),
                  ),
                ],
              ),
              const SizedBoxH25(),
              Text(
                'Hobbies / Interests',
                style: textStyle16.copyWith(
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
              const SizedBoxH10(),
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  for (var hob in homeModel.user.value.hobbies!)
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
                    style: textStyle16.copyWith(
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
                  for (var des in homeModel.user.value.desiredQualities!)
                    TextContainer(
                      text: des,
                    ),
                ],
              ),
              const SizedBoxH25(),
              Text(
                'Audio Recordings ',
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
                  player2.stop();
                  player2.seek(Duration.zero);
                  player3.stop();
                  player3.seek(Duration.zero);
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
                  player.stop();
                  player.seek(Duration.zero);
                  player3.stop();
                  player3.seek(Duration.zero);
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
                  player.stop();
                  player.seek(Duration.zero);
                  player2.stop();
                  player2.seek(Duration.zero);
                  player3.play();
                },
                onPause: () async {
                  player3.pause();
                },
              ),
              const SizedBoxH25(),
              Text(
                'Gallery',
                style: textStyle16.copyWith(
                    fontWeight: FontWeight.w700, color: black),
              ),
              const SizedBoxH10(),
              Wrap(
                runSpacing: 15,
                spacing: 24,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  for (var item in homeModel.user.value.photos!)
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => PhotoViewScreen(
                            selectedIndex:
                                homeModel.user.value.photos!.indexOf(item),
                            photos: homeModel.user.value.photos!,
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: CachedNetworkImage(
                          width: Get.width / 2.3,
                          height: 100.h,
                          fit: BoxFit.cover,
                          imageUrl: item,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  const SizedBox(
                            width: 30,
                            height: 30,
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
      ),
    );
  }
}
