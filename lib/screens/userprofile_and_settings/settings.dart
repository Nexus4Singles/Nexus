import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/router.dart';
import 'package:nexus/screens/userprofile_and_settings/login_modal_sheet.dart';
import 'package:nexus/screens/userprofile_and_settings/settingContainer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Settings',
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
          children: [
            SettindContainer(
                text: 'Edit Profile',
                icon: true,
                onPress: () {
                  Get.toNamed(AppRoutes.editProfile);
                }),
            const Divider(
              color: Colors.transparent,
            ),
            SettindContainer(
              text: 'Verify Account',
              icon: true,
              onPress: () {
                Get.toNamed(AppRoutes.verifyAcc);
              },
            ),
            const Divider(
              color: Colors.transparent,
            ),
            SettindContainer(
                text: 'Subscription',
                icon: true,
                onPress: () {
                  Get.toNamed(AppRoutes.subscription);
                }),
            const Divider(
              color: Colors.transparent,
            ),
            SettindContainer(
              text: 'Payment Methods',
              icon: true,
              onPress: () {
                Get.toNamed(AppRoutes.payment);
              },
            ),
            const Divider(
              color: Colors.transparent,
            ),
            SettindContainer(text: 'Contact Us', icon: true, onPress: () {}),
            const Divider(
              color: Colors.transparent,
            ),
            SettindContainer(
                text: 'Invite Friends', icon: true, onPress: () {}),
            const Divider(
              color: Colors.transparent,
            ),
            SettindContainer(
                text: 'About Nexus',
                icon: true,
                onPress: () {
                  Get.toNamed(AppRoutes.about);
                }),
            const Divider(
              color: Colors.transparent,
            ),
            SettindContainer(
                text: 'Terms of Use',
                icon: true,
                onPress: () {
                  Get.toNamed(AppRoutes.terms);
                }),
            const Divider(
              color: Colors.transparent,
            ),
            SettindContainer(
                text: 'Privacy Policy',
                icon: true,
                onPress: () {
                  Get.toNamed(AppRoutes.privacy);
                }),
            const Divider(
              color: Colors.transparent,
            ),
            SettindContainer(
                text: 'Change Password',
                icon: true,
                onPress: () {
                  Get.toNamed(AppRoutes.changePassword);
                }),
            const Divider(
              color: Colors.transparent,
            ),
            SettindContainer(
                text: 'Delete Account',
                icon: true,
                onPress: () {
                  Get.toNamed(AppRoutes.deleteAccount);
                }),
            Divider(
              color: Colors.transparent,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    shape: RoundedRectangleBorder(),
                    backgroundColor: black,
                    builder: (BuildContext context) {
                      return LoginModalSheet();
                    });
              },
              child: SettindContainer(
                  text: 'Log Out',
                  icon: true,
                  onPress: () {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            shape: RoundedRectangleBorder(),
                            backgroundColor: white,
                            builder: (BuildContext context) {
                              return LoginModalSheet();
                            });
                      },
                    );
                  }),
            ),
            const Divider(
              color: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
