import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nexus/core/constant.dart';
import '../../../../core/models/location.dart';

class ProfileCtr extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  TextEditingController searchText = TextEditingController();
  TextEditingController usernameCtr = TextEditingController();
  var eduLevel = "".obs;
  var profession = "".obs;
  var church = "".obs;
  var city = "".obs;
  LocationModel? locationModel;

  Future<void> getFormattedLocation(
      double latitude, double longitude, String pId) async {
    EasyLoading.show();
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?place_id=$pId&key=AIzaSyDK9B0jBJl2A3NdXfhKzFAqreY_Djr249Y';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    // Logger().d(data);
    final address = data['results'][0]['formatted_address'];
    final placeId = data['results'][0]['place_id'];

    Map<String, dynamic> loc = {
      'place': address,
      'latitude': latitude,
      'longitude': longitude,
      'id': placeId,
      'city': data['results'][0]['address_components'][0]['long_name'],
    };
    locationModel = LocationModel.fromJson(loc);
    searchText.text = address;
    city = data['results'][0]['address_components'][0]['long_name'];
    update();
    EasyLoading.dismiss();
  }

  updateProfile() async {
    EasyLoading.show();
    await db.collection(kUSER).doc(auth.currentUser!.uid).update({
      "username": usernameCtr.text,
      'education_level': eduLevel.value,
      'profession': profession.value,
      'church_name': church.value,
      'location': locationModel?.toJson()
    });
    Get.back();
    EasyLoading.dismiss();
  }

  updateQualities(List<String> desiredQualities) async {
    EasyLoading.show();
    await db
        .collection(kUSER)
        .doc(auth.currentUser!.uid)
        .update({"desired_qualities": desiredQualities});
    Get.back();
    EasyLoading.dismiss();
  }

  updateHobbies(List<String> hobbies) async {
    print("this are the hobbies ==> $hobbies");
    EasyLoading.show();
    await db
        .collection(kUSER)
        .doc(auth.currentUser!.uid)
        .update({"hobbies": hobbies});
    Get.back();
    EasyLoading.dismiss();
  }
}
