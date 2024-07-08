import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  var currentIndex = 0;
  final List<Map<String, dynamic>> _pagesModel = [
    {
      'id': '1',
      "title": "Create a Profile",
      "subtitle":
          "Part of the profile creation process requires users to make audio recordings answering 3 questions centered around their christian faith, marriage beliefs & personality. \n\nListening to the responses of different users will give you  insights into their beliefs & thought processes, beyond profile pictures & texts and this can help you to make informed decisions on who to connect with. \n\nIf you struggle with articulating your thoughts, we highly recommend improving on this before joining Nexus because your recordings will strongly determine how your profile is perceived by other users.",
      "image": iOnboard1,
    },
    {
      'id': '2',
      "title": "Search Profiles",
      "subtitle":
          "Your profile will only be visible to opposite gender users and you will also be able to directly search & view profiles of opposite gender users living in any country, with the option of filters to narrow down your search. \n\nOur goal is to ensure that any unmarried, widowed, or divorced Christian who has invested in personal growth, has a high chance of meeting a suitable partner on this app \n\nNexus is currently available to Nigerians living anywhere in the world, but we are scaling to other nationalities rapidly. Kindly stay patient if you are not Nigerian. ",
      "image": iOnboard2,
    },
    {
      'id': '3',
      "title": "Find your Match",
      "subtitle":
          "You will receive notifications of opposite gender users who have liked your profile. However, they would not be able to connect with you until you have equally viewed and liked their profiles, which automatically leads to a MATCH.\n\nThis is to preserve your privacy & security by ensuring  only users you approve of, are able to connect with you, which  makes it really difficult for people seeking flings or hookups to use this app for such purposes. \n\nYou will also be able to view a compatibility data that shows you more information about your compatibility with MATCHED users. ",
      "image": iOnboard3,
    },
    {
      'id': '4',
      "title": "Chat",
      "subtitle":
          "You will only be able to chat with your MATCH list. This means random users will not be able to send messages to you. \n\nThis is not just another match-making or dating app, Nexus is a platform to help devout Christian singles seeking Godly relationships leading to marriages, find and connect with each other. \n\nWe provide the visibility you need, while the rest is up to you, as you rely on the HolySpirit for discernment. \n\nWe wish you GODSPEED!!",
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: white,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            primary,
            secondary,
            secondary2,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (val) {
                  setState(() {
                    currentIndex = val;
                  });
                },
                children: _pagesModel.map((pageData) {
                  return OnBoardingPage(
                    map: pageData,
                    controller: _pageController,
                    count: _pagesModel.length,
                  );
                }).toList(),
              ),
            ),
            _pagesModel[currentIndex]['id'] == '4'
                ? const SizedBox()
                : Text(
                    'Please Swipe Left',
                    style: textStyle14.copyWith(color: white),
                  ),
            const SizedBoxH15(),
            _pagesModel[currentIndex]['id'] == '4'
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.authHandler);
                      },
                      text: 'Get Started',
                    ),
                  )
                : SmoothPageIndicator(
                    controller: _pageController,
                    count: _pagesModel.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Color(0xFFD6DAE1),
                      activeDotColor: primary,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
            const SizedBox(
              height: 32,
            )
          ],
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: white,
                foregroundColor: primary,
                child: Text(
                  map['id'],
                  style: textStyle18.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              const SizedBoxH20(),
              SvgPicture.asset(map['image']),
              const SizedBoxH20(),
              Text(
                map['title'],
                style: headerStyle.copyWith(
                  color: white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBoxH20(),
              Text(
                map['subtitle'],
                style: textStyle14.copyWith(color: white, fontSize: 13.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
