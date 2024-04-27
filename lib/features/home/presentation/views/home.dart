import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
import 'package:nexus/core/models/user.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
// import 'package:nexus/features/home/presentation/change_notifier/bottom_nav.dart';
import 'package:nexus/features/home/presentation/change_notifier/home_notifier.dart';
import 'package:nexus/features/home/presentation/widgets/coming_soon_modal.dart';
import 'package:nexus/features/home/presentation/widgets/profile_tile.dart';
import 'package:nexus/features/home/presentation/widgets/user_card.dart';
import 'package:nexus/features/profile/presentation/widgets/compatibility_modal.dart';
import 'package:pinput/pinput.dart';
// import 'package:nexus/router.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/shared_pref.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CardSwiperController cardSwiperController = CardSwiperController();
  // Map<String, dynamic> pageArgu = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  FutureOr _init() async {
    await Provider.of<HomeNotifier>(context, listen: false).getProfile();
    // if (pageArgu['fromSignUp']) {
    //   Provider.of<BottomNavModel>(context).(4);
    // } else {}
    var currentUser =
        Provider.of<HomeNotifier>(context, listen: false).currentUser!;
    SharedPref.setString("email", currentUser.email);
    if (currentUser.compatibilitySetted == null ||
        currentUser.compatibilitySetted == false) {
      Future.delayed(const Duration(seconds: 5), () {
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
                  if (model.currentUser != null)
                    ProfileTile(
                      model: model,
                    ),
                  const SizedBoxH15(),
                  // TextButton(
                  //     onPressed: () {
                  //       showAdaptiveDialog(
                  //         context: context,
                  //         barrierDismissible: true,
                  //         builder: (context) {
                  //           return AlertDialog.adaptive(
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(20),
                  //             ),
                  //             content: const ComingSoonModal(
                  //               text:
                  //                   'You will be able to view profile recommendations here as soon as we launch fully.',
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     },
                  //     child: Text('show modal')),
                  // const SizedBoxH15(),
                  if (model.currentUser != null && model.allUsers.isNotEmpty)
                    SizedBox(
                      height: height(context) * .68,
                      child: model.allUsers.length == 1
                          ? UserCard(
                              age: model.allUsers.first.age.toString(),
                              name: model.allUsers.first.username,
                              image: model.allUsers.first.profileUrl!,
                              location:
                                  '${model.allUsers.first.city}, ${model.allUsers.first.country}',
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
                              cardsCount: model.allUsers.length,
                              controller: cardSwiperController,
                              isLoop: false,
                              allowedSwipeDirection:
                                  const AllowedSwipeDirection.only(
                                up: false,
                                down: false,
                                right: false,
                                left: false,
                              ),
                              padding: const EdgeInsets.all(0),
                              cardBuilder: (context, index, percentThresholdX,
                                  percentThresholdY) {
                                UserModel user = model.allUsers[index];
                                return UserCard(
                                  age: user.age.toString(),
                                  name: user.username,
                                  image: user.profileUrl!,
                                  location: '${user.city}, ${user.country}',
                                  onClosed: () {
                                    showModal();
                                    // if (model.allUsers.length == (index + 1)) {
                                    // } else {
                                    //   cardSwiperController
                                    //       .swipe(CardSwiperDirection.left);
                                    // }
                                  },
                                  onLike: () {
                                    showModal();
                                  },
                                  onRefresh: () {
                                    showModal();
                                    // cardSwiperController
                                    //     .swipe(CardSwiperDirection.right);
                                  },
                                  onSaved: () {
                                    showModal();
                                  },
                                  onClick: () {
                                    setState(() {
                                      model.selectedUser = user;
                                    });
                                    // Get.toNamed(AppRoutes.userDetails);
                                    // Logger().d(model.selectedUser!.toJson());
                                  },
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
