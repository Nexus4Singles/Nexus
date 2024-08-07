import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/constant.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/device.dart';
import 'package:Nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:Nexus/features/auth/presentation/widgets/record_completed.dart';
import 'package:Nexus/router.dart';
import 'package:provider/provider.dart';

import 'package:just_audio/just_audio.dart';

class Audio4Screen extends StatefulWidget {
  const Audio4Screen({super.key});

  @override
  State<Audio4Screen> createState() => _Audio4ScreenState();
}

class _Audio4ScreenState extends State<Audio4Screen> {
  AudioPlayer player = AudioPlayer();
  AudioPlayer player2 = AudioPlayer();
  AudioPlayer player3 = AudioPlayer();
  late Duration duration;
  late Duration playerPosition;
// bool isLoading =
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setAudioPlayer();
  }

  Future _setAudioPlayer() async {
    EasyLoading.show();
    var model = Provider.of<AuthNotifier>(context, listen: false);
    // if (playerId == '1') {
    await player.setFilePath(model.audioPath1);

    player.durationStream.listen((d) {
      duration = d!;
    });

    player.positionStream.listen((p) {
      playerPosition = p;
    });
    // } else if (playerId == '2') {
    await player2.setFilePath(model.audioPath2);

    player2.durationStream.listen((d) {
      duration = d!;
    });

    player2.positionStream.listen((p) {
      playerPosition = p;
    });
    // } else {
    await player3.setFilePath(model.audioPath3);

    player3.durationStream.listen((d) {
      duration = d!;
    });

    player3.positionStream.listen((p) {
      playerPosition = p;
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: SizedBox(
            width: width(context) * .5,
            child: LinearProgressIndicator(
              value: 1,
              backgroundColor: newGrey,
              color: primary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Audio Recordings',
                  style: textStyle8.copyWith(
                      fontSize: 30, fontWeight: FontWeight.w700, color: black),
                ),
              ),
              const SizedBoxH15(),
              Text(
                'Your Responses',
                style: textStyle18,
              ),
              const SizedBoxH15(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. ',
                    style: textStyle14.copyWith(
                        color: black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Text(
                      'How would you describe your current relationship with God and why is this relationship important to you?',
                      style: textStyle14.copyWith(
                          color: black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBoxH10(),
              AudioFilePlayer(
                player: player,
                onPlay: () async {
                  player2.stop();
                  player2.seek(Duration.zero);
                  player3.stop();
                  player3.seek(Duration.zero);
                  // await _setAudioPlayer();
                  player.play();
                },
                onPause: () async {
                  // await _setAudioPlayer();
                  player.pause();
                },
              ),
              const SizedBoxH40(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2. ',
                    style: textStyle14.copyWith(
                        color: black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Text(
                      'What are your thoughts on the role of a husband and a wife in marriage?',
                      style: textStyle14.copyWith(
                          color: black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBoxH10(),
              AudioFilePlayer(
                player: player2,
                onPlay: () async {
                  player.stop();
                  player.seek(Duration.zero);
                  player3.stop();
                  player3.seek(Duration.zero);
                  // await _setAudioPlayer(model.audioPath2, '2');
                  player2.play();
                },
                onPause: () async {
                  // await _setAudioPlayer(model.audioPath2, '2');
                  player2.pause();
                },
              ),
              const SizedBoxH40(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3. ',
                    style: textStyle14.copyWith(
                        color: black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Text(
                      'What are your favourite qualities or traits about yourself?',
                      style: textStyle14.copyWith(
                          color: black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
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
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                onPressed: () {
                  _uploadFiles(model);
                },
                child: Text(
                  'Complete Profile',
                  style: textStyle16.copyWith(
                      color: white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBoxH30()
            ],
          ),
        ),
      );
    });
  }

  void _uploadFiles(AuthNotifier model) async {
    await model.uploadFile(file: File(model.audioPath1)).then((audi1) async {
      await model.uploadFile(file: File(model.audioPath2)).then((audio2) async {
        await model
            .uploadFile(file: File(model.audioPath3))
            .then((audio3) async {
          model.updateProfile(
              map: {
                kRELATIONSHIPWITHGOD: audi1,
                kROLEOFHUSBAND: audio2,
                kBESTQUALITIESORTRAITS: audio3,
                kREGPROGRESS: 'completed',
              },
              onCompleted: () {
                Get.offAndToNamed(AppRoutes.regSuccessful);
              });
        });
      });
    });
  }
}
