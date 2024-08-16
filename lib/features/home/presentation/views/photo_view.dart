import 'package:flutter/material.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:provider/provider.dart';
import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';

class PhotoViewScreen extends StatefulWidget {
  final int selectedIndex;
  final List<String> photos;
  const PhotoViewScreen({
    super.key,
    required this.selectedIndex,
    required this.photos,
  });

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(builder: (context, model, _) {
      return Scaffold(
        body: Stack(
          children: [
            StoryPageView(
              indicatorPadding:
                  const EdgeInsets.only(top: 50, left: 16, right: 16),
              initialPage: widget.selectedIndex,
              initialStoryIndex: (int pageIndex) {
                return widget.selectedIndex;
              },
              itemBuilder: (context, pageIndex, storyIndex) {
                final story = widget.photos[storyIndex];
                return Container(
                  color: black,
                  width: double.infinity,
                  height: height(context),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          StoryImage(
                            key: ValueKey(story),
                            imageProvider: NetworkImage(
                              story,
                            ),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: height(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              indicatorAnimationController: indicatorAnimationController,
              pageLength: 1,
              storyLength: (int pageIndex) {
                return widget.photos.length;
              },
              onPageLimitReached: () {
                Navigator.pop(context);
              },
            ),
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: CircleAvatar(
                  backgroundColor: white,
                  child: BackButton(
                    color: primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
