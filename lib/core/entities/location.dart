import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  const LocationEntity(
      {required this.id,
      required this.latitude,
      required this.longitude,
      required this.place,
      required this.city});

  final String? id;
  final String? place;
  final double? latitude;
  final double? longitude;
  final String? city;

  @override
  List<Object?> get props => [id, latitude, longitude, place, city];
}
