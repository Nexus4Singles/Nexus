// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileUrl: json['profile_url'] as String?,
      age: json['age'] as int,
      gender: json['gender'] as String,
      bestQualotiesOrTraits: json['best_qualities_or_traits'] as String?,
      city: json['city'] as String?,
      desiredQualities: (json['desired_qualities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      hobbies:
          (json['hobbies'] as List<dynamic>?)?.map((e) => e as String).toList(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      educationLevel: json['education_level'] as String?,
      profession: json['profession'] as String?,
      relationshipWithGod: json['relationship_with_god'] as String?,
      roleOfHusband: json['role_of_husband'] as String?,
      stateOfOrigin: json['state_of_origin'] as String?,
      isVerified: json['is_verified'] as bool?,
      notificationToken: json['notification_token'] as String?,
      phoneNumber: json['phone_number'] as String?,
      registrationProgress: json['registration_progress'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'profile_url': instance.profileUrl,
      'is_verified': instance.isVerified,
      'gender': instance.gender,
      'age': instance.age,
      'city': instance.city,
      'state_of_origin': instance.stateOfOrigin,
      'education_level': instance.educationLevel,
      'profession': instance.profession,
      'hobbies': instance.hobbies,
      'desired_qualities': instance.desiredQualities,
      'photos': instance.photos,
      'relationship_with_god': instance.relationshipWithGod,
      'role_of_husband': instance.roleOfHusband,
      'best_qualities_or_traits': instance.bestQualotiesOrTraits,
      'notification_token': instance.notificationToken,
      'phone_number': instance.phoneNumber,
      'registration_progress': instance.registrationProgress,
    };
