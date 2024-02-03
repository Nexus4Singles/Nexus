import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/features/home/presentation/widgets/profile.dart';
import 'package:nexus/features/home/presentation/widgets/user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Column(
            children: [
              const ProfileTile(),
              const SizedBoxH15(),
              SizedBox(
                height: height(context) * .68,
                child: CardSwiper(
                  cardsCount: 10,
                  allowedSwipeDirection: const AllowedSwipeDirection.only(
                    up: false,
                    down: false,
                    right: true,
                    left: true,
                  ),
                  padding: const EdgeInsets.all(0),
                  cardBuilder:
                      (context, index, percentThresholdX, percentThresholdY) {
                    return UserCard(
                      age: '2$index',
                      name: 'Mercy John',
                      image: 'assets/images/user1.png',
                      location: 'Lagos, Nigeria',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
