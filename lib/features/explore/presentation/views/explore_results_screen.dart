import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/empty_state.dart';
import 'package:Nexus/core/utils/progress_indicator.dart';
import 'package:Nexus/features/explore/controllers/explore_ctr.dart';
import 'package:Nexus/features/home/presentation/views/user_details.dart';
import 'package:Nexus/features/match/presentation/widgets/matched_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreResultsScreen extends StatelessWidget {
  ExploreResultsScreen({
    super.key,
  });

  final ctr = Get.put(ExploreCtr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Explore',
          style: textStyle18.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 0.0,
          left: 16.0,
          right: 16.0,
          bottom: 0.0,
        ),
        child: Obx(
          () => Column(
            children: [
              Text(
                'Search Results',
                style: textStyle14.copyWith(
                  color: dustyGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBoxH20(),
              Expanded(
                child: ctr.isLoading.value
                    ? const Center(
                        child: CustomCircularProgressIndicator(),
                      )
                    : ctr.exploreError.value.isNotEmpty
                        ? SizedBox(
                            height: Get.height / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: EmptyStateWidget(
                                    message: ctr.exploreError.value,
                                    showClose: false,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            mainAxisSpacing: 15.sp,
                            crossAxisSpacing: 10.sp,
                            childAspectRatio: 0.65,
                            children: [
                              ...ctr.searchedUsers.map((element) {
                                return MatchedUserCard(
                                  photo: element.photos != null &&
                                          element.photos!.isNotEmpty
                                      ? element.photos![0]
                                      : 'https://i.pinimg.com/474x/76/68/4a/76684ac1fccf120998c15dcc094a07ad.jpg',
                                  name: element.username,
                                  age: element.age.toString(),
                                  location: element.location!.place!,
                                  onPress: () {
                                    Get.to(
                                      () => UserDetailScreen(
                                        userModel: element,
                                      ),
                                    );
                                  },
                                );
                              })
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
