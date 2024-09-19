import 'dart:async';
import 'package:Nexus/features/home/presentation/widgets/cache_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:just_audio/just_audio.dart';
import 'package:Nexus/core/assets.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/device.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/modals.dart';
import '../../../auth/presentation/widgets/record_completed.dart';
import '../../../match/controllers/matches_ctr.dart';
import '../../../profile/presentation/widgets/text_container.dart';
import '../../../subscription/provider/subscription_provider.dart';
import '../../../subscription/widgets/restriction_modal.dart';
import '../views/photo_view.dart';

class UserCard extends StatefulWidget {
  final UserModel userModel;
  final VoidCallback? onRefresh;
  final VoidCallback onClosed;
  final VoidCallback onLike;
  final VoidCallback? onSaved;
  final VoidCallback onClick;
  const UserCard({
    super.key,
    required this.userModel,
    required this.onClosed,
    required this.onLike,
    required this.onRefresh,
    required this.onSaved,
    required this.onClick,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  AudioPlayer player = AudioPlayer();
  AudioPlayer player2 = AudioPlayer();
  AudioPlayer player3 = AudioPlayer();
  late Duration duration;
  late Duration playerPosition;

  Future _setAudioPlayer() async {
    Future.wait([
      player.setUrl(widget.userModel.relationshipWithGod!),
      player2.setUrl(widget.userModel.roleOfHusband!),
      player3.setUrl(widget.userModel.bestQualotiesOrTraits!)
    ]);

    player.durationStream.listen((d) {
      duration = d!;
    });
    player.positionStream.listen((p) {
      playerPosition = p;
    });
    player2.durationStream.listen((d) {
      duration = d!;
    });
    player2.positionStream.listen((p) {
      playerPosition = p;
    });
    player3.durationStream.listen((d) {
      duration = d!;
    });
    player3.positionStream.listen((p) {
      playerPosition = p;
    });
  }

  FutureOr _init() {
    debugPrint('called againn======..>');
    _setAudioPlayer();
  }

  stopPlayer() {
    player.stop();
    player2.stop();
    player3.stop();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  var ctr = Get.put(MatchesCtr());

  @override
  Widget build(BuildContext context) {
    _init();
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        width: width(context),
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [boxShadow],
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CacheNetworkWidget(
                imgUrl: widget.userModel.photos![0],
                opacity: .4,
                color: black,
                height: height(context) * .55,
                width: width(context),
                borderRadius: BorderRadius.circular(20.r),
                child: Padding(
                  padding: EdgeInsets.all(15.sp),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.userModel.username}, ${widget.userModel.age}',
                        style: headerStyle.copyWith(
                          fontSize: 24.sp,
                          color: white,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.location5,
                            color: white,
                            size: 20,
                          ),
                          const SizedBoxW10(),
                          Flexible(
                            child: Text(
                              '${widget.userModel.location!.place}',
                              textAlign: TextAlign.center,
                              style: textStyle14.copyWith(
                                color: white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.all(15.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // InkWell(
                              //   onTap: () {
                              //     stopPlayer();
                              //     widget.onRefresh!();
                              //   },
                              //   child: Container(
                              //     padding: const EdgeInsets.all(8),
                              //     decoration: BoxDecoration(
                              //         shape: BoxShape.circle,
                              //         color: white,
                              //         border: Border.all(color: primary)),
                              //     child: SvgPicture.asset(
                              //       '$svgPath/back.svg',
                              //       width: 24,
                              //       color: primary,
                              //     ),
                              //   ),
                              // ),
                              InkWell(
                                onTap: () {
                                  widget.onClosed();
                                  stopPlayer();
                                },
                                child: SvgPicture.asset(
                                    'assets/icons/close.svg',
                                    width: 40),
                              ),
                              const SizedBoxW15(),
                              InkWell(
                                onTap: () {
                                  stopPlayer();
                                  widget.onLike();
                                },
                                child: CircleAvatar(
                                    backgroundColor: ctr.ctr.myProfile.value
                                                    .myLikes ==
                                                null ||
                                            !ctr.ctr.myProfile.value.myLikes!
                                                .contains(widget.userModel.id)
                                        ? white
                                        : primary,
                                    radius: 25,
                                    child: SvgPicture.asset(
                                      ctr.ctr.myProfile.value.matchedUsers ==
                                                  null ||
                                              !ctr.ctr.myProfile.value
                                                  .matchedUsers!
                                                  .contains(widget.userModel.id)
                                          ? "$svgPath/like.svg"
                                          : '$svgPath/sms.svg',
                                      color: ctr.ctr.myProfile.value.myLikes ==
                                                  null ||
                                              !ctr.ctr.myProfile.value.myLikes!
                                                  .contains(widget.userModel.id)
                                          ? primary
                                          : white,
                                    )),
                              ),
                              const SizedBoxW15(),
                              InkWell(
                                onTap: widget.onSaved,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: primary),
                                    color: ctr.ctr.myProfile.value.mySaves ==
                                                null ||
                                            !ctr.ctr.myProfile.value.mySaves!
                                                .contains(widget.userModel.id)
                                        ? white
                                        : primary,
                                  ),
                                  child: SvgPicture.asset(
                                      "$svgPath/bookmark.svg",
                                      width: 24,
                                      color: ctr.ctr.myProfile.value.mySaves ==
                                                  null ||
                                              !ctr.ctr.myProfile.value.mySaves!
                                                  .contains(widget.userModel.id)
                                          ? primary
                                          : white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBoxH20(),
                    Text(
                      'About',
                      style: textStyle14.copyWith(
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                    const SizedBoxH15(),
                    Row(
                      children: [
                        Text(
                          'State of Origin: ',
                          style: textStyle14.copyWith(
                              fontWeight: FontWeight.w500, color: ash),
                        ),
                        Text(
                          widget.userModel.stateOfOrigin ?? '',
                          style: textStyle16.copyWith(
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
                          widget.userModel.educationLevel ?? '',
                          style: textStyle16.copyWith(
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
                        Flexible(
                          child: Text(
                            widget.userModel.profession ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: textStyle16.copyWith(
                                fontWeight: FontWeight.w500, color: black),
                          ),
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
                        Flexible(
                          child: Text(
                            widget.userModel.churchName ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: textStyle16.copyWith(
                                fontWeight: FontWeight.w500, color: black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBoxH30(),
                    Text(
                      'Hobbies / Interests',
                      style: textStyle14.copyWith(
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                    const SizedBoxH10(),
                    Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: [
                        for (var hob in widget.userModel.hobbies!)
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
                          style: textStyle14.copyWith(
                            fontWeight: FontWeight.bold,
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
                        for (var des in widget.userModel.desiredQualities!)
                          TextContainer(
                            text: des,
                          ),
                      ],
                    ),
                    const SizedBoxH40(),
                    Text(
                      'Audio Recordings',
                      style: textStyle14.copyWith(
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                    const SizedBoxH15(),
                    Text(
                      "1. The summary of ${widget.userModel.username}'s relationship with God",
                      style: textStyle14.copyWith(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
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
                      "2. ${widget.userModel.username}'s view on Gender roles in marriage",
                      style: textStyle14.copyWith(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
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
                      "3. ${widget.userModel.username}'s favourite qualities about ${widget.userModel.gender.toLowerCase().contains("f") ? "herself" : "himself"}",
                      style: textStyle14.copyWith(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
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
                    const SizedBoxH30(),
                    Text(
                      'Gallery',
                      style: textStyle14.copyWith(
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                    const SizedBoxH10(),
                    Wrap(
                      runSpacing: 15,
                      spacing: 15,
                      children: [
                        for (var item in widget.userModel.photos!)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: InkWell(
                              onTap: () {
                                int index =
                                    widget.userModel.photos!.indexOf(item);
                                Get.to(() => PhotoViewScreen(
                                    selectedIndex: index,
                                    photos: widget.userModel.photos!));
                              },
                              child: CacheNetworkWidget(
                                  width: width(context) * .4,
                                  height: 100.h,
                                  imgUrl: item),
                            ),
                          ),
                      ],
                    ),
                    Center(
                      child: Consumer<SubscriptionProvider>(builder: (context, model, _) {
                        return TextButton(
                            onPressed: () {
                              if (model.onPremium == true) {
                                compatibilityModal(
                                    context, widget.userModel);
                              } else {
                                restrictionModal(context: context, text: 'Only Matched users can view this data for free.\nYou need to subscribe if you want to view this data on all profiles');
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Text(
                                "View Compatibility Data",
                                style: textStyle14.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ));
                      }
                      ),
                    ),
                    const SizedBox(height: 80)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
