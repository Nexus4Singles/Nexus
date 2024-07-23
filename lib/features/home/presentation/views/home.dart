import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/home/controllers/notification_controller.dart';
import 'package:nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:nexus/features/home/presentation/widgets/profile_tile.dart';
import 'package:nexus/features/home/presentation/widgets/user_card.dart';
import 'package:nexus/features/match/controllers/matches_ctr.dart';
import 'package:nexus/features/profile/presentation/widgets/compatibility_modal.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/shared_pref.dart';

// Dont show accounts that have been liked.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final matchCtr = Get.put(MatchesCtr());

  CardSwiperController cardSwiperController = CardSwiperController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  FutureOr _init() async {
    // final docRef = FirebaseFirestore.instance
    //     .collection(kUSER_KEY)
    //     // .where('id', isNotEqualTo: curUser!.uid);
    //     .where('registration_progress', isEqualTo: 'completed');
    // // .where('age', isGreaterThanOrEqualTo: minAge)
    // // .where('age', isLessThanOrEqualTo: maxAge);
    // docRef.snapshots().listen(
    //   (event) {
    //     final source = (event.metadata.hasPendingWrites) ? "Local" : "Server";
    //     print(
    //         "$source data: ${event.docs.map((doc) => UserModel.fromJson(doc.data())).toList()}");
    //   },
    //   onError: (error) => print("Listen failed: $error"),
    // );

    await Provider.of<HomeNotifier>(context, listen: false).getProfile();
    var currentUser =
        Provider.of<HomeNotifier>(context, listen: false).currentUser!;
    SharedPref.setString("email", currentUser.email);
    // NotificationController.instance.getAllNotifications();
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
              child: ListView(
                children: [
                  if (model.currentUser != null) ProfileTile(model: model),
                  const SizedBoxH20(),
                  Center(
                    child: Text(
                      "Recommendations For You",
                      style: textStyle18.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBoxH10(),
                  if (model.currentUser != null && model.allUsers.isNotEmpty)
                    SizedBox(
                      height: Get.height / 1.3,
                      child: model.allUsers.length == 1
                          ? UserCard(
                              userModel: model.allUsers.first,
                              onClosed: () {},
                              onLike: () {},
                              onRefresh: () {},
                              onSaved: () {},
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
                              onSwipe: (
                                int previousIndex,
                                int? currentIndex,
                                CardSwiperDirection direction,
                              ) {
                                UserModel user = model.allUsers[currentIndex!];
                                if (direction == CardSwiperDirection.right) {
                                  print("This is  $direction");
                                  matchCtr.addToUnRecommend(user.id);
                                } else if (direction ==
                                    CardSwiperDirection.left) {
                                  matchCtr.toggleLike(user);
                                }
                                return true;
                              },
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
                              // duration: const Duration(milliseconds: 10),
                              padding: const EdgeInsets.all(0),
                              cardBuilder: (context, index, percentThresholdX,
                                  percentThresholdY) {
                                UserModel user = model.allUsers[index];
                                return SingleChildScrollView(
                                  child: UserCard(
                                    userModel: user,
                                    onClosed: () async {
                                      await matchCtr.addToUnRecommend(user.id);
                                      cardSwiperController
                                          .swipe(CardSwiperDirection.left);
                                      await model.getUsers();
                                    },
                                    onLike: () {
                                      matchCtr.ctr.myProfile.value
                                                      .matchedUsers ==
                                                  null ||
                                              !matchCtr.ctr.myProfile.value
                                                  .matchedUsers!
                                                  .contains(user.id)
                                          ? matchCtr.toggleLike(user)
                                          : print("This users are matched");
                                    },
                                    onRefresh: () {
                                      matchCtr.undoUnRecommend(
                                          true, cardSwiperController);
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
}
