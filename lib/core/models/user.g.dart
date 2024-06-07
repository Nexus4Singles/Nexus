// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
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
      likeMe:
          (json['likeMe'] as List<dynamic>?)?.map((e) => e as String).toList(),
      myLikes:
          (json['myLikes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      mySaves:
          (json['mySaves'] as List<dynamic>?)?.map((e) => e as String).toList(),
      educationLevel: json['education_level'] as String?,
      profession: json['profession'] as String?,
      relationshipWithGod: json['relationship_with_god'] as String?,
      roleOfHusband: json['role_of_husband'] as String?,
      stateOfOrigin: json['state_of_origin'] as String?,
      isVerified: json['is_verified'] as bool?,
      notificationToken: json['notification_token'] as String?,
      phoneNumber: json['phone_number'] as String?,
      registrationProgress: json['registration_progress'] as String?,
      country: json['country'] as String?,
      churchName: json['church_name'] as String?,
      compatibility: json['compatibility'] == null
          ? null
          : CompatibilityModel.fromJson(
              json['compatibility'] as Map<String, dynamic>),
      compatibilitySetted: json['compatibility_setted'] as bool?,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
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
      'likeMe': instance.likeMe,
      'myLikes': instance.myLikes,
      'mySaves': instance.mySaves,
      'desired_qualities': instance.desiredQualities,
      'photos': instance.photos,
      'relationship_with_god': instance.relationshipWithGod,
      'role_of_husband': instance.roleOfHusband,
      'best_qualities_or_traits': instance.bestQualotiesOrTraits,
      'notification_token': instance.notificationToken,
      'phone_number': instance.phoneNumber,
      'registration_progress': instance.registrationProgress,
      'country': instance.country,
      'church_name': instance.churchName,
      'compatibility': instance.compatibility,
      'compatibility_setted': instance.compatibilitySetted,
      'location': instance.location,
    };
