import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/router.dart';
import 'package:nexus/theme.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  TextEditingController pin = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context, listen: true).isDark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                          horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ' Verify Account ',
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
                            'ayodele@mail.com',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sora(
                                color: primary,
                                textStyle: textStyle12,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBoxH25(),
                          Center(
                            child: Pinput(
                              controller: pin,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              keyboardAppearance: Brightness.light,
                              listenForMultipleSmsOnAndroid: true,
                              defaultPinTheme: PinTheme(
                                width: 40,
                                height: 40,
                                textStyle: textStyle16.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: white,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        isDark ? const Color(0xff1B2537) : grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              hapticFeedbackType:
                                  HapticFeedbackType.lightImpact,
                              length: 4,
                              onCompleted: (pin) {
                                Get.toNamed(AppRoutes.congratulations);
                              },
                              onChanged: (value) {},
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 9),
                                    width: 22,
                                    height: 1,
                                    color: primary,
                                  ),
                                ],
                              ),
                              focusedPinTheme: PinTheme(
                                width: 40,
                                height: 40,
                                textStyle: textStyle16.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: black,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              submittedPinTheme: PinTheme(
                                width: 40,
                                height: 40,
                                textStyle: textStyle16.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: black,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        isDark ? const Color(0xff1B2537) : grey,
                                  ),
                                ),
                              ),
                              errorPinTheme: PinTheme(
                                width: 40,
                                height: 40,
                                textStyle: textStyle16.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: black,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        isDark ? const Color(0xff1B2537) : grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBoxH10(),
                          Text(
                            'Didn’t receive the OTP?',
                            style: textStyle14.copyWith(
                              color: ash,
                            ),
                          ),
                          const SizedBoxH10(),
                          Text(
                            'Resend Code',
                            style: textStyle14.copyWith(
                                fontWeight: FontWeight.w500, color: primary),
                          ),
                          const SizedBoxH25(),
                          CustomButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.congratulations);
                            },
                            text: 'Verify',
                          ),
                          const SizedBoxH20(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Verify Later',
                                style: textStyle14.copyWith(
                                    color: black, fontWeight: FontWeight.w400),
                              ),
                              const SizedBoxW15(),
                            ],
                          )
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
  }
}
