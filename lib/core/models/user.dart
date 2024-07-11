import 'package:json_annotation/json_annotation.dart';
import 'package:nexus/core/entities/user.dart';
import 'package:nexus/core/models/compatibility.dart';
import 'package:nexus/core/models/location.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String username,
    required String email,
    String? profileUrl,
    required int age,
    required String gender,
    String? bestQualotiesOrTraits,
    String? city,
    int? countLike,
    List<String>? desiredQualities,
    List<String>? hobbies,
    List<String>? photos,
    List<String>? likeMe,
    List<String>? myLikes,
    List<String>? mySaves,
    List<String>? matchedUsers,
    List<String>? unRecommendUsers,
    String? educationLevel,
    String? profession,
    String? relationshipWithGod,
    String? roleOfHusband,
    String? stateOfOrigin,
    bool? isVerified,
    String? notificationToken,
    String? phoneNumber,
    String? registrationProgress,
    String? country,
    String? churchName,
    CompatibilityModel? compatibility,
    bool? compatibilitySetted,
    LocationModel? location,
  }) : super(
          id: id,
          name: name,
          username: username,
          email: email,
          profileUrl: profileUrl,
          age: age,
          gender: gender,
          unrecommendedUsers: unRecommendUsers,
          bestQualotiesOrTraits: bestQualotiesOrTraits,
          city: city,
          matchedUsers: matchedUsers,
          desiredQualities: desiredQualities,
          educationLevel: educationLevel,
          likeMe: likeMe,
          myLikes: myLikes,
          mySaves: mySaves,
          hobbies: hobbies,
          isVerified: isVerified,
          photos: photos,
          profession: profession,
          relationshipWithGod: relationshipWithGod,
          roleOfHusband: roleOfHusband,
          stateOfOrigin: stateOfOrigin,
          notificationToken: notificationToken,
          phoneNumber: phoneNumber,
          registrationProgress: registrationProgress,
          country: country,
          countLike: countLike,
          churchName: churchName,
          compatibility: compatibility,
          compatibilitySetted: compatibilitySetted,
          location: location,
        );

  factory UserModel.fromJson(Map<String, dynamic> map) =>
      _$UserModelFromJson(map);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
