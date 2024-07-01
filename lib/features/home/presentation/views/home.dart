import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:nexus/features/home/presentation/widgets/coming_soon_modal.dart';
import 'package:nexus/features/home/presentation/widgets/profile_tile.dart';
import 'package:nexus/features/home/presentation/widgets/user_card.dart';
import 'package:nexus/features/match/controllers/matches_ctr.dart';
import 'package:nexus/features/profile/presentation/widgets/compatibility_modal.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/shared_pref.dart';
import '../../../explore/controllers/explore_ctr.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ctr = Get.put(ExploreCtr());
  final matchCtr = Get.put(MatchesCtr());

  CardSwiperController cardSwiperController = CardSwiperController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  FutureOr _init() async {
    await Provider.of<HomeNotifier>(context, listen: false).getProfile();
    var currentUser =
        Provider.of<HomeNotifier>(context, listen: false).currentUser!;
    SharedPref.setString("email", currentUser.email);
    if (currentUser.compatibilitySetted == null ||
        currentUser.compatibilitySetted == false) {
      await Future.delayed(const Duration(seconds: 5), () {
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cardSwiperController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(
      builder: (context, model, _) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15.sp),
              child: Column(
                children: [
                  if (model.currentUser != null) ProfileTile(model: model),
                  const SizedBoxH15(),
                  if (model.currentUser != null && model.allUsers.isNotEmpty)
                    SizedBox(
                      height: Get.height / 1.3,
                      child: model.allUsers.length == 1
                          ? UserCard(
                              userModel: model.allUsers.first,
                              onClosed: () {
                                showModal();
                              },
                              onLike: () {
                                showModal();
                              },
                              onRefresh: () {
                                showModal();
                              },
                              onSaved: () {
                                showModal();
                              },
                              onClick: () {
                                setState(() {
                                  model.selectedUser = model.allUsers.first;
                                });
                                // Get.toNamed(AppRoutes.userDetails);
                              },
                            )
                          : CardSwiper(
                              numberOfCardsDisplayed: 1,
                              cardsCount: model.allUsers.length,
                              controller: cardSwiperController,
                              isLoop: true,
                              onSwipeDirectionChange: (direction, directions) {
                                print("THis is first $direction $directions");
                              },
                              allowedSwipeDirection:
                                  const AllowedSwipeDirection.only(
                                up: false,
                                down: false,
                                right: true,
                                left: true,
                              ),
                              padding: const EdgeInsets.all(0),
                              cardBuilder: (context, index, percentThresholdX,
                                  percentThresholdY) {
                                UserModel user = model.allUsers[index];
                                return SingleChildScrollView(
                                  child: UserCard(
                                    userModel: user,
                                    onClosed: () {
                                      matchCtr.addToUnRecommend(user.id);
                                      cardSwiperController
                                          .swipe(CardSwiperDirection.left);
                                      model.getUsers();
                                    },
                                    onLike: () {
                                      ctr.myProfile.value.matchedUsers ==
                                                  null ||
                                              !ctr.myProfile.value.matchedUsers!
                                                  .contains(user.id)
                                          ? matchCtr.toggleLike(user)
                                          : print("This users are matched");
                                    },
                                    onRefresh: () {
                                      cardSwiperController.undo();
                                    },
                                    onSaved: () {
                                      matchCtr.toggleSave(user.id);
                                    },
                                    onClick: () {},
                                  ),
                                );
                              },
                            ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showModal() {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog.adaptive(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: const ComingSoonModal(
            text:
                'You will be able to view profile recommendations here as soon as we launch fully.',
          ),
        );
      },
    );
  }
}
