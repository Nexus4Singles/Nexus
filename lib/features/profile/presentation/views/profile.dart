import 'dart:async';
import 'package:Nexus/core/constant.dart';
import 'package:Nexus/core/utils/image_compressor.dart';
import 'package:Nexus/core/utils/modals.dart';
import 'package:Nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:Nexus/features/home/presentation/widgets/cache_network_widget.dart';
import 'package:Nexus/features/profile/presentation/controllers/profile_ctr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/features/auth/presentation/widgets/record_completed.dart';
import 'package:Nexus/features/home/controllers/home_controller.dart';
import 'package:Nexus/features/home/presentation/views/photo_view.dart';
import 'package:Nexus/features/profile/presentation/widgets/compatibility_modal.dart';
import 'package:Nexus/features/profile/presentation/widgets/text_container.dart';
import '../../../../core/assets.dart';
import '../../../../router.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

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

  final _ctr = Get.put(ProfileCtr());

  FutureOr _init() {
    _setAudioPlayer();

    if (currentUser.compatibilitySetted == null ||
        currentUser.compatibilitySetted == false) {
      Future.delayed(const Duration(seconds: 3), () {
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
    try {
      Future.wait([
        player.setUrl(currentUser.relationshipWithGod ?? ""),
        player2.setUrl(currentUser.roleOfHusband ?? ""),
        player3.setUrl(currentUser.bestQualotiesOrTraits ?? "")
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
    } catch (e) {
      debugPrint("this is the loaded audio error ==>${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CacheNetworkWidget(
                      height: 110.r,
                      width: 110.r,
                      imgUrl:
                          homeModel.user.value.profileUrl ?? kDEFAULTUSERPIC,
                      isNotCircle: false,
                    ),
                    InkWell(
                      onTap: () {
                        _pickImage(model);
                      },
                      child: SvgPicture.asset('assets/icons/edit.svg'),
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBoxH5(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('$svgPath/location.svg'),
                        const SizedBoxW5(),
                        Flexible(
                          child: Text(
                            homeModel.user.value.location?.place ?? "",
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
                      'Nationality: ',
                      style: textStyle14.copyWith(
                          fontWeight: FontWeight.w500, color: ash),
                    ),
                    Text(
                      homeModel.user.value.country ?? '',

                      style: textStyle14.copyWith(
                          fontWeight: FontWeight.w500, color: black),
                    ),
                  ],
                ),
                if (homeModel.user.value.country == 'Nigeria')
                  const SizedBoxH10(),
                if (homeModel.user.value.country == 'Nigeria')
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
                    for (var hob in homeModel.user.value.hobbies ?? [])
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
                    for (var des in homeModel.user.value.desiredQualities ?? [])
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
                    for (var item in homeModel.user.value.photos ?? [])
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
                          child: CacheNetworkWidget(
                            width: Get.width / 2.3,
                            height: 100.h,
                            imgUrl: item,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBoxH10(),
                Center(
                  child: TextButton(
                    onPressed: () {
                      contactinfoModal(context, homeModel.user.value);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        "Contact info",
                        style: textStyle14.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBoxH40(),
                const SizedBoxH40(),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _pickImage(AuthNotifier model) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      var coFile = await ImageCompressorNexus().compressAndGetFile(image);

      EasyLoading.show();

      await model
          .uploadToDigitalOcean(
        bucketName: 'profile',
        objectName:
            '${model.user?.email}_${model.user?.id}/${path.basename(coFile!.path.trim())}',
        filePath: coFile!.path,
      )
          .then((value) async {
        await _ctr.updateProfilePic(value);
        EasyLoading.dismiss();
      });
    }
  }
}
