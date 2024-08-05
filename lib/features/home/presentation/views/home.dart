import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/empty_state.dart';
import 'package:nexus/features/home/controllers/home_controller.dart';
import 'package:nexus/features/home/controllers/notification_controller.dart';
import 'package:nexus/features/home/presentation/change_notifier/bottom_nav.dart';
import 'package:nexus/features/home/presentation/widgets/profile_tile.dart';
import 'package:nexus/features/home/presentation/widgets/user_card.dart';
import 'package:nexus/features/match/controllers/matches_ctr.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/modals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final matchCtr = MatchesCtr.instance;
  final homeCtr = HomeController.instance;
  CardSwiperController cardSwiperController = CardSwiperController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  FutureOr _init() async {
    NotificationController.instance.getAllNotifications();
    await homeCtr.getFilteredUsers(true);
    await Future.delayed(const Duration(seconds: 5), () {
      if (homeCtr.user.value.compatibilitySetted == null ||
          homeCtr.user.value.compatibilitySetted == false) {
        compatibilityQuestions(context);
        debugPrint(
            "Check for compatibiliity status with this ${homeCtr.user.value.compatibilitySetted}");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cardSwiperController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Obx(
            () => ListView(
              children: [
                ProfileTile(),
                const SizedBoxH20(),
                Center(
                  child: Text(
                    "Recommendations For You",
                    style: textStyle18.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBoxH10(),
                if (homeCtr.allUsers.isEmpty)
                  SizedBox(
                    height: Get.height / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EmptyStateWidget(
                            showClose: false,
                            headerText: "That’s it for today!!",
                            buttonText: "Go to Explore",
                            buttonFunc: () async {
                              await Provider.of<BottomNavModel>(context,
                                      listen: false)
                                  .updateIndex(1);
                            },
                            message:
                                "Check back tomorrow or Use the explore page to search and filter more profiles globally"),
                      ],
                    ),
                  )
                else
                  SizedBox(
                    height: Get.height / 1.3,
                    child: CardSwiper(
                      numberOfCardsDisplayed: 1,
                      cardsCount: homeCtr.allUsers.length,
                      controller: cardSwiperController,
                      isLoop: false,
                      onEnd: () {
                        homeCtr.allUsers.assignAll([]);
                      },
                      onSwipe: (int previousIndex, int? currentIndex,
                          CardSwiperDirection direction) {
                        UserModel user = homeCtr.allUsers[currentIndex!];
                        if (direction == CardSwiperDirection.right) {
                          matchCtr.addToUnRecommend(user.id);
                        } else if (direction == CardSwiperDirection.left) {
                          matchCtr.toggleLike(user);
                        }
                        return true;
                      },
                      allowedSwipeDirection: const AllowedSwipeDirection.only(
                        up: false,
                        down: false,
                        right: true,
                        left: true,
                      ),
                      // duration: const Duration(milliseconds: 10),
                      padding: const EdgeInsets.all(0),
                      cardBuilder: (context, index, percentThresholdX,
                          percentThresholdY) {
                        UserModel user = homeCtr.allUsers[index];
                        // homeCtr.getFilteredUsers(true);
                        return SingleChildScrollView(
                          child: UserCard(
                            userModel: user,
                            onClosed: () async {
                              await matchCtr
                                  .addToUnRecommend(user.id)
                                  .then((val) {
                                cardSwiperController.moveTo(index + 1);
                              });
                            },
                            onLike: () {
                              matchCtr.ctr.myProfile.value.matchedUsers ==
                                          null ||
                                      !matchCtr
                                          .ctr.myProfile.value.matchedUsers!
                                          .contains(user.id)
                                  ? matchCtr.toggleLike(user).then((val) {
                                      cardSwiperController.moveTo(index + 1);
                                    })
                                  : debugPrint("This users are matched");
                            },
                            onRefresh: () {
                              matchCtr.undoUnRecommend(
                                  true, cardSwiperController);
                            },
                            onSaved: () {
                              matchCtr.toggleSave(user.id).then((val) {});
                            },
                            onClick: () {},
                          ),
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
