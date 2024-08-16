import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:rxdart/rxdart.dart' as rx;

import 'seek_bar.dart';

class AudioFilePlayer extends StatefulWidget {
  final AudioPlayer player;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  const AudioFilePlayer({
    super.key,
    required this.player,
    required this.onPlay,
    required this.onPause,
  });

  @override
  State<AudioFilePlayer> createState() => _AudioFilePlayerState();
}

class _AudioFilePlayerState extends State<AudioFilePlayer> {
  bool isPlaying = false;
  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          widget.player.positionStream,
          widget.player.bufferedPositionStream,
          widget.player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  void dispose() {
    widget.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          // SvgPicture.asset('assets/icons/play.svg'),
          InkWell(
            onTap: () {
              if (widget.player.playing) {
                widget.onPause();
                setState(() {
                  isPlaying = false;
                });
              } else {
                widget.onPlay();
                audioStream();
                setState(() {
                  isPlaying = true;
                });
              }
            },
            child: widget.player.processingState == ProcessingState.buffering
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      strokeWidth: 3,
                    ),
                  )
                : isPlaying
                    ? SvgPicture.asset("$svgPath/playing.svg", width: 56)
                    : SvgPicture.asset(
                        "$svgPath/play.svg",
                        width: 56,
                      ),
          ),
          const SizedBoxW10(),
          Expanded(
            child: StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition:
                      positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: (newPosition) {
                    widget.player.seek(newPosition);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   widget.player.dispose();
  // }

  void audioStream() {
    widget.player.playerStateStream.listen(
      (state) {
        if (state.playing) {
        } else {
          // setState(() {
          //   isPlaying = false;
          // });
        }
        switch (state.processingState) {
          case ProcessingState.idle:
            {
              setState(() {});
              // setState(() {
              //   isPlaying = false;
              // });
            }
            break;
          case ProcessingState.loading:
            {
              setState(() {});
              Logger().d('loading');
            }
            break;
          case ProcessingState.buffering:
            {
              setState(() {});
              Logger().d('buffering');
            }
            break;
          case ProcessingState.ready:
            {
              setState(() {});
              Logger().d('ready');
            }
            break;
          case ProcessingState.completed:
            {
              Logger().d('completed');
              setState(() {
                isPlaying = false;
              });
              widget.player.seek(Duration.zero);
              widget.player.stop();
            }
            break;
        }
      },
    );
  }
}
