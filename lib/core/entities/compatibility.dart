import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nexus/core/constant.dart';

class CompatibilityEntity extends Equatable {
  const CompatibilityEntity({
    this.maritalStatus,
    this.haveKids,
    this.genotype,
    this.personalityType,
    this.regularSourceOfIncome,
    this.marrySomeoneNotFS,
    this.longDistance,
    this.believeInCohiabiting,
    this.shouldChristianSpeakInTongue,
    this.believeInTithing,
  });

  @JsonKey(name: kMARITALSTATUS)
  final String? maritalStatus;
  @JsonKey(name: kHAVEKIDS)
  final String? haveKids;
  @JsonKey(name: kGENOTYPE)
  final String? genotype;
  @JsonKey(name: kPERSONALITYTYPE)
  final String? personalityType;
  @JsonKey(name: kREGULARSOURCEOFINCOME)
  final String? regularSourceOfIncome;
  @JsonKey(name: kMARRYWHOISNOTFINANCIALLYSTABLE)
  final String? marrySomeoneNotFS;
  @JsonKey(name: kLONGDISTANCERELATIONSHIP)
  final String? longDistance;
  @JsonKey(name: kBELIEVEINCOHIABITING)
  final String? believeInCohiabiting;
  @JsonKey(name: kSHOULDCHRISTIANSPEAKINTONGUE)
  final String? shouldChristianSpeakInTongue;
  @JsonKey(name: kBELIEVEINTITHING)
  final String? believeInTithing;

  @override
  List<Object?> get props => [
        maritalStatus,
        haveKids,
        genotype,
        personalityType,
        regularSourceOfIncome,
        marrySomeoneNotFS,
        longDistance,
        believeInCohiabiting,
        shouldChristianSpeakInTongue,
        believeInTithing,
      ];
}
