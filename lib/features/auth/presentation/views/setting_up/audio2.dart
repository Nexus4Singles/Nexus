import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/core/utils/helper.dart';
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

import '../../../../../core/assets.dart';

class Audio2Screen extends StatefulWidget {
  const Audio2Screen({super.key});

  @override
  State<Audio2Screen> createState() => _Audio2ScreenState();
}

class _Audio2ScreenState extends State<Audio2Screen> {
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
  Duration? recPosition = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _getDir();
    _initialiseControllers();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording2.m4a";
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

  // ignore: unused_element
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
    player.dispose();
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
              value: 0.8,
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
                    Get.toNamed(AppRoutes.audio3);
                  } else if (recPosition!.inSeconds.isGreaterThan(45) &&
                      isRecording == false) {
                    Get.toNamed(AppRoutes.audio3);
                  } else if (recPosition!.inSeconds.isGreaterThan(45)) {
                    AppToast()
                        .showErrorToast('Stop the audio below to continue');
                  } else {
                    AppToast().showErrorToast(
                        'Audio must be not be less than 45 secs');
                  }
                  debugPrint(
                      "is completed = > $recordingCompleted ${recPosition!.inSeconds}");
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
            children: [
              Center(
                child: Text(
                  'Audio Recordings',
                  style: textStyle8.copyWith(
                      fontSize: 30, fontWeight: FontWeight.w700, color: black),
                ),
              ),
              const Spacer(flex: 3),
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
                          '2',
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        'What are your thoughts on the role of a husband and a wife in marriage?',
                        style: textStyle12.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          height: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBoxH30(),
                  if (!isRecording && !isRecordingCompleted)
                    Column(
                      children: [
                        Text(
                          '00:00',
                          style: textStyle18.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: black),
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
                              '${snapshot.data!.inMinutes.toString()}:${BaseHelper.getTwoDigit(snapshot.data!.inSeconds) == '60' ? "00" : (BaseHelper.getTwoDigit(snapshot.data!.inSeconds))}',
                              style: textStyle18.copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: black),
                            );
                          },
                        ),
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
                              '${BaseHelper.getTwoDigit(snapshot.data!.inMinutes).toString()}:${BaseHelper.getTwoDigit(snapshot.data!.inSeconds).toString()}',
                              style: textStyle18.copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: black),
                            );
                          },
                        ),
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
              const Spacer(flex: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 80.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            resetPlayer();
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
                        InkWell(
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
                            debugPrint(
                                "is recording complete => $isRecordingCompleted ${player.playing}");
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: warGrey,
                            child: isRecordingCompleted
                                ? SvgPicture.asset(isPlaying
                                    ? "$svgPath/playing.svg"
                                    : "$svgPath/play.svg")
                                : SvgPicture.asset(isRecording
                                    ? "$svgPath/stop.svg"
                                    : "$svgPath/mic2.svg"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
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
    debugPrint("This has been called...");
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
          model.setAudio2(path);
          debugPrint("Recorded file size: ${model.audioPath2}");
        }
      } else {
        if (!recorderController.hasPermission) {
          //  recorderController.
        }
        // Future.delayed(Duration(seconds: 4));
        await recorderController.record(path: path!);

        _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
          setState(() {
            recPosition = Duration(seconds: recPosition!.inSeconds + 1);
          });
          if (recPosition!.inSeconds.isEqual(model.recordingEndSecs)) {
            _stopRecording(model);
          }
        });
        debugPrint("this is recording duration ${recPosition!.inSeconds}");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void resetPlayer() async {
    await recorderController.stop(true);
    _positionDataStream.listen((event) {
      event.position = Duration.zero;
      event.bufferedPosition = Duration.zero;
      event.duration = Duration.zero;
    });
    player.stop();
    _timer!.cancel();
    setState(() {
      isRecording = false;
      recordingCompleted = false;
      isRecordingCompleted = false;
      recPosition = Duration.zero;
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

      model.setAudio2(path);
      debugPrint("Recorded file size: ${model.audioPath2}");
    }
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
