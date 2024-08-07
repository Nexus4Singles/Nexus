import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:nexus/core/assets.dart';
import 'package:nexus/core/button.dart';
import 'package:nexus/core/colors.dart';
import 'package:nexus/core/size_boxes.dart';
import 'package:nexus/core/style.dart';
import 'package:nexus/core/text_field.dart';
import 'package:nexus/features/home/controllers/home_controller.dart';
import 'package:nexus/features/profile/presentation/controllers/profile_ctr.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/image_compressor.dart';
import '../../../../core/utils/toast.dart';
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
  List<File> imageFiles = [];
  List<String> allImage = [];
  int maxPhotos = 4;
  var currentUser = HomeController.instance.user.value;

  @override
  void initState() {
    ctr.eduLevel.value = currentUser.educationLevel!;
    ctr.profession.value = currentUser.profession!;
    ctr.church.value = currentUser.churchName!;
    ctr.searchText.text = currentUser.location!.place!;
    ctr.locationModel = currentUser.location;
    ctr.usernameCtr.text = currentUser.username;
    allImage.assignAll(currentUser.photos!.toList());
    super.initState();
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var coFile = await ImageCompressorNexus().compressAndGetFile(image);
      setState(() {
        allImage.add(coFile!.path);
        imageFiles.add(File(coFile.path));
      });
      // await value.uploadProfilePicture(image: );
    }
  }

  void _changeImage(int index, File image) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var coFile = await ImageCompressorNexus().compressAndGetFile(image);
      imageFiles.removeAt(index);
      setState(() {
        imageFiles.insert(index, File(coFile!.path));
      });
      // await value.uploadProfilePicture(image: );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Wrap(
              runSpacing: 8,
              spacing: 12,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              alignment: WrapAlignment.start,
              children: [
                for (var item in currentUser.photos!)
                  Container(
                    height: 120,
                    width: 120,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(item),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              if (allImage.length.isGreaterThan(2)) {
                                showConfirmationDialog(context, item, allImage);
                              } else {
                                AppToast().showErrorToast(
                                    "You need to have at least two images on your profile before you can delete any image");
                              }
                            },
                            child: const CircleAvatar(
                              backgroundColor: red,
                              radius: 12,
                              child: Icon(
                                Icons.close,
                                color: white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                for (var item in imageFiles)
                  Container(
                    height: 120,
                    width: 120,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: FileImage(item),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (allImage.length.isGreaterThan(2)) {
                                  allImage.remove(item.path);
                                  imageFiles.remove(item);
                                } else {
                                  AppToast().showErrorToast(
                                      "You need to have at least two images on this list before you can delete any image");
                                }
                              });
                            },
                            child: const CircleAvatar(
                              backgroundColor: white,
                              radius: 12,
                              child: Icon(
                                Icons.close,
                                color: black,
                                size: 12,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            int index = imageFiles.indexOf(item);
                            _changeImage(index, item);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: black.withOpacity(.4),
                              border: Border.all(
                                color: white,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.camera,
                                  color: white,
                                  size: 12,
                                ),
                                const SizedBoxW5(),
                                Text(
                                  'Change Photo',
                                  style: textStyle10.copyWith(
                                    color: white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                // if(imageFiles.length)
                // logic for the other variant here...
                if (allImage.length.isLowerThan(maxPhotos))
                  InkWell(
                    onTap: () {
                      if (currentUser.photos!.length < maxPhotos) {
                        for (int i = currentUser.photos!.length;
                            i < maxPhotos;
                            i++) {
                          _pickImage();
                        }
                      } else {
                        AppToast()
                            .showErrorToast('Maximum of 4 photos allowed');
                      }
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      strokeWidth: 1,
                      stackFit: StackFit.passthrough,
                      // customPath: (size) => customPath,
                      dashPattern: const [6, 3, 0, 3],
                      color: Colors.blue.withOpacity(.2),
                      radius: const Radius.circular(20),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xffeeeeee),
                        ),
                        child: const Icon(
                          Icons.add_circle,
                          color: primary,
                        ),
                      ),
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
                  style: textStyle14.copyWith(
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
            const SizedBoxH10(),
            Wrap(children: [
              ...currentUser.hobbies!.map((val) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        HobbieCard(text: val, isChecked: true, onPress: () {}),
                  ))
            ]),
            const SizedBoxH15(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Most Desired Qualities',
                  style: textStyle14.copyWith(
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
            const SizedBoxH10(),
            Wrap(children: [
              ...currentUser.desiredQualities!.map((val) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        HobbieCard(text: val, isChecked: true, onPress: () {}),
                  ))
            ]),
            const SizedBoxH15(),
            GooglePlaceAutoCompleteTextField(
              textEditingController: ctr.searchText,
              googleAPIKey: 'AIzaSyDK9B0jBJl2A3NdXfhKzFAqreY_Djr249Y',
              // countries: const ['NG'],
              textStyle: textStyle14.copyWith(color: black),
              inputDecoration: InputDecoration(
                fillColor: white,
                filled: true,
                labelStyle: textStyle14,
                helperStyle: textStyle14,
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
              boxDecoration:
                  BoxDecoration(border: Border.all(color: Colors.transparent)),
              debounceTime: 800,
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (Prediction prediction) {
                ctr.getFormattedLocation(
                  double.parse(prediction.lat!),
                  double.parse(prediction.lat!),
                  prediction.placeId!,
                );
                Logger().d(prediction.structuredFormatting);
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
                      Expanded(
                          child: Text(prediction.description ?? "",
                              style: textStyle14.copyWith(color: black)))
                    ],
                  ),
                );
              },
              seperatedBuilder: const Divider(),
              isCrossBtnShown: true,
            ),
            const SizedBoxH15(),
            CustomTextField(
              fillColor: white,
              radius: 12,
              controller: ctr.usernameCtr,
              hintText: "Username",
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
              val: !LocalData().church.contains(ctr.church.value)
                  ? "Other"
                  : ctr.church.value,
              hintText: 'Church',
              onChanged: (p0) {
                setState(() {
                  ctr.church.value = p0!;
                });
              },
            ),
            const SizedBoxH15(),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ctr.church.value == "Other" ||
                          !LocalData().church.contains(ctr.church.value)
                      ? CustomTextField(
                          fillColor: white,
                          radius: 12,
                          controller: TextEditingController(
                              text: currentUser.churchName),
                          onChanged: (val) {
                            ctr.church.value = val;
                          },
                          hintText: "Username",
                          suffixIcon: SvgPicture.asset(
                            "$svgPath/edit.svg",
                            fit: BoxFit.scaleDown,
                          ),
                        )
                      : const SizedBox(),
                  ctr.church.value == "Other" ||
                          !LocalData().church.contains(ctr.church.value)
                      ? const SizedBoxH15()
                      : const SizedBox(),
                ],
              ),
            ),
            const SizedBoxH40(),
            CustomButton(
                onPressed: () async {
                  await ctr.updateProfile(imageFiles);
                  await HomeController.instance.getMyProfile();
                },
                text: "Update Profile"),
            const SizedBoxH40(),
          ],
        ),
      ),
    );
  }

  void showConfirmationDialog(
      BuildContext context, String item, List allImage) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Delete this Image ?'),
          message: const Text('Are you sure you want to delete this image?'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                ctr.deleteUserPhoto(item).then((val) async {
                  allImage.remove(item);
                  // check why this didn't fetch data
                  await Provider.of<HomeNotifier>(context, listen: false)
                      .getProfile();
                });
                // Navigator.pop(context, 'Deleted');
                // Handle the destructive action
              },
              child: const Text('Delete'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, 'Cancelled');
              // Handle the cancellation action
            },
            child: const Text('Cancel'),
          ),
        );
      },
    );
  }
}
