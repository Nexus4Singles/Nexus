import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
// import 'package:nexus/core/constant.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
// import 'package:nexus/core/utils/toast.dart';
import 'package:nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:nexus/router.dart';
// import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  TextEditingController pin = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  FutureOr _init() {
    Provider.of<AuthNotifier>(context, listen: false).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height(context),
                width: width(context),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/firelove.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Verify Account',
                              style: GoogleFonts.nunito(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w700,
                                color: black,
                              ),
                            ),
                            Text(
                              'Please enter the code we just sent to the email',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.sora(
                                  color: black,
                                  textStyle: textStyle12,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              model.user == null ? '' : model.user!.email,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.sora(
                                  color: primary,
                                  textStyle: textStyle12,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBoxH25(),
                            // Center(
                            //   child: Pinput(
                            //     controller: pin,
                            //     obscureText: false,
                            //     keyboardType: TextInputType.number,
                            //     keyboardAppearance: Brightness.light,
                            //     listenForMultipleSmsOnAndroid: true,
                            //     defaultPinTheme: PinTheme(
                            //       width: 60,
                            //       height: 60,
                            //       textStyle: textStyle16.copyWith(
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w700,
                            //         color: white,
                            //       ),
                            //       decoration: BoxDecoration(
                            //         border: Border.all(
                            //           color: textBorderColor,
                            //         ),
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //     ),
                            //     hapticFeedbackType:
                            //         HapticFeedbackType.lightImpact,
                            //     length: 4,
                            //     // onCompleted: (pin) {
                            //     //   Get.toNamed(AppRoutes.congratulations);
                            //     // },
                            //     onChanged: (value) {},
                            //     cursor: Column(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         Container(
                            //           margin: const EdgeInsets.only(bottom: 9),
                            //           width: 22,
                            //           height: 1,
                            //           color: primary,
                            //         ),
                            //       ],
                            //     ),
                            //     focusedPinTheme: PinTheme(
                            //       width: 60,
                            //       height: 60,
                            //       textStyle: textStyle16.copyWith(
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w700,
                            //         color: black,
                            //       ),
                            //       decoration: BoxDecoration(
                            //         color: primary,
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //     ),
                            //     submittedPinTheme: PinTheme(
                            //       width: 60,
                            //       height: 60,
                            //       textStyle: textStyle16.copyWith(
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w700,
                            //         color: black,
                            //       ),
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10),
                            //         border: Border.all(
                            //           color: textBorderColor,
                            //         ),
                            //       ),
                            //     ),
                            //     errorPinTheme: PinTheme(
                            //       width: 60,
                            //       height: 60,
                            //       textStyle: textStyle16.copyWith(
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w700,
                            //         color: black,
                            //       ),
                            //       decoration: BoxDecoration(
                            //         border: Border.all(
                            //           color: textBorderColor,
                            //         ),
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            const SizedBoxH10(),
                            Text(
                              'Didn’t receive verification link?',
                              style: textStyle14.copyWith(
                                color: ash,
                              ),
                            ),
                            const SizedBoxH10(),
                            InkWell(
                              onTap: () {
                                model.resendVerificatioLink();
                              },
                              child: Text(
                                'Resend Link',
                                style: textStyle14.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
                            ),
                            const SizedBoxH25(),
                            CustomButton(
                              onPressed: () {
                                // if (pin.text == '1234') {
                                //   model.updateProfile(
                                //     map: {kISVERIFIED: true},
                                //     onCompleted: () {
                                Get.offAllNamed(AppRoutes.congratulations);
                                //   },
                                // );
                                // } else {
                                //   AppToast()
                                //       .showErrorToast('Incorrect OTP code');
                                // }
                              },
                              text: 'Verify',
                            ),
                            const SizedBoxH20(),
                            InkWell(
                              onTap: () {
                                Get.offAllNamed(AppRoutes.congratulations);
                              },
                              child: Text(
                                'Verify Later',
                                style: textStyle14.copyWith(
                                    color: black, fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBoxH20(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pin.dispose();
  }
}
