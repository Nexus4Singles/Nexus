import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/profile/presentation/widgets/text_container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        leading: const SizedBox.shrink(),
        title: Text(
          'Profile',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/user.png',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ayodele, 31',
                      style: textStyle8.copyWith(
                          color: black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/location.svg'),
                        Text(
                          'Berlin, Germany',
                          style: textStyle16.copyWith(
                              fontWeight: FontWeight.w300, color: black),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Text(
              'About',
              style: textStyle12.copyWith(
                  fontWeight: FontWeight.w700, color: black),
            ),
            const SizedBoxH15(),
            Row(
              children: [
                Text(
                  'State of Origin :',
                  style: textStyle18.copyWith(
                      fontWeight: FontWeight.w500, color: ash),
                ),
                Text(
                  'Kaduna',
                  style: textStyle18.copyWith(
                      fontWeight: FontWeight.w500, color: black),
                ),
              ],
            ),
            const SizedBoxH10(),
            Row(
              children: [
                Text(
                  'Education Level :',
                  style: textStyle18.copyWith(
                      fontWeight: FontWeight.w500, color: ash),
                ),
                Text(
                  'Doctorate Degree',
                  style: textStyle18.copyWith(
                      fontWeight: FontWeight.w500, color: black),
                ),
              ],
            ),
            const SizedBoxH10(),
            Row(
              children: [
                Text(
                  'Profession/Industry :',
                  style: textStyle18.copyWith(
                      fontWeight: FontWeight.w500, color: ash),
                ),
                Text(
                  'Lawyer',
                  style: textStyle18.copyWith(
                      fontWeight: FontWeight.w500, color: black),
                ),
              ],
            ),
            const SizedBoxH20(),
            Text(
              'Hobbies / Interests',
              style: textStyle18.copyWith(
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
            const SizedBoxH10(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextContainer(
                  text: 'Music',
                ),
                SizedBoxW10(),
                TextContainer(text: 'Travel'),
                SizedBoxW10(),
                TextContainer(text: 'Wine'),
                SizedBoxW10(),
                TextContainer(text: 'Books'),
              ],
            ),
            const SizedBoxH10(),
            const TextContainer(text: 'Writng'),
            const SizedBoxH10(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Most Desired Qualities',
                  style: textStyle18.copyWith(
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                ),
              ],
            ),
            const SizedBoxH10(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextContainer(text: 'Diligence'),
                SizedBoxW10(),
                TextContainer(text: 'Empathy'),
                SizedBoxW10(),
                TextContainer(text: 'Thoughtfulness'),
                SizedBoxW10(),
              ],
            ),
            const SizedBoxH10(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextContainer(text: 'Self Control'),
                SizedBoxW10(),
                TextContainer(text: 'Intelligence'),
                SizedBoxW10(),
              ],
            ),
            const Divider(
              color: white,
              height: 10,
            ),
            Text(
              'Audio Recording',
              style: textStyle18.copyWith(
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
            const SizedBoxH15(),
            Text(
              '1. My salvation story ',
              style: textStyle14.copyWith(
                  color: black, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Container(
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/play.svg'),
                  const SizedBoxW10(),
                  SvgPicture.asset('assets/icons/wave.svg'),
                ],
              ),
            ),
            const SizedBoxH25(),
            Text(
              '2. My view on Gender roles in marriage ',
              style: textStyle14.copyWith(
                  color: black, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Container(
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/play.svg'),
                  const SizedBoxW10(),
                  SvgPicture.asset('assets/icons/wave.svg'),
                ],
              ),
            ),
            const SizedBoxH25(),
            Text(
              '3. My view  on  the financial stability of a potential \nspouse',
              style: textStyle14.copyWith(
                  color: black, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Container(
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/play.svg'),
                  const SizedBoxW10(),
                  SvgPicture.asset('assets/icons/wave.svg'),
                ],
              ),
            ),
            const SizedBoxH20(),
            Text(
              'Gallery',
              style: textStyle18.copyWith(
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/1.png', cacheWidth: 163),
                Image.asset('assets/images/2.png', cacheWidth: 163),
              ],
            ),
            const SizedBoxH10(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/3.png', cacheWidth: 163),
                Image.asset('assets/images/4.png', cacheWidth: 163),
              ],
            ),
            const SizedBoxH40(),
            const SizedBoxH40(),
          ],
        ),
      ),
    );
  }
}
