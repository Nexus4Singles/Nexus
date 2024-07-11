import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/button_outline.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/utils/toast.dart';
import 'package:nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:nexus/features/auth/presentation/widgets/country_modal.dart';
import 'package:nexus/router.dart';
import 'package:provider/provider.dart';

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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'nexus'.toUpperCase(),
                      style: GoogleFonts.novaSquare(
                        fontSize: 35.sp,
                        color: white,
                      ),
                    ),
                  ),
                  const SizedBoxH15(),
                  // Image.asset(iLogo),
                  SvgPicture.asset("$svgPath/logo.svg"),
                  // Image.asset('$svgPath/nexus-logo2.gif'),

                  const SizedBoxH15(),
                  Text(
                    'Get the Visibility You Need \nto Connect with Your Future Spouse',
                    style: GoogleFonts.novaSquare(
                      fontSize: 16.sp,
                      color: white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
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
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
