import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/toast.dart';
import 'package:nexus/router.dart';
import 'package:nexus/features/profile/presentation/widgets/login_modal_sheet.dart';
import 'package:nexus/features/profile/presentation/widgets/setting_container.dart';

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
                // AppToast().showErrorToast(
                //   'This feature will be available soon',
                //   header: 'Coming soon',
                // );
              },
            ),
            const Divider(
              color: Colors.transparent,
            ),
            // SettindContainer(
            //     text: 'Subscription Plans',
            //     icon: true,
            //     onPress: () {
            //       AppToast().showErrorToast(
            //         'This feature will be available soon',
            //         header: 'Coming soon',
            //       );
            //       // Get.toNamed(AppRoutes.subscription);
            //     }),
            // const Divider(
            //   color: Colors.transparent,
            // ),
            // SettindContainer(
            //   text: 'Your Subsription',
            //   icon: true,
            //   onPress: () {
            //     AppToast().showErrorToast(
            //       'This feature will be available soon',
            //       header: 'Coming soon',
            //     );
            //   },
            // ),
            // const Divider(
            //   color: Colors.transparent,
            // ),
            SettindContainer(
              text: 'Contact Us',
              icon: true,
              onPress: () {
                AppToast().showErrorToast(
                  'This feature will be available soon',
                  header: 'Coming soon',
                );
              },
            ),
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
                  // Get.toNamed(AppRoutes.changePassword);
                }),
            const Divider(
              color: Colors.transparent,
            ),
            // SettindContainer(
            //   text: 'Report User',
            //   icon: true,
            //   onPress: () {
            //     AppToast().showErrorToast(
            //       'This feature will be available soon',
            //       header: 'Coming soon',
            //     );
            //   },
            // ),
            const Divider(
              color: Colors.transparent,
            ),
            SettindContainer(
                text: 'Delete Account',
                icon: true,
                onPress: () {
                  Get.toNamed(AppRoutes.deleteAccount);
                }),
            const Divider(
              color: Colors.transparent,
            ),
            SettindContainer(
              text: 'Log Out',
              icon: true,
              onPress: () {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  backgroundColor: white,
                  builder: (BuildContext context) {
                    return const LoginModalSheet();
                  },
                );
              },
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
