import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/button_outline.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/text_field.dart';
import 'package:Nexus/features/profile/presentation/controllers/profile_ctr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeleteAccountModalSheet extends StatelessWidget {
  DeleteAccountModalSheet({super.key});

  final ctr = Get.put(ProfileCtr());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      reverse: true,
      child: Padding(
        // padding: EdgeInsets.symmetric(horizontal: 15.sp),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Confirm Account Deletion',
                  style: headerStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBoxH25(),
                Text(
                  'Please kindly enter your password to complete the deletion process',
                  style: textStyle14,
                ),
              ],
            ),
            const SizedBoxH20(),
            CustomTextField(
              controller: ctr.currentPassword,
              hintText: 'Current Password',
              action: TextInputAction.done,
            ),
            const SizedBoxH40(),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButtonOut(
                        onPressed: () {
                          ctr.currentPassword.clear();
                          Navigator.of(context).pop();
                        },
                        text: 'Cancel',
                      ),
                    ),
                    const SizedBoxW15(),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          if (ctr.currentPassword.text.isEmpty) {
                            EasyLoading.showToast(
                              "Please enter your password",
                            );

                            return;
                          }

                          ctr.deleteAccount();
                        },
                        text: 'Yes, Delete',
                      ),
                    ),
                  ],
                ),
                const SizedBoxH30(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
