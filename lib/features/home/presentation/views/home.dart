import 'dart:async';
import 'dart:developer';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/features/subscription/widgets/restriction_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Nexus/core/models/user.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/empty_state.dart';
import 'package:Nexus/core/utils/modals.dart';
import 'package:Nexus/features/home/controllers/notification_controller.dart';
import 'package:Nexus/features/home/presentation/change_notifier/bottom_nav.dart';
import 'package:Nexus/features/home/presentation/widgets/profile_tile.dart';
import 'package:Nexus/features/home/presentation/widgets/user_card.dart';
import 'package:Nexus/features/match/controllers/matches_ctr.dart';
import 'package:Nexus/features/subscription/helpers/subscription_helper.dart';
import 'package:provider/provider.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../../../core/utils/shared_pref.dart';
import '../../../subscription/provider/subscription_provider.dart';
import '../../controllers/home_controller.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
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
    SharedPref.setString("email", currentUser.email);
    NotificationController.instance.getAllNotifications();
    await homeCtr.getFilteredUsers(true);
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeController = HomeController.instance;
      final user = homeController.user.value;
      var subProvider = Provider.of<SubscriptionProvider>(context, listen: false);
      await SubscriptionHelper.onValidateSubscription(subProvider, context);
      subProvider.initSubDet(user);
    });

    await Future.delayed(const Duration(seconds: 5), () {
      if (homeCtr.user.value.compatibilitySetted == null ||
          homeCtr.user.value.compatibilitySetted == false) {
        compatibilityQuestions(context);
        debugPrint(
            "Check for compatibiliity status with this ${homeCtr.user.value.compatibilitySetted}");
      }
    });
    //logger.i('after 5s');
  }

  @override
  void dispose() {
    super.dispose();
    cardSwiperController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('this is loggedinTime: ${homeCtr.explore.isTestMode}');

    // log('this is loggedinTime: ${homeCtr.loggedInTime.value}\nthis is dateTimeNow(): ${DateTime.now().toIso8601String()}');
    // log('this is the viewedCount: ${homeCtr.viewedCount}\nthis is the recommededList method: ${homeCtr.getRecommendedUsers().length}\nthis is the recommendedList getter: ${homeCtr.recommendationList.length}',
    //     name: 'state');

    // log('this is the calc time in hours: ${homeCtr.calculateTimeLeftToView()}\nthis is the countdown time: ${homeCtr.calculateCountDownTime().inHours}');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Consumer<SubscriptionProvider>(
            builder: (context, provider, child) {
              provider.initSubDet(homeCtr.user.value);
              return Obx(
                () => homeCtr.isLoading.value
                    ? const Center(
                        child: SizedBox(
                          width: 45,
                          height: 45,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: primary,
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (homeCtr.recommendedState() == RecommendedState.hasExceededForTheDay ||
                              homeCtr.recommendedState() == RecommendedState.hasNotExceededButEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Consumer<BottomNavModel>(builder: (context, model, _) {
                                  return EmptyStateWidget(
                                    showClose: false,
                                    height: Get.height * 0.3,
                                    headerText: homeCtr.recommendedState() ==
                                            RecommendedState.hasNotExceededButEmpty
                                        ? "That's It For Today!!"
                                        : "That's It For Now!!",
                                    buttonText: "Go to Explore",
                                    buttonFunc: () async {
                                      model.jumpToNavPage(1);
                                    },
                                    message:
                                        "Check Back Tomorrow or Use the Explore Page to Search & Filter Profiles Within Other Countries",
                                  );
                                }),
                                Builder(builder: (context) {
                                  return SlideCountdown(
                                    duration: -homeCtr.calculateCountDownTime(),
                                    separatorType: SeparatorType.title,
                                    slideDirection: SlideDirection.up,
                                    decoration: const BoxDecoration(color: Colors.transparent),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    separatorStyle: const TextStyle(),
                                    separatorPadding: EdgeInsets.symmetric(horizontal: 8.w),
                                  );
                                }),
                              ],
                            )
                          else
                            Expanded(
                              child: Column(
                                children: [
                                  ProfileTile(),
                                  const SizedBoxH20(),
                                  Center(
                                    child: Text(
                                      "Daily Recommendations For You",
                                      style: textStyle18.copyWith(
                                          color: Colors.black, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBoxH10(),
                                  Flexible(
                                    child: CardSwiper(
                                      numberOfCardsDisplayed: 1,
                                      cardsCount: homeCtr.recommendationList.length,
                                      controller: cardSwiperController,
                                      isLoop: false,
                                      isDisabled: homeCtr.explore.isTestMode.isTrue,
                                      onEnd: () {
                                        homeCtr.recommendationList.assignAll([]);
                                      },
                                      onSwipe: (int previousIndex, int? currentIndex,
                                          CardSwiperDirection direction) {
                                        UserModel user = homeCtr.recommendationList[currentIndex!];

                                        if (direction == CardSwiperDirection.right) {
                                          matchCtr.addToUnRecommend(user.id);
                                        } else if (direction == CardSwiperDirection.left) {
                                          matchCtr.toggleLike(user);
                                        }
                                        return true;
                                      },
                                      allowedSwipeDirection: const AllowedSwipeDirection.only(
                                          up: false, down: false, right: true, left: true),
                                      padding: const EdgeInsets.all(0),
                                      cardBuilder:
                                          (context, index, percentThresholdX, percentThresholdY) {
                                        UserModel user = homeCtr.recommendationList[index];

                                        return UserCard(
                                          userModel: user,
                                          isTestMode: homeCtr.explore.isTestMode.value,
                                          onClosed: () async {
                                            if (homeCtr.explore.isTestMode.isTrue) {
                                              comingSoonModal(
                                                  "You would be able to view profile recommendations when we launch",
                                                  context);
                                            } else {
                                              await matchCtr.addToUnRecommend(user.id).then((val) {
                                                cardSwiperController.moveTo(index + 1);
                                              });
                                            }
                                          },
                                          onLike: () {
                                            if (homeCtr.explore.isTestMode.isTrue) {
                                              comingSoonModal(
                                                  "You would be able to view profile recommendations when we launch",
                                                  context);
                                            } else {
                                              matchCtr.ctr.myProfile.value.matchedUsers == null ||
                                                      !matchCtr.ctr.myProfile.value.matchedUsers!
                                                          .contains(user.id)
                                                  ? matchCtr.toggleLike(user).then((val) {
                                                      cardSwiperController.moveTo(index + 1);
                                                    })
                                                  : debugPrint("These users are matched");
                                            }
                                          },
                                          onRefresh: ()=> _handleOnRefreshClickEvent(provider, user),
                                          onSaved: ()=> _handleOnSaveClickEvent(provider, user),
                                          onClick: () {},
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  _handleOnSaveClickEvent(SubscriptionProvider provider, UserModel user){
    if(provider.onPremium == true) {
      if(provider.isRestricted == true){
        restrictionModal(context: context, dismisable: true, showButton: false, text: 'Please'
            ' log in or switch to the Google Play Store Account/Apple ID account associated to your subscription\nRestart the app then head to Settings -> '
            'Your Subscription -> Restore Subscription.');
      } else if (provider.isRestricted == false){
        logger.i('toggke');
        matchCtr.toggleSave(user.id);
      }

    } else if (provider.onPremium == false) {
      if(provider.isRestricted == true){
        restrictionModal(context: context, dismisable: true, showButton: false, text: 'Please'
            ' log in or switch to the Google Play Store Account/Apple ID account associated to your subscription\nRestart the app then head to Settings -> '
            'Your Subscription -> Restore Subscription.');
      } else if (provider.isRestricted == false){
        restrictionModal(
          context: context,
          dismisable: true,
        );
      }

    }
  }

  _handleOnRefreshClickEvent(SubscriptionProvider provider, UserModel user){

    if(provider.onPremium == true) {
      if(provider.isRestricted == true){
        restrictionModal(context: context, dismisable: true, showButton: false, text: 'Please'
            ' log in or switch to the Google Play Store Account/Apple ID account associated to your subscription\nRestart the app then head to Settings -> '
            'Your Subscription -> Restore Subscription.');
      } else if (provider.isRestricted == false){
        matchCtr.undoUnRecommend(
            true, cardSwiperController);
      }

    } else if (provider.onPremium == false) {
      if(provider.isRestricted == true){
        restrictionModal(context: context, dismisable: true, showButton: false, text: 'Please'
            ' log in or switch to the Google Play Store Account/Apple ID account associated to your subscription\nRestart the app then head to Settings -> '
            'Your Subscription -> Restore Subscription.');
      } else if (provider.isRestricted == false){
        restrictionModal(
          context: context,
          dismisable: true,
        );
      }

    }
  }


}
