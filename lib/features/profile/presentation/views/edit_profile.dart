import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/features/profile/presentation/widgets/row_container.dart';
import 'package:nexus/features/profile/presentation/widgets/text_container.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Edit Profile',
          style: textStyle18.copyWith(
              fontSize: 24, fontWeight: FontWeight.w700, color: black),
        ),
        centerTitle: true,
        foregroundColor: black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: white), shape: BoxShape.circle),
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        maxRadius: 50,
                        backgroundImage: AssetImage('assets/images/user.png'),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 0,
                        child: CircleAvatar(
                          maxRadius: 15,
                          backgroundColor: primary,
                          foregroundColor: white,
                          child: SvgPicture.asset('assets/icons/pen.svg',
                              fit: BoxFit.contain),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBoxH20(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hobbies / Interests',
                  style: textStyle18.copyWith(
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                ),
                SvgPicture.asset('assets/icons/edit.svg')
              ],
            ),
            const SizedBoxH10(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextContainer(text: 'Music'),
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
                SvgPicture.asset('assets/icons/edit.svg')
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const RowContainer(
                    text: 'Ayodele', svg: 'assets/icons/edit.svg'),
                Container(
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '31',
                        style: textStyle16.copyWith(
                            fontWeight: FontWeight.w700, color: black),
                      ),
                      const SizedBoxW20(),
                      SvgPicture.asset('assets/icons/arrow.svg')
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
              height: 10,
              color: white,
            ),
            const RowContainer(
                text: 'Doctorate Degree', svg: 'assets/icons/arrow.svg'),
            const Divider(
              color: white,
              height: 10,
            ),
            const RowContainer(text: 'Lawyer', svg: 'assets/icons/arrow.svg'),
            const Divider(
              color: white,
              height: 10,
            ),
            const RowContainer(
                text: 'Celebration Church', svg: 'assets/icons/edit.svg'),
            const Divider(
              color: white,
              height: 10,
            ),
            const RowContainer(
                text: 'Berlin, Germany', svg: 'assets/icons/edit.svg')
          ],
        ),
      ),
    );
  }
}
