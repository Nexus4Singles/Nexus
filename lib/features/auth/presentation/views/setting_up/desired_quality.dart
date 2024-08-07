import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/constant.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/utils/device.dart';
import 'package:Nexus/core/utils/toast.dart';
import 'package:Nexus/features/auth/data/data-sources/local-datasource/list_items.dart';
import 'package:Nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:Nexus/features/auth/presentation/widgets/hobbie_card.dart';
import 'package:Nexus/router.dart';
import 'package:provider/provider.dart';

class DesiredQualityScreen extends StatefulWidget {
  const DesiredQualityScreen({super.key});

  @override
  State<DesiredQualityScreen> createState() => _DesiredQualityScreenState();
}

class _DesiredQualityScreenState extends State<DesiredQualityScreen> {
  List<String> selectedDesires = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          title: SizedBox(
            width: width(context) * .5,
            child: LinearProgressIndicator(
              value: 0.5,
              backgroundColor: newGrey,
              color: primary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 15.sp,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Desired Qualities',
                style: textStyle8.copyWith(
                    fontSize: 30, fontWeight: FontWeight.w700, color: black),
              ),
              const SizedBoxH10(),
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          const TextSpan(
                              text:
                                  'Select up to 8 Qualities you value the most in the choice of a life partner,  asides from '),
                          TextSpan(
                              text: 'Godliness',
                              style: textStyle14.copyWith(
                                  fontWeight: FontWeight.bold))
                        ]),
                        style: textStyle14),
                  ],
                ),
              ),
              const SizedBoxH20(),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: List.generate(
                  LocalData().desireQualities.length,
                  (index) => HobbieCard(
                    text: LocalData().desireQualities[index],
                    isChecked: selectedDesires.contains(
                      LocalData().desireQualities[index],
                    ),
                    onPress: () {
                      if (selectedDesires
                          .contains(LocalData().desireQualities[index])) {
                        setState(() {
                          selectedDesires
                              .remove(LocalData().desireQualities[index]);
                        });
                      } else {
                        if (selectedDesires.length == 8) {
                          return AppToast()
                              .showErrorToast('Maximum of 8 qualities');
                        }
                        setState(() {
                          selectedDesires.add(
                            LocalData().desireQualities[index],
                          );
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBoxH20(),
              const SizedBoxH40(),
              const SizedBoxH20(),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                onPressed: () {
                  if (selectedDesires.length < 5) {
                    AppToast()
                        .showErrorToast('Please select at least 5 qualities');
                  } else {
                    model.updateProfile(
                      map: {
                        kDESIREDQUALITIES: selectedDesires,
                        kREGPROGRESS: 'desired',
                      },
                      onCompleted: () {
                        Get.toNamed(AppRoutes.uploadPhoto);
                      },
                    );
                  }
                },
                child: Text(
                  'Next',
                  style: textStyle16.copyWith(color: white),
                ),
              ),
              const SizedBoxH30()
            ],
          ),
        ),
      );
    });
  }
}
