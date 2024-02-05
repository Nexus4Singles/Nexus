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

class DesiredQualityScreen extends StatefulWidget {
  const DesiredQualityScreen({super.key});

  @override
  State<DesiredQualityScreen> createState() => _DesiredQualityScreenState();
}

class _DesiredQualityScreenState extends State<DesiredQualityScreen> {
  double currentpage = 50;
  // ignore: unused_local_variable
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Slider(
          value: currentpage,
          onChanged: (double) {
            setState(
              () {
                currentpage = 50;
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
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '    Desired Qualities',
                style: textStyle8.copyWith(
                    fontSize: 30, fontWeight: FontWeight.w700, color: black),
              ),
              SizedBoxH10(),
              const Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select 5 Qualities you value the most in the choice of \na life partner,  asides from Godliness  ',
                    ),
                  ],
                ),
              ),
              SizedBoxH20(),
              const Row(
                children: [
                  TContainer(text: 'Accountability'),
                  SizedBoxW5(),
                  TextContainer(text: 'Ambition'),
                  SizedBoxW5(),
                  TContainer(text: 'Attentiveness'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Authenticity'),
                  SizedBoxW10(),
                  TContainer(text: 'Calmness'),
                  SizedBoxW10(),
                  TextContainer(text: 'Charisma'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Commitment'),
                  SizedBoxW10(),
                  TContainer(text: 'Communication'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Compassion'),
                  SizedBoxW10(),
                  TextContainer(text: 'Confidence'),
                  SizedBoxW10(),
                  TextContainer(text: 'Consistency'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Courage'),
                  SizedBoxW5(),
                  TextContainer(text: 'Diligence'),
                  SizedBoxW5(),
                  TContainer(text: 'Dependability'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Discipline'),
                  SizedBoxW10(),
                  TContainer(text: 'Drive'),
                  SizedBoxW10(),
                  TContainer(text: 'Emotional Intelligence'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Empathy'),
                  SizedBoxW10(),
                  TContainer(text: 'Faithfulness'),
                  SizedBoxW10(),
                  TContainer(text: 'Family-Oriented'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Financial Stability'),
                  SizedBoxW10(),
                  TContainer(text: 'Friendliness'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Generosity'),
                  SizedBoxW10(),
                  TContainer(text: 'Honesty'),
                  SizedBoxW10(),
                  TContainer(text: 'Humility'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Independence'),
                  SizedBoxW10(),
                  TContainer(text: 'Integrity'),
                  SizedBoxW10(),
                  TContainer(text: 'Intelligence'),
                ],
              ),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Kindness'),
                  SizedBoxW10(),
                  TContainer(text: 'Leadership'),
                  SizedBoxW10(),
                  TContainer(text: 'Loyalty'),
                ],
              ),
              const SizedBoxH10(),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Maturity'),
                  SizedBoxW10(),
                  TContainer(text: 'Modesty'),
                  SizedBoxW10(),
                  TContainer(text: 'Obedience'),
                ],
              ),
              const SizedBoxH10(),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Open-Mindedness'),
                  SizedBoxW10(),
                  TContainer(text: 'Optimism'),
                  SizedBoxW10(),
                  TContainer(text: 'Patience'),
                ],
              ),
              const SizedBoxH10(),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Peacefulness'),
                  SizedBoxW10(),
                  TContainer(text: 'Prudence'),
                  SizedBoxW10(),
                  TContainer(text: 'Resilience'),
                ],
              ),
              const SizedBoxH10(),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Resourcefulness'),
                  SizedBoxW10(),
                  TContainer(text: 'Respect'),
                  TContainer(text: 'Responsibility'),
                ],
              ),
              const SizedBoxH10(),
              const SizedBoxH10(),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Self Awareness'),
                  SizedBoxW10(),
                  TContainer(text: 'Self Confidence'),
                ],
              ),
              const SizedBoxH10(),
              const SizedBoxH10(),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Self Control'),
                  SizedBoxW10(),
                  TContainer(text: 'Sense of Humour'),
                ],
              ),
              const SizedBoxH10(),
              const SizedBoxH10(),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Supportive'),
                  SizedBoxW10(),
                  TContainer(text: 'Teachability'),
                  SizedBoxW10(),
                  TContainer(text: 'Thoughtfulness'),
                ],
              ),
              const SizedBoxH10(),
              const SizedBoxH10(),
              const SizedBoxH10(),
              const Row(
                children: [
                  TContainer(text: 'Tolerance'),
                  SizedBoxW10(),
                  TContainer(text: 'Trustworthiness'),
                  SizedBoxW10(),
                  TContainer(text: 'Wisdom'),
                ],
              ),
              const SizedBoxH10(),
              CustomButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.uploadPhoto);
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
