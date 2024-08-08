import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/empty_state.dart';
import 'package:Nexus/core/utils/modals.dart';
import 'package:Nexus/features/explore/presentation/views/explore.dart';
import 'package:Nexus/features/home/controllers/notification_controller.dart';
import 'package:Nexus/features/home/presentation/change_notifier/bottom_nav.dart';
import 'package:Nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:Nexus/features/home/presentation/widgets/profile_tile.dart';
import 'package:Nexus/features/home/presentation/widgets/user_card.dart';
import 'package:Nexus/features/match/controllers/matches_ctr.dart';
import 'package:Nexus/features/profile/presentation/widgets/compatibility_modal.dart';
import 'package:Nexus/features/subscription/helpers/subscription_helper.dart';
import 'package:Nexus/router.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/modals.dart';
import '../../../subscription/widgets/restriction_modal.dart';
import '../../../../core/utils/shared_pref.dart';
import '../../../subscription/provider/subscription_provider.dart';
import '../../../subscription/widgets/restriction_modal.dart';
import '../../controllers/home_controller.dart';
import 'nav.dart';

// Dont show accounts that have been liked.

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
    var currentUser = homeCtr.user.value;
    var subProvider =  Provider.of<SubscriptionProvider>(context, listen: false);
    subProvider.initSubDet(currentUser);
    SharedPref.setString("email", currentUser.email);
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
    final provider = context.read<SubscriptionProvider>();
    provider.initSubDet(provider.currentUser);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Obx(
            () => Column(
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
                  Expanded(
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
                          up: false, down: false, right: true, left: true),
                      // duration: const Duration(milliseconds: 10),
                      padding: const EdgeInsets.all(0),
                      cardBuilder: (context, index, percentThresholdX,
                          percentThresholdY) {
                        UserModel user = homeCtr.allUsers[index];

                        return UserCard(
                          userModel: user,
                          onClosed: () async {
                            await matchCtr
                                .addToUnRecommend(user.id)
                                .then((val) {
                              cardSwiperController.moveTo(index + 1);
                            });
                          },
                          onLike: () {
                            matchCtr.ctr.myProfile.value.matchedUsers == null ||
                                    !matchCtr.ctr.myProfile.value.matchedUsers!
                                        .contains(user.id)
                                ? matchCtr.toggleLike(user).then((val) {
                                    cardSwiperController.moveTo(index + 1);
                                  })
                                : debugPrint("This users are matched");
                          },
                          onRefresh: provider.onPremium ?
                              () {
                            matchCtr.undoUnRecommend(
                                true, cardSwiperController);
                          }
                              : (){
                            restrictionModal(context: context, dismisable: true,);
                          },
                          onSaved: provider.onPremium ? () {
                            matchCtr.toggleSave(user.id);
                          }: (){
                            restrictionModal(context: context, dismisable: true,);
                          },
                          onClick: () {},
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
