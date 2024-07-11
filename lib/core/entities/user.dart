import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/models/compatibility.dart';
import 'package:nexus/core/models/location.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.username,
    this.profileUrl,
    this.isVerified,
    required this.gender,
    required this.age,
    this.city,
    this.matchedUsers,
    this.educationLevel,
    this.stateOfOrigin,
    this.profession,
    this.unrecommendedUsers,
    this.hobbies,
    this.desiredQualities,
    this.photos,
    this.bestQualotiesOrTraits,
    this.relationshipWithGod,
    this.roleOfHusband,
    this.notificationToken,
    this.phoneNumber,
    this.registrationProgress,
    this.country,
    this.churchName,
    this.compatibility,
    this.mySaves,
    this.myLikes,
    this.likeMe,
    this.compatibilitySetted,
    this.location,
    this.countLike,
    this.fcmToken,
  });

  final String id;
  final String name;
  final String username;
  final String email;
  @JsonKey(name: KPROFILEURL)
  final String? profileUrl;
  @JsonKey(name: kISVERIFIED)
  final bool? isVerified;
  final String gender;
  final int age;
  final String? city;
  final int? countLike;
  @JsonKey(name: kSTATEOFORIGIN)
  final String? stateOfOrigin;
  @JsonKey(name: kEDULEVEL)
  final String? educationLevel;
  final String? profession;
  final List<String>? hobbies;
  @JsonKey(name: kMATCHESUSERSKEY)
  final List<String>? matchedUsers;
  @JsonKey(name: kUNRECOMMENDUSER)
  final List<String>? unrecommendedUsers;
  @JsonKey(name: kMATCHESKEY)
  final List<String>? likeMe;
  final List<String>? myLikes;
  final List<String>? mySaves;
  @JsonKey(name: kDESIREDQUALITIES)
  final List<String>? desiredQualities;
  final List<String>? photos;
  @JsonKey(name: kRELATIONSHIPWITHGOD)
  final String? relationshipWithGod;
  @JsonKey(name: kROLEOFHUSBAND)
  final String? roleOfHusband;
  @JsonKey(name: kBESTQUALITIESORTRAITS)
  final String? bestQualotiesOrTraits;
  @JsonKey(name: KNOTIFICATIONTOKEN)
  final String? notificationToken;
  @JsonKey(name: kPHONENUMBER)
  final String? phoneNumber;
  @JsonKey(name: kREGPROGRESS)
  final String? registrationProgress;
  final String? country;
  @JsonKey(name: kCHURCHNAME)
  final String? churchName;
  @JsonKey(name: kCOMPATIBILITY)
  final CompatibilityModel? compatibility;
  @JsonKey(name: kCOMPATIBILITYSETTED)
  final bool? compatibilitySetted;
  @JsonKey(name: kLOCATION)
  final LocationModel? location;
  @JsonKey(name: kFCMTOKEN)
  final String? fcmToken;

  @override
  List<Object?> get props => [
        id,
        email,
        profileUrl,
        name,
        username,
        isVerified,
        gender,
        age,
        city,
        unrecommendedUsers,
        stateOfOrigin,
        educationLevel,
        profession,
        hobbies,
        desiredQualities,
        photos,
        relationshipWithGod,
        roleOfHusband,
        bestQualotiesOrTraits,
        notificationToken,
        phoneNumber,
        matchedUsers,
        registrationProgress,
        country,
        churchName,
        compatibility,
        compatibilitySetted,
        location,
        countLike,
        myLikes,
        mySaves,
        likeMe,
        fcmToken,
      ];
}
