import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/models/locationIQModel.dart';
import 'package:nexus/core/utils/methods.dart';
import 'package:nexus/core/utils/toast.dart';
import 'package:nexus/router.dart';
import '../../../../core/models/location.dart';

class ProfileCtr extends GetxController {
  static ProfileCtr get instance => Get.find<ProfileCtr>();
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
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

  updateProfile(List<File> imageFiles) async {
    EasyLoading.show();
    if (isEmpty()) {
      if (imageFiles.isNotEmpty) {
        await sendImageToDb(imageFiles);
      }
      await db.collection(kUSER).doc(auth.currentUser!.uid).update({
        "photos": FieldValue.arrayUnion(imageUrls),
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
      Get.back();
      EasyLoading.dismiss();
    } else {
      EasyLoading.showToast("Kindly fill all fields");
    }
  }

  sendImageToDb(List<File> imageFiles) async {
    for (var file in imageFiles) {
      await upload(file).then((value) {
        imageUrls.add(value);
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
    EasyLoading.dismiss();
    Get.back();
  }

  Future deleteAccount() async {
    try {
      EasyLoading.show();
      await auth.currentUser!.delete();
      EasyLoading.dismiss();
      Get.offAllNamed(AppRoutes.login);
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
