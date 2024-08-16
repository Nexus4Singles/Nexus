import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/assets.dart';
import '../../../../core/button.dart';
import '../../../../core/colors.dart';
import '../../../../core/size_boxes.dart';
import '../../../../core/style.dart';
import '../../../../core/text_field.dart';
import '../../../../core/utils/toast.dart';
import '../change_notifier/auth_notifier.dart';

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: white),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              height: Get.height / 1.3,
              width: Get.width,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('$imgPath/firelove.png'))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Get.height / 1.6,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBoxH25(),
                    Text(
                      'Forgotten Password',
                      style: GoogleFonts.outfit(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                        color: black,
                      ),
                    ),
                    Text(
                        'Please provide your email below. Kindly check your spam \nif you don’t find password reset link in your inbox',
                        textAlign: TextAlign.center,
                        style:
                            textStyle12.copyWith(color: black.withOpacity(.5))),
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
                          AppToast().showErrorToast('Enter email address');
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
      );
    });
  }
}
