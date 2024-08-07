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

class HobbiesScreen extends StatefulWidget {
  const HobbiesScreen({super.key});

  @override
  State<HobbiesScreen> createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
  List<String> selectedHobbies = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          title: SizedBox(
            width: width(context) * .5,
            child: LinearProgressIndicator(
              value: 0.4,
              backgroundColor: newGrey,
              color: primary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hobbies/Interests',
                style: textStyle8.copyWith(
                    fontSize: 30, fontWeight: FontWeight.w700, color: black),
              ),
              const SizedBoxH10(),
              Center(
                child: Text(
                  'Select up to 5 interests/hobbies to let users know \nwhat you are passionate about. ',
                  textAlign: TextAlign.center,
                  style: textStyle14,
                ),
              ),
              const SizedBoxH20(),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: List.generate(
                  LocalData().hobbies.length,
                  (index) => HobbieCard(
                    text: LocalData().hobbies[index],
                    isChecked: selectedHobbies.contains(
                      LocalData().hobbies[index],
                    ),
                    onPress: () {
                      if (selectedHobbies
                          .contains(LocalData().hobbies[index])) {
                        setState(() {
                          selectedHobbies.remove(LocalData().hobbies[index]);
                        });
                      } else {
                        if (selectedHobbies.length == 5) {
                          return AppToast()
                              .showErrorToast('Maximum of 5 Hobbies/Interests');
                        }
                        setState(() {
                          selectedHobbies.add(
                            LocalData().hobbies[index],
                          );
                        });
                      }
                    },
                  ),
                ),
              ),
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
                  if (selectedHobbies.length < 5) {
                    AppToast()
                        .showErrorToast('Please select at least 5 hobbies');
                  } else {
                    model.updateProfile(
                      map: {
                        kHOBBIES: selectedHobbies,
                        kREGPROGRESS: 'hobbies',
                      },
                      onCompleted: () {
                        Get.toNamed(AppRoutes.desiredQuality);
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
