import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/assets.dart';
import '../../../../core/button.dart';
import '../../../../core/button_outline.dart';
import '../../../../core/colors.dart';
import '../../../../core/size_boxes.dart';
import '../../../../core/style.dart';
import '../../../../core/utils/toast.dart';
import '../../../../router.dart';
import '../change_notifier/auth_notifier.dart';
import '../widgets/country_modal.dart';

class AuthHandler extends StatefulWidget {
  const AuthHandler({super.key});

  @override
  State<AuthHandler> createState() => _AuthHandlerState();
}

class _AuthHandlerState extends State<AuthHandler> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        backgroundColor: primary,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: white),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: primary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBoxH40(),
              Image.asset("$imgPath/newlogo.PNG"),
              Column(
                children: [
                  CustomButtonOut(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        // backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.sp),
                          ),
                        ),
                        builder: (context) {
                          return const CountryModal(
                              // model: model,
                              );
                        },
                      );
                      // Get.toNamed(AppRoutes.login);
                    },
                    text: 'Sign In',
                    textColor: white,
                    bgColor: white,
                    borderRadius: 20,
                    vPadding: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBoxW15(),
                        Text(
                          model.country == ''
                              ? 'Select Your Nationality'
                              : model.country,
                          style: textStyle14.copyWith(
                            fontWeight: FontWeight.bold,
                            color: white,
                            fontSize: 16,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: white,
                          size: 30,
                        ),
                      ],
                    ),
                    // bgColor: white,
                  ),
                  const SizedBoxH15(),
                  CustomButton(
                    onPressed: () {
                      if (model.country == '') {
                        AppToast().showErrorToast(
                          'Please select a country',
                          color: white,
                          textColor: primary,
                        );
                      } else {
                        Get.toNamed(AppRoutes.createAccount);
                      }
                    },
                    text: 'Create Account',
                    textColor: primary,
                    bgColor: white,
                  ),
                  const SizedBoxH15(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: textStyle14.copyWith(
                            color: white.withOpacity(0.5),
                            fontWeight: FontWeight.w700),
                      ),
                      // const SizedBoxW5(),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.login);
                        },
                        child: Text(
                          'Sign In',
                          style: textStyle14.copyWith(
                              fontWeight: FontWeight.w700, color: white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
