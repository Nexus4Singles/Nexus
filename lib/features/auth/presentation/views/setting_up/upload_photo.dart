import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/button.dart';
import 'package:Nexus/core/colors.dart';
import 'package:Nexus/core/constant.dart';
import 'package:Nexus/core/size_boxes.dart';
import 'package:Nexus/core/style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:Nexus/core/utils/device.dart';
import 'package:Nexus/core/utils/image_compressor.dart';
import 'package:Nexus/core/utils/toast.dart';
import 'package:Nexus/features/auth/presentation/change_notifier/auth_notifier.dart';
import 'package:Nexus/router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, model, _) {
      return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: SizedBox(
            width: width(context) * .5,
            child: LinearProgressIndicator(
              value: 0.6,
              backgroundColor: newGrey,
              color: primary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 15.sp,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Upload Your Photos',
                style: textStyle8.copyWith(
                    fontSize: 30, fontWeight: FontWeight.w700, color: black),
              ),
              const SizedBoxH10(),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'Add at least 2 photos of yourself. We highly recommend \nuploading your best pictures because first impressions \nreally matter. Profiles with indecent pictures will be deleted. ',
                      textAlign: TextAlign.center,
                      style: textStyle12.copyWith(color: black.withOpacity(.8)),
                    ),
                  ],
                ),
              ),
              const SizedBoxH40(),
              const SizedBoxH20(),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                alignment: WrapAlignment.start,
                children: [
                  if (imageFiles.length < 4)
                    InkWell(
                      onTap: () {
                        if (imageFiles.length == 4) {
                          AppToast()
                              .showErrorToast('Maximum of 4 photos allowed');
                        } else {
                          _pickImage(model);
                        }
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        strokeWidth: 1,
                        stackFit: StackFit.passthrough,
                        // customPath: (size) => customPath,
                        dashPattern: const [6, 3, 0, 3],
                        color: Colors.blue.withOpacity(.2),
                        radius: Radius.circular(20.r),
                        child: Container(
                          height: 130.h,
                          width: 140.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: const Color(0xffeeeeee),
                          ),
                          child: const Icon(
                            Icons.add_circle,
                            color: primary,
                          ),
                        ),
                      ),
                    ),
                  for (var item in imageFiles)
                    Container(
                      height: 130.h,
                      width: 140.w,
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
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
                                  imageFiles.remove(item);
                                });
                              },
                              child: const CircleAvatar(
                                backgroundColor: white,
                                radius: 15,
                                child: Icon(
                                  Icons.close,
                                  color: black,
                                  size: 15,
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
                              padding: EdgeInsets.all(5.sp),
                              decoration: BoxDecoration(
                                color: black.withOpacity(.4),
                                border: Border.all(
                                  color: white,
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.camera,
                                    color: white,
                                    size: 16,
                                  ),
                                  const SizedBoxW5(),
                                  Text(
                                    'Change Photo',
                                    style: textStyle12.copyWith(
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
                ],
              ),
              const SizedBoxH20()
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                onPressed: () async {
                  if (imageFiles.length < 2) {
                    AppToast()
                        .showErrorToast('Please select at least 2 photos');
                  } else {
                    List imageUrls = [];
                    for (var file in imageFiles) {
                      await model.uploadFile(file: file).then((value) {
                        imageUrls.add(value);
                      });
                    }
                    if (imageUrls.length == imageFiles.length) {
                      model.updateProfile(
                          map: {
                            kPHOTOS: imageUrls,
                            kREGPROGRESS: 'upload',
                            KPROFILEURL: imageUrls.first,
                          },
                          onCompleted: () {
                            Get.toNamed(AppRoutes.audioRecording);
                          });
                    }
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

  List<File> imageFiles = [];

  void _pickImage(AuthNotifier model) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var coFile = await ImageCompressorNexus().compressAndGetFile(image);
      setState(() {
        imageFiles.add(File(coFile!.path));
      });
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
    }
  }

  Path customPath = Path()
    ..moveTo(20, 20)
    ..lineTo(50, 100)
    ..lineTo(20, 200)
    ..lineTo(100, 100)
    ..lineTo(20, 20);
}
