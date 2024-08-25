import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import '../../../core/assets.dart';
import '../../../core/colors.dart';
import '../../../core/models/chats_model.dart';
import '../../../core/size_boxes.dart';
import '../../../core/text_field.dart';
import '../controllers/chat_ctr.dart';

class VideoWidget extends StatefulWidget {
  final File videoUrl;
  final ChatModel chatModel;

  VideoWidget({required this.videoUrl, required this.chatModel});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late CachedVideoPlayerPlusController _controller;
  final Map<String, CachedVideoPlayerPlusController>
      _videoPlayerControllerCache = {};
  final ctr = Get.put(ChatCtr());

  @override
  void initState() {
    super.initState();
    _controller = CachedVideoPlayerPlusController.file(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Ensure the first frame is shown
        _controller.play();
        _controller.setLooping(true); // Loop the video
        _controller.setVolume(1.0);
      });
  }

  @override
  void dispose() {
    _videoPlayerControllerCache.remove(widget.videoUrl);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              ctr.imageFile.value = File('');
              ctr.chatController.clear();
              Get.back();
            },
            icon: const CircleAvatar(
              backgroundColor: white,
              child: Icon(
                Icons.close,
                color: black,
                size: 20,
              ),
            )),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _controller.value.isInitialized
                  ? SizedBox(
                      height: Get.height / 2.0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CachedVideoPlayerPlus(_controller),
                          IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: Colors.black26,
                                  shape: BoxShape.circle),
                              child: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 20,
                                color: white,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  : const CircularProgressIndicator(strokeWidth: 1),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 32.0, top: 16, left: 12, right: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          fillColor: grey,
                          borderColor: Colors.transparent,
                          controller: ctr.chatController,
                          hintText: "Add a message"),
                    ),
                    const SizedBoxW10(),
                    InkWell(
                      onTap: () {
                        ctr.sendMessage(
                            widget.chatModel.messageID,
                            ctr.chatController.text,
                            widget.chatModel.userModel!);
                        Get.back();
                      },
                      child: CircleAvatar(
                          radius: 24,
                          backgroundColor: primary,
                          child: SvgPicture.asset('$svgPath/send.svg')),
                    )
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
