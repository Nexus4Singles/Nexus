import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
// import 'package:nexus/core/text_field_password.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/core/utils/toast.dart';
import 'package:nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
// import 'package:nexus/router.dart';
import 'package:provider/provider.dart';

class ForgottenPasswordScreen extends StatefulWidget {
  const ForgottenPasswordScreen({super.key});

  @override
  State<ForgottenPasswordScreen> createState() =>
      _ForgottenPasswordScreenState();
}

class _ForgottenPasswordScreenState extends State<ForgottenPasswordScreen> {
  bool showPassword = true;
  bool showCPassword = true;
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height(context),
                width: width(context),
                color: white,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/firelove.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SafeArea(
                      child: BackButton(
                        color: white,
                      ),
                    ),
                    Positioned(
                      bottom: 200,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBoxH25(),
                            Text(
                              'Forgotten Password',
                              style: GoogleFonts.nunito(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w700,
                                color: black,
                              ),
                            ),
                            Text(
                              'Please provide your email below. Kindly check your spam \nif you don’t find password reset link in your inbox',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.sora(
                                  color: black,
                                  textStyle: textStyle12,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBoxH30(),
                            CustomTextField(
                              controller: email,
                              hintText: 'Email address',
                            ),
                            const SizedBoxH20(),
                            const SizedBoxH25(),
                            CustomButton(
                              onPressed: () {
                                if (email.text.isEmail) {
                                  model.resendResetLink(email: email.text);
                                } else {
                                  AppToast()
                                      .showErrorToast('Enter email address');
                                }
                              },
                              text: 'Send Reset Link',
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
}
