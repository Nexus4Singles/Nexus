import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/core/utils/device.dart';
import 'package:nexus/features/auth/data/data-sources/local-datasource/list_items.dart';
import 'package:nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:nexus/features/auth/presentation/widgets/drop_down.dart';
import 'package:nexus/router.dart';
import 'package:provider/provider.dart';

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

  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController cityController = TextEditingController();
  TextEditingController churchController = TextEditingController();
  TextEditingController stateController = TextEditingController();

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
                    const SizedBoxH20(),
                    GooglePlaceAutoCompleteTextField(
                      textEditingController: model.search,
                      googleAPIKey: 'AIzaSyDK9B0jBJl2A3NdXfhKzFAqreY_Djr249Y',
                      // countries: const ['NG'],
                      inputDecoration: InputDecoration(
                        fillColor: white,
                        filled: true,
                        hintText: 'Select your City, Country of Residence',
                        hintStyle: textStyle14.copyWith(color: otherGrey),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        border: outlineInputBorder.copyWith(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: textBorderColor,
                          ),
                        ),
                        enabledBorder: outlineInputBorder.copyWith(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: textBorderColor,
                          ),
                        ),
                        focusedBorder: outlineInputBorder.copyWith(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: textBorderColor,
                          ),
                        ),
                      ),
                      boxDecoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent)),
                      debounceTime: 800,
                      isLatLngRequired: true,
                      getPlaceDetailWithLatLng: (Prediction prediction) {
                        Logger().d(prediction.toJson());
                        model.getFormattedLocation(
                            double.parse(prediction.lat!),
                            double.parse(prediction.lat!),
                            prediction.placeId!);
                        print(prediction.placeId);
                      },
                      itemClick: (prediction) {
                        // model.getFormattedLocation(
                        //     double.parse(prediction.lat!),
                        //     double.parse(prediction.lat!));
                        // Logger().d(prediction.toJson());
                      },
                      itemBuilder: (context, index, Prediction prediction) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on),
                              const SizedBox(width: 7),
                              Expanded(
                                  child: Text(prediction.description ?? ""))
                            ],
                          ),
                        );
                      },
                      seperatedBuilder: const Divider(),
                      isCrossBtnShown: true,
                    ),
                    const SizedBoxH15(),
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
                        });
                      },
                    ),
                    const SizedBoxH10(),
                    church == "Other"
                        ? CustomTextField(
                            controller: churchController,
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
          padding: EdgeInsets.symmetric(
            horizontal: 15.sp,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                onPressed: () {
                  if (model.location.place!.contains(" ")) {
                    bool validate = _formkey.currentState!.validate();
                    if (validate) {
                      Map<String, dynamic> map = {
                        kCOUNTRY: 'Nigeria', //todo Nigeria as default
                        kCHURCHNAME: churchController.text.isEmpty
                            ? church
                            : churchController.text,
                        kEDULEVEL: eduLevel,
                        kSTATEOFORIGIN: state,
                        kPROFESSION: profession,
                        kREGPROGRESS: 'extra',
                        kCITY: model.city, //todo set city
                        kLOCATION: model.location.toJson(),
                      };
                      model.updateProfile(
                        map: map,
                        onCompleted: () {
                          Get.toNamed(AppRoutes.hobbies);
                        },
                      );
                    }
                  } else {
                    AppToast().showErrorToast(
                        "Please select a city with the country");
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
}
