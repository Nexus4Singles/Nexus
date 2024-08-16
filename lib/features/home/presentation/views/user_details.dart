import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:just_audio/just_audio.dart';
import 'package:Nexus/core/assets.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/device.dart';
import 'package:Nexus/core/utils/modals.dart';
import 'package:Nexus/features/auth/presentation/widgets/record_completed.dart';
import 'package:Nexus/features/home/presentation/views/photo_view.dart';
import 'package:Nexus/features/match/controllers/matches_ctr.dart';
import 'package:Nexus/features/profile/presentation/views/report_user.dart';
import 'package:Nexus/features/profile/presentation/widgets/text_container.dart';

class UserDetailScreen extends StatefulWidget {
  final UserModel userModel;
  const UserDetailScreen({super.key, required this.userModel});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  FutureOr _init() {
    _setAudioPlayer();
  }

  AudioPlayer player = AudioPlayer();
  AudioPlayer player2 = AudioPlayer();
  AudioPlayer player3 = AudioPlayer();
  late Duration duration;
  late Duration playerPosition;

  Future _setAudioPlayer() async {
    await player.setUrl(widget.userModel.relationshipWithGod!);

    player.durationStream.listen((d) {
      duration = d!;
    });

    player.positionStream.listen((p) {
      playerPosition = p;
    });
    await player2.setUrl(widget.userModel.roleOfHusband!);

    player2.durationStream.listen((d) {
      duration = d!;
    });

    player2.positionStream.listen((p) {
      playerPosition = p;
    });
    // } else {
    await player3.setUrl(widget.userModel.bestQualotiesOrTraits!);

    player3.durationStream.listen((d) {
      duration = d!;
    });

    player3.positionStream.listen((p) {
      playerPosition = p;
    });
    // }
  }

  var ctr = Get.put(MatchesCtr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          splashColor: Colors.black26,
          splashRadius: 24,
          icon: const Center(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          InkWell(
            child: const Icon(Icons.report, color: white),
            onTap: () {
              Get.to(() => ReportUser(userModel: widget.userModel));
            },
          ),
          const SizedBoxW20()
        ],
      ),
      body: Stack(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [Colors.transparent, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 1],
              ).createShader(bounds);
            },
            blendMode: BlendMode.darken,
            child: Container(
              height: Get.height / 1.5,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Colors.transparent, Colors.transparent, black]),
                image: DecorationImage(
                  image: NetworkImage(widget.userModel.photos![0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Get.height / 3.0),
                  child: Column(
                    children: [
                      userBio(),
                      Container(
                        width: width(context),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.r),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBoxH20(),
                            Text(
                              'About',
                              style: textStyle14.copyWith(
                                fontWeight: FontWeight.w700,
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
                                      fontWeight: FontWeight.w500,
                                      color: black),
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
                                      fontWeight: FontWeight.w500,
                                      color: black),
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
                                        fontWeight: FontWeight.w500,
                                        color: black),
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
                                        fontWeight: FontWeight.w500,
                                        color: black),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBoxH30(),
                            Text(
                              'Hobbies / Interests',
                              style: textStyle14.copyWith(
                                fontWeight: FontWeight.w700,
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
                                for (var des
                                    in widget.userModel.desiredQualities!)
                                  TextContainer(
                                    text: des,
                                  ),
                              ],
                            ),
                            const SizedBoxH40(),
                            Text(
                              'Audio Recordings',
                              style: textStyle14.copyWith(
                                fontWeight: FontWeight.w700,
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
                              '3. Favourite qualities or traits about ${widget.userModel.username}',
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
                                fontWeight: FontWeight.w700,
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
                                        int index = widget.userModel.photos!
                                            .indexOf(item);
                                        Get.to(() => PhotoViewScreen(
                                            selectedIndex: index,
                                            photos: widget.userModel.photos!));
                                      },
                                      child: CachedNetworkImage(
                                        width: width(context) * .4,
                                        height: 100.h,
                                        fit: BoxFit.cover,
                                        imageUrl: item,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator
                                              .adaptive(
                                            value: downloadProgress.progress,
                                            strokeWidth: 1,
                                            valueColor:
                                                const AlwaysStoppedAnimation(
                                                    primary),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBoxH20(),
                            widget.userModel.matchedUsers != null &&
                                    widget.userModel.matchedUsers!
                                        .contains(ctr.auth.currentUser!.uid)
                                ? Center(
                                    child: TextButton(
                                        onPressed: () {
                                          compatibilityModal(
                                              context, widget.userModel);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              color: primary.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Text(
                                            "View Compatibility Data",
                                            style: textStyle14.copyWith(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  )
                                : const SizedBoxH10(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget userBio() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${widget.userModel.username}, ${widget.userModel.age}',
            style: headerStyle.copyWith(fontSize: 22.sp, color: white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Iconsax.location5,
                  color: white,
                  size: 14,
                ),
                const SizedBoxW10(),
                Flexible(
                  child: Text(
                    widget.userModel.location!.place!.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: textStyle14.copyWith(color: white),
                  ),
                )
              ],
            ),
          ),
          const SizedBoxH10(),
          Obx(
            () => ctr.ctr.myProfile.value.matchedUsers == null ||
                    !ctr.ctr.myProfile.value.matchedUsers!
                        .contains(widget.userModel.id)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          ctr.ctr.myProfile.value.matchedUsers == null ||
                                  !ctr.ctr.myProfile.value.matchedUsers!
                                      .contains(widget.userModel.id)
                              ? ctr.toggleLike(widget.userModel)
                              : debugPrint("This users are matched");
                        },
                        child: CircleAvatar(
                            backgroundColor:
                                ctr.ctr.myProfile.value.myLikes == null ||
                                        !ctr.ctr.myProfile.value.myLikes!
                                            .contains(widget.userModel.id)
                                    ? white
                                    : primary,
                            radius: 25,
                            child: SvgPicture.asset(
                              ctr.ctr.myProfile.value.matchedUsers == null ||
                                      !ctr.ctr.myProfile.value.matchedUsers!
                                          .contains(widget.userModel.id)
                                  ? "$svgPath/like.svg"
                                  : '$svgPath/sms.svg',
                              color: ctr.ctr.myProfile.value.myLikes == null ||
                                      !ctr.ctr.myProfile.value.myLikes!
                                          .contains(widget.userModel.id)
                                  ? primary
                                  : white,
                            )),
                      ),
                      const SizedBoxW20(),
                      InkWell(
                        onTap: () {
                          ctr.toggleSave(widget.userModel.id);
                          debugPrint(ctr.ctr.myProfile.value.mySaves!
                              .contains(widget.userModel.id)
                              .toString());
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              ctr.ctr.myProfile.value.mySaves == null ||
                                      !ctr.ctr.myProfile.value.mySaves!
                                          .contains(widget.userModel.id)
                                  ? white
                                  : primary,
                          radius: 25,
                          child: SvgPicture.asset("$svgPath/bookmark.svg",
                              color: ctr.ctr.myProfile.value.mySaves == null ||
                                      !ctr.ctr.myProfile.value.mySaves!
                                          .contains(widget.userModel.id)
                                  ? primary
                                  : white),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
