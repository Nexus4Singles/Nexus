import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/home/presentation/widgets/coming_soon.dart';
import 'package:nexus/features/match/presentation/widgets/match_stat.dart';
import 'package:nexus/features/match/presentation/widgets/matched_user.dart';

class MatcheScreen extends StatefulWidget {
  const MatcheScreen({super.key});

  @override
  State<MatcheScreen> createState() => _MatcheScreenState();
}

class _MatcheScreenState extends State<MatcheScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox.shrink(),
        title: Text(
          'Potential Matches',
          style: textStyle18.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: const Icon(
              Iconsax.setting_4,
            ),
          ),
          const SizedBoxW15(),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: .2,
            child: Padding(
              padding: EdgeInsets.all(15.sp),
              child: Column(
                children: [
                  Text(
                    'This is a list of of users you have liked,  users who liked  your profile, as well as profiles you have saved.',
                    style: textStyle12.copyWith(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBoxH20(),
                  const MatchStats(),
                  const SizedBoxH20(),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 15.sp,
                    crossAxisSpacing: 10.sp,
                    childAspectRatio: 0.65,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      2,
                      (index) {
                        return MatchedUserCard(
                          name: 'Modupe',
                          age: '25',
                          location: 'Vancouver, Canada',
                          onPress: () {},
                        );
                      },
                    ),
                  ),
                  const SizedBoxH20(),
                ],
              ),
            ),
          ),
          const ComingSoonWidget(
            text:
                'You will be able to view the list of users who have liked your profile here. ',
          ),
        ],
      ),
    );
  }
}
