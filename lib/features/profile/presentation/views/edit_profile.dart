import 'dart:io';
import 'package:Nexus/features/home/presentation/widgets/cache_network_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Nexus/core/assets.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:Nexus/core/text_field.dart';
import 'package:Nexus/features/home/controllers/home_controller.dart';
import 'package:Nexus/features/profile/presentation/controllers/profile_ctr.dart';
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
  List<File> imageFiles = [];
  List<String> allImage = [];
  int maxPhotos = 4;
  var currentUser = HomeController.instance.user;
  var ctr = ProfileCtr.instance;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    ctr.eduLevel.value = currentUser.value.educationLevel ?? '';
    ctr.profession.value = currentUser.value.profession!;
    ctr.church.value = currentUser.value.churchName!;
    ctr.churchCtr.text = currentUser.value.churchName!;
    ctr.cityCtr.text = currentUser.value.location!.city!;
    ctr.countryCtr.text = currentUser.value.location!.country ?? '';
    ctr.instagramCtr.text = currentUser.value.instagramUsername ?? '';
    ctr.instagram_username.value = currentUser.value.instagramUsername ?? '';
    ctr.telegramCtr.text = currentUser.value.telegramUsername ?? '';
    ctr.telegram_username.value = currentUser.value.telegramUsername ?? '';
    ctr.snapchatCtr.text = currentUser.value.snapchatUsername ?? '';
    ctr.snapchat_username.value = currentUser.value.snapchatUsername ?? '';
    ctr.phoneNumberCtr.text = currentUser.value.phoneNumber ?? '';
    ctr.phone_number.value = currentUser.value.phoneNumber ?? '';
    ctr.facebookCtr.text = currentUser.value.facebookUsername ?? '';
    ctr.facebook_username.value = currentUser.value.facebookUsername ?? '';
    ctr.twitterCtr.text = currentUser.value.twitterUsername ?? '';
    ctr.twitter_username.value = currentUser.value.twitterUsername ?? '';
    // ctr.usernameCtr.text = currentUser.value.username;
    ctr.ageCtr.text = currentUser.value.age.toString();
    allImage.assignAll(currentUser.value.photos!.toList());
    setState(() {});
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
                for (var item in currentUser.value.photos!)
                  CacheNetworkWidget(
                    height: 120,
                    width: 120,
                    imgUrl: item,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                if (allImage.length.isGreaterThan(2)) {
                                  showConfirmationDialog(
                                      context, item, allImage);
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
                                      "You need to have at least two images on your profile before you can delete any image");
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
                      if (currentUser.value.photos!.length < maxPhotos) {
                        for (int i = currentUser.value.photos!.length;
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
                    fontWeight: FontWeight.w700,
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
              ...currentUser.value.hobbies!.map((val) => Padding(
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
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    desireModal(context);
                  },
                  child: SvgPicture.asset('assets/icons/edit.svg'),
                )
              ],
            ),
            const SizedBoxH10(),
            Wrap(children: [
              ...currentUser.value.desiredQualities!.map((val) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        HobbieCard(text: val, isChecked: true, onPress: () {}),
                  ))
            ]),
            const SizedBoxH15(),
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
                    ctr.countryCtr.text = country.name;
                  },
                );
              },
              child: CustomTextField(
                enabled: false,
                fillColor: white,
                suffixIcon: const Icon(Icons.arrow_drop_down_outlined),
                radius: 12,
                controller: ctr.countryCtr,
                hintText: "Country of Residence",
              ),
            ),
            const SizedBoxH15(),
            CustomTextField(
              fillColor: white,
              radius: 12,
              controller: ctr.cityCtr,
              hintText: "City of Residence",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a city of residence';
                }

                final regex = RegExp(r'^[a-zA-Z]+$');
                if (!regex.hasMatch(value)) {
                  return 'Please enter only letters';
                }
              },
            ),
            const SizedBoxH15(),
            CustomTextField(
              fillColor: white,
              radius: 12,
              onChanged: (val) {
                ctr.isEmpty();
              },
              controller: ctr.ageCtr,
              hintText: "Age",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an age';
                }

                int? isValidAge = int.tryParse(value);
                if (isValidAge == null) {
                  return 'Invalid age';
                }

                if (isValidAge < 21 || isValidAge > 70) {
                  return 'Oops, you can only enter an age between 21 - 70';
                }

                return null;
              },
            ),
            const SizedBoxH15(),
            ProfileDropDown(
              items: LocalData().educationalLevels,
              val: (ctr.eduLevel.value == 'Undergraduate')
                  ? 'Undergraduate Degree'
                  : ctr.eduLevel.value,
              hintText: 'Education Level',
              onChanged: (p0) {
                setState(() {
                  ctr.eduLevel.value = p0!;
                  ctr.isEmpty();
                });
              },
            ),
            const SizedBoxH15(),
            ProfileDropDown(
              items: LocalData().professions,
              val: ctr.profession.value,
              hintText: 'Profession',
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
                ctr.church.value = p0!;
                setState(() {});
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
                          controller: ctr.churchCtr,
                          onChanged: (val) {
                            ctr.church.value = val;
                            ctr.isEmpty();
                          },
                          hintText: "Church name",
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
                  CustomTextField(
                    fillColor: white,
                    radius: 12,
                    controller: ctr.instagramCtr,
                    onChanged: (val) {
                      if (!val.startsWith("@")) {
                        ctr.instagramCtr.text = "@${val.replaceAll("@", "")}";
                        ctr.instagramCtr.selection = TextSelection.fromPosition(
                          TextPosition(offset: ctr.instagramCtr.text.length),
                        );
                      }
                      ctr.instagram_username.value = val;
                      ctr.isEmpty();
                    },
                    hintText: "Unavailable",
                    prefixIcon: SvgPicture.asset(
                      "$svgPath/ig.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: SvgPicture.asset(
                      "$svgPath/edit.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBoxH15(),
                  CustomTextField(
                    fillColor: white,
                    radius: 12,
                    controller: ctr.twitterCtr,
                    onChanged: (val) {
                      if (!val.startsWith("@")) {
                        ctr.twitterCtr.text = "@${val.replaceAll("@", "")}";
                        ctr.twitterCtr.selection = TextSelection.fromPosition(
                          TextPosition(offset: ctr.twitterCtr.text.length),
                        );
                      }
                      ctr.twitter_username.value = val;
                      ctr.isEmpty();
                    },
                    hintText: "Unavailable",
                    prefixIcon: SvgPicture.asset(
                      "$svgPath/x.svg",
                      height: 15,
                      width: 15,
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: SvgPicture.asset(
                      "$svgPath/edit.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBoxH15(),
                  CustomTextField(
                    fillColor: white,
                    radius: 12,
                    controller: ctr.snapchatCtr,
                    onChanged: (val) {
                      if (!val.startsWith("@")) {
                        ctr.snapchatCtr.text = "@${val.replaceAll("@", "")}";
                        ctr.snapchatCtr.selection = TextSelection.fromPosition(
                          TextPosition(offset: ctr.snapchatCtr.text.length),
                        );
                      }
                      ctr.snapchat_username.value = val;
                      ctr.isEmpty();
                    },
                    hintText: "Unavailable",
                    prefixIcon: SvgPicture.asset(
                      "$svgPath/snapchat-logo.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: SvgPicture.asset(
                      "$svgPath/edit.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBoxH15(),
                  CustomTextField(
                    fillColor: white,
                    radius: 12,
                    controller: ctr.phoneNumberCtr,
                    onChanged: (val) {
                      if (!val.startsWith("+")) {
                        ctr.phoneNumberCtr.text = "+${val.replaceAll("+", "")}";
                        ctr.phoneNumberCtr.selection =
                            TextSelection.fromPosition(
                          TextPosition(offset: ctr.phoneNumberCtr.text.length),
                        );
                      }
                      ctr.phone_number.value = val;
                      ctr.isEmpty();
                    },
                    hintText: "Unavailable",
                    prefixIcon: SvgPicture.asset(
                      "$svgPath/whatsapp.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: SvgPicture.asset(
                      "$svgPath/edit.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBoxH15(),
                  CustomTextField(
                    fillColor: white,
                    radius: 12,
                    controller: ctr.facebookCtr,
                    onChanged: (val) {
                      if (!val.startsWith("@")) {
                        ctr.facebookCtr.text = "@${val.replaceAll("@", "")}";
                        ctr.facebookCtr.selection = TextSelection.fromPosition(
                          TextPosition(offset: ctr.facebookCtr.text.length),
                        );
                      }
                      ctr.facebook_username.value = val;
                      ctr.isEmpty();
                    },
                    hintText: "Unavailable",
                    prefixIcon: SvgPicture.asset(
                      "$svgPath/facebook.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: SvgPicture.asset(
                      "$svgPath/edit.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBoxH15(),
                  CustomTextField(
                    fillColor: white,
                    radius: 12,
                    controller: ctr.telegramCtr,
                    onChanged: (val) {
                      if (!val.startsWith("@")) {
                        ctr.telegramCtr.text = "@${val.replaceAll("@", "")}";
                        ctr.telegramCtr.selection = TextSelection.fromPosition(
                          TextPosition(offset: ctr.telegramCtr.text.length),
                        );
                      }
                      ctr.telegram_username.value = val;
                      ctr.isEmpty();
                    },
                    hintText: "Unavailable",
                    prefixIcon: SvgPicture.asset(
                      "$svgPath/tg.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: SvgPicture.asset(
                      "$svgPath/edit.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBoxH40(),
            CustomButton(
                onPressed: () async {
                  await ctr.updateProfile(imageFiles).then((val) {
                    init();
                  });
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
                  init();
                });
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

//   LocationIQWidget(
//               textEditingController: ctr.searchText,
//               textStyle: textStyle14,
//               locationIQAPIKey: 'pk.da653605da38d00bec98323b179bd52e',
//               inputDecoration: InputDecoration(
//                 fillColor: white,
//                 filled: true,
//                 hintText: 'Select your City, Country of Residence',
//                 hintStyle: textStyle14.copyWith(color: otherGrey),
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                 border: outlineInputBorder.copyWith(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: const BorderSide(
//                     color: textBorderColor,
//                   ),
//                 ),
//                 enabledBorder: outlineInputBorder.copyWith(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: const BorderSide(
//                     color: textBorderColor,
//                   ),
//                 ),
//                 focusedBorder: outlineInputBorder.copyWith(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: const BorderSide(
//                     color: textBorderColor,
//                   ),
//                 ),
//               ),
//               boxDecoration:
//                   BoxDecoration(border: Border.all(color: Colors.transparent)),
//               debounceTime: 800,
//               seperatedBuilder: const Divider(),
//               isCrossBtnShown: true,
//               onClick: (model) {
//                 ctr.locationModel = model;
//               },
//             ),
