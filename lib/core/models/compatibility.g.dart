// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compatibility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompatibilityModel _$CompatibilityModelFromJson(Map<String, dynamic> json) =>
    CompatibilityModel(
      maritalStatus: json['marital_status'] as String?,
      haveKids: json['have_kids'] as String?,
      genotype: json['genotype'] as String?,
      personalityType: json['personality_type'] as String?,
      regularSourceOfIncome: json['regular_source_of_income'] as String?,
      marrySomeoneNotFS: json['marry_someone_fs'] as String?,
      longDistance: json['long_distance'] as String? ?? '',
      believeInCohiabiting: json['believe_cohabiting'] as String?,
      shouldChristianSpeakInTongue:
          json['should_christian_speak_in_tongue'] as String?,
      believeInTithing: json['believe_in_tithing'] as String?,
    );

Map<String, dynamic> _$CompatibilityModelToJson(CompatibilityModel instance) =>
    <String, dynamic>{
      'marital_status': instance.maritalStatus,
      'have_kids': instance.haveKids,
      'genotype': instance.genotype,
      'personality_type': instance.personalityType,
      'regular_source_of_income': instance.regularSourceOfIncome,
      'marry_someone_fs': instance.marrySomeoneNotFS,
      'long_distance': instance.longDistance,
      'believe_cohabiting': instance.believeInCohiabiting,
      'should_christian_speak_in_tongue': instance.shouldChristianSpeakInTongue,
      'believe_in_tithing': instance.believeInTithing,
    };
