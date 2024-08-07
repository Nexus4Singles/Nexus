import 'package:json_annotation/json_annotation.dart';
import 'package:Nexus/core/entities/location.dart';

part 'location.g.dart';

@JsonSerializable()
class LocationModel extends LocationEntity {
  const LocationModel({
    required String? id,
    required double? latitude,
    required double? longitude,
    required String? place,
    required String? city,
  }) : super(
            id: id,
            // image: image,
            latitude: latitude,
            longitude: longitude,
            place: place,
            city: city);

  factory LocationModel.fromJson(Map<String, dynamic> map) =>
      _$LocationModelFromJson(map);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
