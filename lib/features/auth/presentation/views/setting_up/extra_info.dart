import 'dart:async';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/constant.dart';
import 'package:Nexus/core/models/location.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/text_field.dart';
import 'package:Nexus/core/utils/device.dart';
import 'package:Nexus/features/auth/data/data-sources/local-datasource/list_items.dart';
import 'package:Nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:Nexus/features/auth/presentation/widgets/drop_down.dart';
import 'package:Nexus/router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/locationIQ_widget.dart';
import '../../../../../core/utils/toast.dart';

class ExtraInformationScreen extends StatefulWidget {
  const ExtraInformationScreen({super.key});

  @override
  State<ExtraInformationScreen> createState() => _ExtraInformationScreenState();
}

class _ExtraInformationScreenState extends State<ExtraInformationScreen> {
  String state = '';
  String eduLevel = '';
  String profession = '';
  String country = '';
  String church = '';
  String churchValue = '';
  String countrySelected = '';

  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController cityController = TextEditingController();
  TextEditingController churchController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  FutureOr _init() {
    Provider.of<AuthNotifier>(context, listen: false).getProfile();
  }

  @override
  void dispose() {
    super.dispose();
    countryController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: width(context) * .5,
            child: LinearProgressIndicator(
              value: 0.3,
              backgroundColor: newGrey,
              color: primary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
            ),
            child: Builder(builder: (context) {
              return Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Extra Information',
                      style: textStyle8.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: black),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Search for the name of your church from the list. If you don’t find it, kindly select “Other” and type the full name of your Church',
                              style: textStyle14.copyWith(
                                color: black.withOpacity(.8),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBoxH40(),
                    InkWell(
                      onTap: () {
                        showCountryPicker(
                          countryListTheme: CountryListThemeData(
                              textStyle: textStyle14,
                              inputDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              borderRadius: BorderRadius.circular(24)),
                          context: context,
                          showPhoneCode: false,
                          onSelect: (Country country) {
                            setState(() {
                              countryController.text = country.name;
                              countrySelected = country.name;
                            });
                          },
                        );
                      },
                      child: CustomTextField(
                        enabled: false,
                        fillColor: white,
                        suffixIcon: const Icon(Icons.arrow_drop_down_outlined),
                        radius: 12,
                        controller: countryController,
                        hintText: "Country of Residence",
                      ),
                    ),
                    const SizedBoxH10(),
                    CustomTextField(
                      fillColor: white,
                      radius: 12,
                      controller: cityController,
                      textCapitalization: TextCapitalization.words,
                      hintText: "State or City of Residence",
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return ' Field is required';
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          cityController.text = value;
                        });
                      },
                    ),
                    if (countrySelected == 'Nigeria') const SizedBoxH10(),
                    if (countrySelected == 'Nigeria')
                      ProfileDropDown(
                        items: LocalData().states,
                        val: state,
                        hintText: 'State of Origin',
                        onChanged: (p0) {
                          setState(() {
                            state = p0!;
                          });
                        },
                      ),
                    const SizedBoxH10(),
                    ProfileDropDown(
                      items: LocalData().educationalLevels,
                      val: eduLevel,
                      hintText: 'Education Level',
                      onChanged: (p0) {
                        setState(() {
                          eduLevel = p0!;
                        });
                      },
                    ),
                    const SizedBoxH10(),
                    ProfileDropDown(
                      items: LocalData().professions,
                      val: profession,
                      hintText: 'Profession / Industry',
                      onChanged: (p0) {
                        setState(() {
                          profession = p0!;
                        });
                      },
                    ),
                    const SizedBoxH10(),
                    ProfileDropDown(
                      items: LocalData().church,
                      val: church,
                      hintText: 'Church',
                      onChanged: (p0) {
                        setState(() {
                          church = p0!;
                          // churchController.text = p0;
                        });
                      },
                    ),
                    const SizedBoxH10(),
                    church == "Other"
                        ? CustomTextField(
                            controller: churchController,
                            onChanged: (val) {},
                            hintText: "Enter your Church's full name")
                        : const SizedBox(),
                    const SizedBoxH40(),
                    const SizedBoxH40(),
                    const SizedBoxH40(),
                  ],
                ),
              );
            }),
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                onPressed: () {
                  setState(() {
                    churchValue =
                        church == "Other" ? churchController.text : church;
                  });

                  if (isNotEmpty()) {
                    Map<String, dynamic> map = {
                      kCOUNTRY: country,
                      kCHURCHNAME: churchValue,
                      kEDULEVEL: eduLevel,
                      kSTATEOFORIGIN: state,
                      kPROFESSION: profession,
                      kREGPROGRESS: 'extra',
                      kCITY: model.city, //todo set city
                      kLOCATION: LocationModel(
                              id: "",
                              latitude: 0,
                              longitude: 0,
                              place:
                                  "${cityController.text} , ${countryController.text}",
                              country: countryController.text,
                              city: cityController.text)
                          .toJson(),
                    };
                    model.updateProfile(
                      map: map,
                      onCompleted: () {
                        Get.toNamed(AppRoutes.hobbies);
                      },
                    );
                  } else {
                    AppToast().showErrorToast("Kindly fill all fields");
                  }
                },
                child: Text(
                  'Next',
                  style: textStyle16.copyWith(color: white),
                ),
              ),
              const SizedBoxH30(),
            ],
          ),
        ),
      );
    });
  }

  bool isNotEmpty() {
    if (countryController.text == 'Nigeria' && state.isEmpty) {
      return false;
    }
    return countryController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        eduLevel.isNotEmpty &&
        profession.isNotEmpty &&
        churchValue.isNotEmpty;
  }
}

//    LocationIQWidget(
//                       textEditingController: model.search,
//                       textStyle: textStyle14,
//                       locationIQAPIKey: 'pk.da653605da38d00bec98323b179bd52e',
//                       inputDecoration: InputDecoration(
//                         fillColor: white,
//                         filled: true,
//                         hintText: 'Select your City, Country of Residence',
//                         hintStyle: textStyle14.copyWith(color: otherGrey),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 15, vertical: 5),
//                         border: outlineInputBorder.copyWith(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: const BorderSide(
//                             color: textBorderColor,
//                           ),
//                         ),
//                         enabledBorder: outlineInputBorder.copyWith(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: const BorderSide(
//                             color: textBorderColor,
//                           ),
//                         ),
//                         focusedBorder: outlineInputBorder.copyWith(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: const BorderSide(
//                             color: textBorderColor,
//                           ),
//                         ),
//                       ),
//                       boxDecoration: BoxDecoration(
//                           border: Border.all(color: Colors.transparent)),
//                       debounceTime: 800,
//                       seperatedBuilder: const Divider(),
//                       isCrossBtnShown: true,
//                       onClick: (models) {
//                         model.locationIQModel = models;
//                       },
//                     ),
