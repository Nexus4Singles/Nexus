import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nexus/core/constant.dart';
import 'package:nexus/core/models/compatibility.dart';
import 'package:nexus/core/models/location.dart';
// import 'package:nexus/core/constant.dart';

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
    this.educationLevel,
    this.stateOfOrigin,
    this.profession,
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
    this.compatibilitySetted,
    this.location,
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
  @JsonKey(name: kSTATEOFORIGIN)
  final String? stateOfOrigin;
  @JsonKey(name: kEDULEVEL)
  final String? educationLevel;
  final String? profession;
  final List<String>? hobbies;
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
  final LocationModel? location;

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
        registrationProgress,
        country,
        churchName,
        compatibility,
        compatibilitySetted,
        location,
      ];
}
