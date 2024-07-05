import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/features/profile/presentation/controllers/profile_ctr.dart';
import 'package:provider/provider.dart';
import '../../../auth/data/data-sources/local-datasource/list_items.dart';
import '../../../auth/presentation/widgets/drop_down.dart';
import '../../../auth/presentation/widgets/hobbie_card.dart';
import '../../../home/presentation/change_notifier/home_notifier.dart';
import '../widgets/modals.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var ctr = Get.put(ProfileCtr());

  @override
  void initState() {
    var currentUser =
        Provider.of<HomeNotifier>(context, listen: false).currentUser!;
    ctr.eduLevel.value = currentUser.educationLevel!;
    ctr.profession.value = currentUser.profession!;
    ctr.church.value = currentUser.churchName!;
    ctr.city.value = currentUser.location!.city!;
    ctr.locationModel = currentUser.location;
    ctr.usernameCtr.text = currentUser.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(builder: (context, homeModel, _) {
      return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: Text(
            'Edit Profile',
            style: textStyle18.copyWith(
                fontSize: 24, fontWeight: FontWeight.w700, color: black),
          ),
          centerTitle: true,
          foregroundColor: black,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: white),
                        shape: BoxShape.circle),
                    child: Stack(
                      children: [
                        const CircleAvatar(
                          maxRadius: 50,
                          backgroundImage: AssetImage('assets/images/user.png'),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 0,
                          child: CircleAvatar(
                            maxRadius: 15,
                            backgroundColor: primary,
                            foregroundColor: white,
                            child: SvgPicture.asset('assets/icons/pen.svg',
                                fit: BoxFit.contain),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBoxH20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hobbies / Interests',
                    style: textStyle18.copyWith(
                      fontWeight: FontWeight.w500,
                      color: black,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        hobbiesModal(context);
                      },
                      child: SvgPicture.asset('assets/icons/edit.svg'))
                ],
              ),
              const SizedBoxH15(),
              Wrap(children: [
                ...homeModel.currentUser!.hobbies!.map((val) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HobbieCard(
                          text: val, isChecked: true, onPress: () {}),
                    ))
              ]),
              const SizedBoxH15(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Most Desired Qualities',
                    style: textStyle18.copyWith(
                      fontWeight: FontWeight.w500,
                      color: black,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        desireModal(context);
                      },
                      child: SvgPicture.asset('assets/icons/edit.svg'))
                ],
              ),
              const SizedBoxH15(),
              Wrap(children: [
                ...homeModel.currentUser!.desiredQualities!
                    .map((val) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: HobbieCard(
                              text: val, isChecked: true, onPress: () {}),
                        ))
              ]),
              const SizedBoxH15(),
              CustomTextField(
                fillColor: white,
                radius: 12,
                controller: ctr.usernameCtr,
                hintText: "Username",
                suffixIcon: SvgPicture.asset(
                  "$svgPath/edit.svg",
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBoxH15(),
              ProfileDropDown(
                items: LocalData().educationalLevels,
                val: ctr.eduLevel.value,
                hintText: 'Education Level',
                onChanged: (p0) {
                  setState(() {
                    ctr.eduLevel.value = p0!;
                  });
                },
              ),
              const SizedBoxH15(),
              ProfileDropDown(
                items: LocalData().professions,
                val: ctr.profession.value,
                hintText: 'Profession Level',
                onChanged: (p0) {
                  setState(() {
                    ctr.profession.value = p0!;
                  });
                },
              ),
              const SizedBoxH15(),
              ProfileDropDown(
                items: LocalData().church,
                val: ctr.church.value,
                hintText: 'Church',
                onChanged: (p0) {
                  setState(() {
                    ctr.church.value = p0!;
                  });
                },
              ),
              const SizedBoxH15(),
              GooglePlaceAutoCompleteTextField(
                textEditingController:
                    TextEditingController(text: ctr.locationModel!.place),
                googleAPIKey: 'AIzaSyDK9B0jBJl2A3NdXfhKzFAqreY_Djr249Y',
                // countries: const ['NG'],
                inputDecoration: InputDecoration(
                  fillColor: white,
                  filled: true,
                  hintText: 'Select your City, Country of Residence',
                  hintStyle: textStyle14.copyWith(color: otherGrey),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
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
                  ctr.getFormattedLocation(
                    double.parse(prediction.lat!),
                    double.parse(prediction.lat!),
                    prediction.placeId!,
                  );
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
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(child: Text(prediction.description ?? ""))
                      ],
                    ),
                  );
                },
                seperatedBuilder: const Divider(),
                isCrossBtnShown: true,
              ),
              const SizedBoxH40(),
              CustomButton(
                  onPressed: () async {
                    await ctr.updateProfile();
                    await Provider.of<HomeNotifier>(context, listen: false)
                        .getProfile();
                  },
                  text: "Update Profile"),
              const SizedBoxH40(),
            ],
          ),
        ),
      );
    });
  }
}
