import 'package:json_annotation/json_annotation.dart';
import 'package:nexus/core/entities/location.dart';

part 'location.g.dart';

@JsonSerializable()
class LocationModel extends LocationEntity {
  const LocationModel({
    required String? id,
    required double? latitude,
    required double? longitude,
    required String? place,
    required String? country,
    required String? city,
  }) : super(
            id: id,
            latitude: latitude,
            country: country,
            longitude: longitude,
            place: place,
            city: city);

  factory LocationModel.fromJson(Map<String, dynamic> map) =>
      _$LocationModelFromJson(map);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
