import 'package:json_annotation/json_annotation.dart';
import 'package:nexus/core/entities/user.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String email,
    String? profileUrl,
    required int age,
    required String gender,
    String? bestQualotiesOrTraits,
    String? city,
    List<String>? desiredQualities,
    List<String>? hobbies,
    List<String>? photos,
    String? educationLevel,
    String? profession,
    String? relationshipWithGod,
    String? roleOfHusband,
    String? stateOfOrigin,
    bool? isVerified,
    String? notificationToken,
    String? phoneNumber,
    String? registrationProgress,
  }) : super(
          id: id,
          name: name,
          email: email,
          profileUrl: profileUrl,
          age: age,
          gender: gender,
          bestQualotiesOrTraits: bestQualotiesOrTraits,
          city: city,
          desiredQualities: desiredQualities,
          educationLevel: educationLevel,
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
        );

  factory UserModel.fromJson(Map<String, dynamic> map) =>
      _$UserModelFromJson(map);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
