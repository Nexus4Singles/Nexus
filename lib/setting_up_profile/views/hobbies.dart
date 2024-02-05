import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/profile/presentation/widgets/text_container.dart';
import 'package:nexus/router.dart';
import 'package:nexus/setting_up_profile/widgets/container.dart';

class HobbiesScreen extends StatefulWidget {
  const HobbiesScreen({super.key});

  @override
  State<HobbiesScreen> createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
  @override
  Widget build(BuildContext context) {
    double currentpage = 40;
    // ignore: unused_local_variable
    PageController pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Slider(
          value: currentpage,
          onChanged: (double) {
            setState(
              () {
                currentpage = 40;
              },
            );
          },
          divisions: 12,
          max: 120,
          thumbColor: primary,
          activeColor: primary,
          inactiveColor: grey,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hobbies/Interests',
                style: textStyle8.copyWith(
                    fontSize: 30, fontWeight: FontWeight.w700, color: black),
              ),
              SizedBoxH10(),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Select up to 5 interests/hobbies to let users know \nwhat you are passionate about. ',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBoxH20(),
              const Row(
                children: [
                  TextContainer(text: 'action'),
                  SizedBoxW10(),
                  TContainer(text: 'art'),
                  SizedBoxW10(),
                  TContainer(text: 'beauty'),
                  SizedBoxW10(),
                  TContainer(text: 'Business'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Comedy'),
                  SizedBoxW10(),
                  TextContainer(text: 'Cooking'),
                  SizedBoxW10(),
                  TContainer(text: 'Cycling'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Comedy'),
                  SizedBoxW10(),
                  TContainer(text: 'Cycling'),
                  SizedBoxW10(),
                  TextContainer(text: 'Cooking'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TextContainer(text: 'Events Planning'),
                  SizedBoxW10(),
                  TContainer(text: 'Fasion'),
                  SizedBoxW10(),
                  TContainer(text: 'Fitness'),
                  SizedBoxW10(),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Food'),
                  SizedBoxW10(),
                  TextContainer(text: 'Game'),
                  SizedBoxW10(),
                  TContainer(text: 'Hiking'),
                  SizedBoxW10(),
                  TContainer(text: 'Investment'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Ministry'),
                  SizedBoxW10(),
                  TContainer(text: 'Movies'),
                  SizedBoxW10(),
                  TContainer(text: 'Music'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Languages'),
                  SizedBoxW10(),
                  TContainer(text: 'Photography'),
                  SizedBoxW10(),
                  TContainer(text: 'Photography'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Politics'),
                  SizedBoxW10(),
                  TContainer(text: 'Public Speaking'),
                  SizedBoxW10(),
                  TContainer(text: 'Reading'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Singing'),
                  SizedBoxW10(),
                  TContainer(text: 'Social Media'),
                  SizedBoxW10(),
                  TContainer(text: 'Sports'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Swimming'),
                  SizedBoxW10(),
                  TContainer(text: 'Teaching'),
                  SizedBoxW10(),
                  TContainer(text: 'Technology'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Travel'),
                  SizedBoxW10(),
                  TContainer(text: 'Volunteering'),
                  SizedBoxW10(),
                  TContainer(text: 'Writing'),
                ],
              ),
              CustomButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.desiredQuality);
                },
                child: Text(
                  'Next',
                  style: textStyle16.copyWith(color: white),
                ),
              ),
              const SizedBoxH20()
            ],
          ),
        ),
      ),
    );
  }
}
