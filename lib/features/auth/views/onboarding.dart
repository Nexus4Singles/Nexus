import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();

  // late Timer _autoScrollTimer;

  final List<Map<String, dynamic>> _pagesModel = [
    {
      'id': '1',
      "title": "Create a Profile",
      "subtitle":
          "As part of your profile set up, you will be required to make audio recordings answering a few questions. \n\nThese questions require highly subjective and personal responses. Hence, seeking external help to answer them will be unnecessary. \n\nThis is to limit unbelievers as much as possible from joining this platform and to ensure users align with your thought process before connecting with you.",
      "image": iOnboard1,
    },
    {
      'id': '2',
      "title": "Search Profile",
      "subtitle":
          "Your profile and audio recordings will only be accessible to users of the opposite gender. \n\nYou will also be able to view profiles and connect with opposite gender users from your country who live in the diaspora. \n\nNexus is currently designed only for Nigerian Christian singles all over the world.",
      "image": iOnboard2,
    },
    {
      'id': '3',
      "title": "Find your Match",
      "subtitle":
          "You will receive notifications of opposite gender users who have liked your profile. \n\nHowever, they would not be able to connect with you until you have equally viewed and liked their profiles, which automatically leads to a MATCH. \n\nThis is to ensure only users you approve of are able to connect with you.",
      "image": iOnboard3,
    },
    {
      'id': '4',
      "title": "Chat",
      "subtitle":
          "You will only be able to chat with your MATCH list. This means random users will not be able to send messages to you.\n\nThis is not just another dating app or match-making platform, but a tool to help Christian singles seeking Godly relationships leading to marriage, find and connect with each other. \n\nWe provide the visibility you need, while the rest of the work is in your hands.\nWe wish you GODSPEED!!",
      "image": iOnboard4,
    },
  ];

  @override
  void initState() {
    // _autoScrollTimer = Timer.periodic(
    //   const Duration(seconds: 3),
    //   (timer) {
    //     if (_pageController.page!.floor() == (_pagesModel.length - 1)) {
    //       _autoScrollTimer.cancel();
    //       return;
    //     }

    //     _pageController.nextPage(
    //       duration: const Duration(milliseconds: 500),
    //       curve: Curves.fastOutSlowIn,
    //     );
    //   },
    // );
    super.initState();
  }

  @override
  void dispose() {
    // _autoScrollTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            primary,
            secondary,
            secondary2,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: PageView(
            controller: _pageController,
            children: _pagesModel.map((pageData) {
              return OnBoardingPage(
                map: pageData,
                controller: _pageController,
                count: _pagesModel.length,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final Map<String, dynamic> map;
  final PageController controller;
  final int count;
  const OnBoardingPage({
    super.key,
    required this.map,
    required this.controller,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: BackButton(
              color: white,
            ),
          ),
          const SizedBoxH15(),
          Column(
            children: [
              CircleAvatar(
                backgroundColor: white,
                foregroundColor: primary,
                child: Text(
                  map['id'],
                ),
              ),
              const SizedBoxH20(),
              Image.asset(map['image']),
              const SizedBoxH20(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    map['title'],
                    style: headerStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBoxH20(),
                  Text(
                    map['subtitle'],
                    style: textStyle14,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBoxH20(),
                  if (map['id'] != '4')
                    Text(
                      'Please Swipe',
                      style: textStyle14.copyWith(
                        color: white,
                      ),
                    ),
                  const SizedBoxH20(),
                  map['id'] == '4'
                      ? CustomButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.authHandler);
                          },
                          text: 'Get Started',
                        )
                      : SmoothPageIndicator(
                          controller: controller,
                          count: count,
                          effect: const ExpandingDotsEffect(
                            dotColor: Color(0xFFD6DAE1),
                            activeDotColor: primary,
                            dotHeight: 8,
                            dotWidth: 8,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
