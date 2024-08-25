import 'package:json_annotation/json_annotation.dart';
import '../entities/compatibility.dart';
part 'compatibility.g.dart';

@JsonSerializable()
class CompatibilityModel extends CompatibilityEntity {
  const CompatibilityModel({
    final String? maritalStatus,
    final String? haveKids,
    final String? genotype,
    final String? personalityType,
    final String? regularSourceOfIncome,
    final String? marrySomeoneNotFS,
    final String? longDistance,
    final String? believeInCohiabiting,
    final String? shouldChristianSpeakInTongue,
    final String? believeInTithing,
  }) : super(
          maritalStatus: maritalStatus,
          haveKids: haveKids,
          genotype: genotype,
          personalityType: personalityType,
          regularSourceOfIncome: regularSourceOfIncome,
          marrySomeoneNotFS: marrySomeoneNotFS,
          longDistance: longDistance,
          believeInCohiabiting: believeInCohiabiting,
          shouldChristianSpeakInTongue: shouldChristianSpeakInTongue,
          believeInTithing: believeInCohiabiting,
        );

  factory CompatibilityModel.fromJson(Map<String, dynamic> map) =>
      _$CompatibilityModelFromJson(map);

  Map<String, dynamic> toJson() => _$CompatibilityModelToJson(this);
}
