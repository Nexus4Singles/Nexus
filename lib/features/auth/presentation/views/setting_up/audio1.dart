import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';
// import 'package:lottie/lottie.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/core/utils/toast.dart';
import 'package:nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:nexus/features/auth/presentation/widgets/seek_bar.dart';
import 'package:nexus/router.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart' as rx;
// import 'package:wave/config.dart';
// import 'package:wave/wave.dart';

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
  bool isPlaying = false;
  bool isLoading = true;
  bool recordingCompleted = false;
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
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: true,
          title: SizedBox(
            width: width(context) * .5,
            child: LinearProgressIndicator(
              value: 0.7,
              backgroundColor: newGrey,
              color: primary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  if (recordingCompleted) {
                    Get.toNamed(AppRoutes.audio2);
                  } else {
                    AppToast().showErrorToast('Audio must be upto 60 secs');
                  }
                },
                child: Text(
                  'Next',
                  style: textStyle14.copyWith(
                      fontWeight: FontWeight.w700, color: black),
                ),
              ),
            ),
            const SizedBoxW20(),
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
                      'How would you describe your current relationship with God \nand why is this relationship important to you ? ',
                      style: textStyle12.copyWith(
                          fontWeight: FontWeight.w700, height: 2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBoxH30(),
                  if (!isRecording && !isRecordingCompleted)
                    Column(
                      children: [
                        Text(
                          '00:00',
                          style: textStyle18.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w200,
                              color: friendGrey),
                        ),
                        const SizedBoxH10(),
                        // SvgPicture.asset(
                        //   'assets/icons/audio1.svg',
                        // ),
                      ],
                    ),
                  if (isRecordingCompleted)
                    Column(
                      children: [
                        StreamBuilder<Duration?>(
                          stream: player.durationStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            return Text(
                              '${snapshot.data!.inMinutes.toString()}:${snapshot.data!.inSeconds.toString()}',
                              style: textStyle18.copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w200,
                                  color: friendGrey),
                            );
                          },
                        ),
                        // if (isPlaying) Lottie.asset('assets/images/wave.json'),
                        // if (!isPlaying)
                        //   Padding(
                        //     padding: EdgeInsets.only(top: 10.sp),
                        //     child: SvgPicture.asset(
                        //       'assets/icons/audio1.svg',
                        //     ),
                        //   ),
                        Row(children: [
                          Expanded(
                            child: StreamBuilder<PositionData>(
                              stream: _positionDataStream,
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                return SeekBar(
                                  duration:
                                      positionData?.duration ?? Duration.zero,
                                  position:
                                      positionData?.position ?? Duration.zero,
                                  bufferedPosition:
                                      positionData?.bufferedPosition ??
                                          Duration.zero,
                                  onChangeEnd: (newPosition) {
                                    player.seek(newPosition);
                                    setState(() {
                                      isPlaying = false;
                                    });
                                  },
                                  onChanged: (value) {
                                    // if (value.inSeconds == 10) {
                                    Logger().d(value.inSeconds.toString());
                                    // }
                                  },
                                );
                              },
                            ),
                          ),
                        ]),
                        // StreamBuilder<Duration?>(
                        //   stream: player.durationStream,
                        //   builder: (context, snapshot) {
                        //     if (!snapshot.hasData) {
                        //       return Container();
                        //     }
                        //     return Text(
                        //       '${snapshot.data!.inMinutes.toString()}:${snapshot.data!.inSeconds.toString()}',
                        //       style: textStyle18.copyWith(
                        //           fontSize: 28,
                        //           fontWeight: FontWeight.w200,
                        //           color: friendGrey),
                        //     );
                        //   },
                        // ),
                        //   ],
                        // ),
                      ],
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
                              '0${snapshot.data!.inHours.toString()}:0${snapshot.data!.inMinutes.toString()}:${snapshot.data!.inSeconds.toString()}',
                              style: textStyle18.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w200,
                                color: friendGrey,
                              ),
                            );
                          },
                        ),
                        const SizedBoxH30(),
                        if (!isRecordingCompleted)
                          // Lottie.asset('assets/images/wave.json'),
                          AudioWaveforms(
                            recorderController: recorderController,
                            size: Size(width(context) * .5, 100.h),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isRecording = false;
                          isRecordingCompleted = false;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: warGrey,
                        child: SvgPicture.asset(
                          'assets/icons/refresh.svg',
                          color: primary,
                        ),
                      ),
                    ),
                    const SizedBoxW40(),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (isRecordingCompleted) {
                            if (player.playing) {
                              player.pause();
                              // Logger().d(player.p);
                              // player.bufferedPositionStream.
                              setState(() {
                                isPlaying = false;
                              });
                            } else {
                              player.play();
                              setState(() {
                                isPlaying = true;
                              });
                              audioStream();
                            }
                          } else {
                            _startOrStopRecording(model);
                          }
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: warGrey,
                          child: CircleAvatar(
                            backgroundColor: primary,
                            radius: 30,
                            child: isRecordingCompleted
                                ? Icon(
                                    isPlaying ? Iconsax.pause : Iconsax.play,
                                    color: white,
                                  )
                                : Icon(
                                    isRecording
                                        ? Iconsax.pause
                                        : Iconsax.microphone,
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
    });
  }

  AudioPlayer player = AudioPlayer();
  late Duration duration;
  late Duration playerPosition;

  void _setAudioPlayer(String audioPath) {
    player.setFilePath(audioPath);

    player.durationStream.listen((d) {
      Logger().d('durationstream');
      duration = d!;
    });

    player.positionStream.listen((p) {
      playerPosition = p;
    });
  }

  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  void _startOrStopRecording(AuthNotifier model) async {
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
          _setAudioPlayer(path);
          model.setAudio1(path);
          debugPrint("Recorded file size: ${model.audioPath1}");
        }
      } else {
        await recorderController.record(path: path!);
        Timer(Duration(seconds: model.recordingEndSecs), () {
          _stopRecording(model);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void _stopPlaying() {
    setState(() {
      isPlaying = false;
    });
  }

  void _stopRecording(AuthNotifier model) async {
    recorderController.reset();

    final path = await recorderController.stop(false);

    if (path != null) {
      debugPrint(path);
      setState(() {
        isRecordingCompleted = true;
        recordedPath = path;
        recordingCompleted = true;
      });
      _setAudioPlayer(path);

      model.setAudio1(path);
      debugPrint("Recorded file size: ${model.audioPath1}");
    }
  }

  void _refreshWave() {
    if (isRecording) recorderController.refresh();
  }

  void audioStream() {
    player.playerStateStream.listen((state) {
      if (state.playing) {
      } else {}
      switch (state.processingState) {
        case ProcessingState.idle:
          {
            Logger().d('idle');
          }
          break;
        case ProcessingState.loading:
          {
            Logger().d('loading');
          }
          break;
        case ProcessingState.buffering:
          {
            Logger().d('buffering');
          }
          break;
        case ProcessingState.ready:
          {
            Logger().d('ready');
          }
          break;
        case ProcessingState.completed:
          {
            Logger().d('completed');
            setState(() {
              isPlaying = false;
            });
            player.seek(Duration.zero);
            player.stop();
          }
          break;
      }
    });
  }
}
