import 'dart:developer';
import 'dart:io';
import 'package:Nexus/core/network/digital_ocean_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:Nexus/core/constant.dart';
import 'package:Nexus/core/utils/toast.dart';
import 'package:Nexus/router.dart';
import '../../../../core/models/location.dart';
import 'package:path/path.dart' as path;

import '../../../home/controllers/home_controller.dart';

class ProfileCtr extends GetxController {
  static ProfileCtr get instance => Get.find<ProfileCtr>();
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final DigitalOceanClient digitalOceanClient = DigitalOceanClient();
  TextEditingController usernameCtr = TextEditingController();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController coNewPassword = TextEditingController();
  TextEditingController churchCtr = TextEditingController();
  TextEditingController countryCtr = TextEditingController();
  TextEditingController cityCtr = TextEditingController();
  var eduLevel = "".obs;
  var profession = "".obs;
  var church = "".obs;
  List imageUrls = [];

  bool isEmpty() {
    var status = usernameCtr.text.isNotEmpty &&
        countryCtr.text.isNotEmpty &&
        cityCtr.text.isNotEmpty &&
        church.value.isNotEmpty;
    print('what is the current status $status');
    return status;
  }

  Future updateProfile(List<File> imageFiles) async {
    EasyLoading.show();
    if (isEmpty()) {
      if (imageFiles.isNotEmpty) {
        await sendImageToDb(imageFiles);
      }
      await db.collection(kUSER).doc(auth.currentUser!.uid).update({
        "username": usernameCtr.text,
        'education_level': eduLevel.value,
        'profession': profession.value,
        'church_name': church.value,
        'location': LocationModel(
                id: '',
                latitude: 0,
                longitude: 0,
                place: "${cityCtr.text} , ${countryCtr.text}",
                country: countryCtr.text,
                city: cityCtr.text)
            .toJson(),
      });
      await Future.delayed(const Duration(seconds: 5),
          () async => await HomeController.instance.getMyProfile());
      Get.back();
      EasyLoading.dismiss();
    } else {
      EasyLoading.showToast("Kindly fill all fields");
    }
  }

  sendImageToDb(List<File> imageFiles) async {
    for (var file in imageFiles) {
      digitalOceanClient
          .uploadFileToSpace(
              bucket: 'profile',
              objectName:
                  '${auth.currentUser?.email}_${auth.currentUser!.uid}/${path.basename(file.path.trim())}',
              filePath: file.path)
          .then((value) async {
        await db.collection(kUSER).doc(auth.currentUser!.uid).update({
          "photos": FieldValue.arrayUnion([value]),
        });
      });
    }
  }

  Future updateQualities(List<String> desiredQualities, Function onCall) async {
    EasyLoading.show();
    await db
        .collection(kUSER)
        .doc(auth.currentUser!.uid)
        .update({"desired_qualities": desiredQualities});
    await onCall();
    EasyLoading.dismiss();
    Get.back();
  }

  updateHobbies(List<String> hobbies, Function onCall) async {
    EasyLoading.show();
    await db
        .collection(kUSER)
        .doc(auth.currentUser!.uid)
        .update({"hobbies": hobbies});
    await onCall();
    EasyLoading.dismiss();
    Get.back();
  }

  Future deleteUserPhoto(String image) async {
    EasyLoading.show();
    await db.collection(kUSER).doc(auth.currentUser!.uid).update({
      "photos": FieldValue.arrayRemove([image])
    });
    await HomeController.instance.getMyProfile();
    EasyLoading.dismiss();
    Get.back();
  }

  Future deleteAccount() async {
    try {
      EasyLoading.show();

      AuthCredential credential = EmailAuthProvider.credential(
        email: auth.currentUser!.email!,
        password: currentPassword.text,
      );

      await auth.currentUser?.reauthenticateWithCredential(credential);
      await db.collection(kUSER).doc(auth.currentUser!.uid).delete();
      await auth.currentUser!.delete();
      EasyLoading.dismiss();
      Get.offAllNamed(AppRoutes.login);
      EasyLoading.showToast("Account successfully deleted");
    } catch (e) {
      AppToast().showErrorToast(e.toString());
      EasyLoading.dismiss();
    }
  }

  Future changePassword() async {
    if (currentPassword.text.isNotEmpty || newPassword.text.isNotEmpty) {
      if (newPassword.text == coNewPassword.text ||
          currentPassword.text == newPassword.text) {
        try {
          EasyLoading.show();
          AuthCredential credential = EmailAuthProvider.credential(
            email: auth.currentUser!.email!,
            password: currentPassword.text,
          );
          await auth.currentUser?.reauthenticateWithCredential(credential);
          await auth.currentUser!.updatePassword(newPassword.text);
          Get.back();
          EasyLoading.dismiss();
        } catch (e) {
          AppToast().showErrorToast(e.toString());
          EasyLoading.dismiss();
          debugPrint(e.toString());
        }
      } else {
        AppToast().showErrorToast('Password needs to match');
      }
    } else {
      AppToast().showErrorToast('Please enter a valid password');
    }
  }
}
