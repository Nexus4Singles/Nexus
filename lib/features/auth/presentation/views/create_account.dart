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
import 'package:nexus/core/utils/toast.dart';
import 'package:nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:nexus/router.dart';
import 'package:provider/provider.dart';

import '../../../../core/assets.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isChecked = false;
  bool showPassword = true;
  final GlobalKey<FormState> _formkey = GlobalKey();

  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: white),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
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
                    color: bgColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Create Account',
                            style: GoogleFonts.outfit(
                              fontSize: 32.sp,
                              letterSpacing: -0.3,
                              fontWeight: FontWeight.w600,
                              color: black,
                            ),
                          ),
                          Text(
                              'Welcome to Nexus! Lets create an account for you',
                              textAlign: TextAlign.center,
                              style: textStyle12.copyWith(
                                  color: black.withOpacity(0.5))),
                          const SizedBox(height: 64),
                          CustomTextField(
                            controller: username,
                            textCapitalization: TextCapitalization.words,
                            autoCorrect: false,
                            hintText: 'Username (Firstname highly recommended)',
                            prefixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/user.svg',
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Username is required';
                              }
                              if (value.length < 5) {
                                return 'Username must be at least 5 characters';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              model.setData(kUSERNAME, value);
                            },
                          ),
                          const SizedBoxH15(),
                          CustomTextField(
                            controller: email,
                            hintText: 'Email Address',
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
                            validator: (value) {
                              if (!value!.isEmail) {
                                return 'Invalid email';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              model.setData(kEMAIL, value);
                            },
                          ),
                          const SizedBoxH15(),
                          CustomTextFieldPassword(
                            controller: password,
                            hintText: 'Password (8 characters minimum)',
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
                            onChanged: (value) {
                              model.setData(kPASSWORD, value);
                            },
                            validator: (value) {
                              if (value!.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 9),
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Checkbox(
                                      value: isChecked,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      activeColor: primary,
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                      side: const BorderSide(
                                        color: black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "I agree to the ",
                                    style: textStyle14,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.terms);
                                    },
                                    child: Text(
                                      'Terms of use',
                                      style: textStyle14.copyWith(
                                        color: primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ' &',
                                    style: textStyle14.copyWith(color: black),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.privacy);
                                    },
                                    child: Text(
                                      ' Privacy policy',
                                      style: textStyle14.copyWith(
                                        color: primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox()
                            ],
                          ),
                          const SizedBoxH25(),
                          CustomButton(
                            onPressed: () async {
                              // Get.toNamed(AppRoutes.verifyAccount);
                              if (!isChecked) {
                                return AppToast().showErrorToast(
                                    'Please accepts term of use and privacy policy');
                              }
                              bool validate = _formkey.currentState!.validate();
                              if (validate) {
                                await SharedPref.setBool(kFirstTime, false);
                                Map<String, dynamic> map = {
                                  kEMAIL: email.text,
                                  kPASSWORD: password.text,
                                  kUSERNAME: username.text,
                                };
                                model.register(
                                  context: context,
                                  username: username.text,
                                  map: map,
                                );
                              }
                            },
                            text: 'Sign Up',
                          ),
                          const SizedBoxH20(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: textStyle14.copyWith(
                                    color: otherGrey,
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
                                      fontWeight: FontWeight.w700,
                                      color: primary),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
