import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/core/text_field_password.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/core/utils/shared_pref.dart';
import 'package:nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:nexus/router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = true;
  bool showPassword = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
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
                      Positioned(
                        bottom: 70,
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
                                'Welcome Back',
                                style: GoogleFonts.nunito(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w700,
                                  color: black,
                                ),
                              ),
                              Text(
                                'Our goal is to provide you with the visibility you need\nto potentially connect with your life partner.',
                                textAlign: TextAlign.center,
                                style: textStyle12.copyWith(
                                  color: black.withOpacity(.8),
                                ),
                              ),
                              const SizedBoxH20(),
                              CustomTextField(
                                controller: email,
                                // onChanged: (value) {
                                //   model.setData(kEMAIL, value);
                                // },
                                validator: (value) {
                                  if (!value!.isEmail) {
                                    return 'Invalid email';
                                  }
                                  return null;
                                },
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/sms1.svg',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ],
                                ),
                                hintText: 'Email Address',
                              ),
                              const SizedBoxH20(),
                              CustomTextFieldPassword(
                                controller: password,
                                hintText: 'Password',
                                // onChanged: (value) {
                                //   model.setData(kPASSWORD, value);
                                // },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter password';
                                  } else {
                                    return null;
                                  }
                                },
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/lock2.svg',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ],
                                ),
                                obsecure: showPassword,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  child: Icon(
                                      showPassword
                                          ? Iconsax.eye_slash
                                          : Iconsax.eye,
                                      color: primary),
                                ),
                              ),
                              const SizedBoxH10(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.forgottenPassword);
                                    },
                                    child: Text(
                                      'Forgotten password?',
                                      style: textStyle14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBoxH25(),
                              CustomButton(
                                onPressed: () async {
                                  bool validate =
                                      _formkey.currentState!.validate();
                                  if (validate) {
                                    await SharedPref.setBool(kFirstTime, false);
                                    Map<String, dynamic> map = {
                                      kEMAIL: email.text,
                                      kPASSWORD: password.text,
                                    };
                                    model.login(context: context, map: map);
                                  }
                                },
                                text: 'Sign In',
                              ),
                              const SizedBoxH20(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don’t have an account?',
                                    style: textStyle14.copyWith(color: black),
                                  ),
                                  // const SizedBoxW15(),
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.onboardingHandler);
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: textStyle14.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: primary),
                                    ),
                                  )
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
        ),
      );
    });
  }
}
