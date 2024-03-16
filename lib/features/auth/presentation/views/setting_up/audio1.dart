import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/router.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class Audio1Screen extends StatefulWidget {
  const Audio1Screen({super.key});

  @override
  State<Audio1Screen> createState() => _Audio1ScreenState();
}

class _Audio1ScreenState extends State<Audio1Screen> {
// final recorderController = RecorderController();
  late final RecorderController recorderController;

  StreamSubscription? streamSubscription;

  Duration? position;

  String? path;
  String? musicFile;
  String? recordedPath;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  late Directory appDirectory;

  @override
  void initState() {
    super.initState();
    _getDir();
    _initialiseControllers();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording1.m4a";
    isLoading = false;
    setState(() {});
  }

  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      musicFile = result.files.single.path;
      setState(() {});
    } else {
      debugPrint("File not picked");
    }
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Slider(
          value: 0.7,
          onChanged: (val) {},
          activeColor: primary,
          inactiveColor: grey,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.audio2);
            },
            child: Text(
              'Next',
              style: textStyle14.copyWith(
                  fontWeight: FontWeight.w700, color: black),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                'Audio Recordings',
                style: textStyle8.copyWith(
                    fontSize: 30, fontWeight: FontWeight.w700, color: black),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: primary,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '1',
                        style: textStyle18.copyWith(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                const SizedBoxH15(),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'How would you describe your relationship with God and \nwhat has been the highlight of your experience with Him?',
                    style: textStyle12.copyWith(
                        fontWeight: FontWeight.w700, height: 2),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBoxH30(),
                if (!isRecording)
                  Text(
                    '00:00',
                    style: textStyle18.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w200,
                        color: friendGrey),
                  ),
                if (isRecording)
                  Column(
                    children: [
                      StreamBuilder<Duration>(
                        stream: recorderController.onCurrentDuration,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }
                          return Text(
                            '${snapshot.data!.inHours.toString()}:${snapshot.data!.inMinutes.toString()}:${snapshot.data!.inSeconds.toString()}',
                            style: textStyle18.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w200,
                              color: friendGrey,
                            ),
                          );
                        },
                      ),
                      const SizedBoxH30(),
                      AudioWaveforms(
                        recorderController: recorderController,
                        size: Size(
                          width(context) * .5,
                          100.h,
                        ),
                        enableGesture: true,
                        waveStyle: const WaveStyle(
                          waveColor: primary,
                          extendWaveform: true,
                          showMiddleLine: false,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          // color: const Color(0xFF1E1B26),
                        ),
                        padding: EdgeInsets.only(left: 18.sp),
                      ),
                    ],
                  ),
                // SvgPicture.asset('assets/icons/audio1.svg'),
              ],
            ),
            const SizedBoxH25(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: warGrey,
                    child: SvgPicture.asset('assets/icons/refresh.svg'),
                  ),
                  const SizedBoxW40(),
                  Center(
                    child: InkWell(
                      onTap: () {
                        _startOrStopRecording();
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: warGrey,
                        child: CircleAvatar(
                          backgroundColor: primary,
                          radius: 30,
                          child: Icon(
                            isRecording ? Iconsax.pause : Iconsax.microphone,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startOrStopRecording() async {
    try {
      if (isRecording) {
        recorderController.reset();

        final path = await recorderController.stop(false);

        if (path != null) {
          debugPrint(path);
          setState(() {
            isRecordingCompleted = true;
            recordedPath = path;
          });
          debugPrint("Recorded file size: ${File(path).lengthSync()}");
        }
      } else {
        await recorderController.record(path: path!);
        // await recorderController.onCurrentDuration;
        // streamSubscription = recorderController.getCurrentTimeMillis.listen((position) {
        //       setState(() {
        //         this.position = position;
        //       });
        //     });
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void _refreshWave() {
    if (isRecording) recorderController.refresh();
  }
}
