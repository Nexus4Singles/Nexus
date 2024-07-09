import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/empty_state.dart';
import 'package:nexus/core/utils/progress_indicator.dart';
import 'package:nexus/features/match/controllers/matches_ctr.dart';
import 'package:nexus/features/match/presentation/widgets/match_stat.dart';
import 'package:nexus/features/match/presentation/widgets/matched_user.dart';

import '../../../../router.dart';
import '../../../home/presentation/views/user_details.dart';

class MatcheScreen extends StatefulWidget {
  const MatcheScreen({super.key});

  @override
  State<MatcheScreen> createState() => _MatcheScreenState();
}

class _MatcheScreenState extends State<MatcheScreen> {
  var ctr = Get.put(MatchesCtr());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox.shrink(),
        title: Text(
          'Potential Matches',
          style: textStyle18.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            child: SvgPicture.asset('assets/icons/adjust.svg'),
            onTap: () {
              Get.toNamed(AppRoutes.settings);
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              children: [
                Text(
                  'This is a list of of users you have liked,  users who liked  your profile, as well as profiles you have saved.',
                  style: textStyle12.copyWith(),
                  textAlign: TextAlign.center,
                ),
                const SizedBoxH20(),
                MatchStats(),
                const SizedBoxH20(),
                Obx(
                  () => ctr.isLoading.value
                      ? const CustomCircularProgressIndicator()
                      : Expanded(
                          child: ctr.userData.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 100.0),
                                  child: EmptyStateWidget(
                                    message: ctr.emptyText.value,
                                  ),
                                )
                              : GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  mainAxisSpacing: 15.sp,
                                  crossAxisSpacing: 10.sp,
                                  childAspectRatio: 0.65,
                                  children: [
                                      ...ctr.userData.map((element) {
                                        return MatchedUserCard(
                                          photo: element.photos![0],
                                          name: element.username,
                                          age: element.age.toString(),
                                          location: element.location!.place!,
                                          onPress: () {
                                            Get.to(() => UserDetailScreen(
                                                userModel: element));
                                          },
                                        );
                                      })
                                    ]),
                        ),
                ),
                const SizedBoxH20(),
              ],
            ),
          ),
          // const ComingSoonWidget(
          //   text:
          //       'You will be able to view the list of users who have liked your profile here. ',
          // ),
        ],
      ),
    );
  }
}
