class LocationIqModel {
  LocationIqModel({
    this.placeId,
    this.osmId,
    this.osmType,
    this.licence,
    this.lat,
    this.lon,
    this.boundingbox,
    this.locationIqModelClass,
    this.type,
    this.displayName,
    this.displayPlace,
    this.displayAddress,
    this.address,
  });

  String? placeId;
  final String? osmId;
  final String? osmType;
  final String? licence;
  final String? lat;
  final String? lon;
  final List<String>? boundingbox;
  final String? locationIqModelClass;
  final String? type;
  final String? displayName;
  final String? displayPlace;
  final String? displayAddress;
  final Address? address;

  factory LocationIqModel.fromJson(Map<String, dynamic> json) {
    return LocationIqModel(
      placeId: json["place_id"],
      osmId: json["osm_id"],
      osmType: json["osm_type"],
      licence: json["licence"],
      lat: json["lat"],
      lon: json["lon"],
      boundingbox: json["boundingbox"] == null
          ? []
          : List<String>.from(json["boundingbox"]!.map((x) => x)),
      locationIqModelClass: json["class"],
      type: json["type"],
      displayName: json["display_name"],
      displayPlace: json["display_place"],
      displayAddress: json["display_address"],
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
    );
  }
}

class Address {
  Address({
    this.name,
    this.county,
    this.state,
    this.postcode,
    this.country,
    this.countryCode,
    this.road,
    this.city,
    this.suburb,
  });

  final String? name;
  final String? county;
  final String? state;
  final String? postcode;
  final String? country;
  final String? countryCode;
  final String? road;
  final String? city;
  final String? suburb;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      name: json["name"],
      county: json["county"],
      state: json["state"],
      postcode: json["postcode"],
      country: json["country"],
      countryCode: json["country_code"],
      road: json["road"],
      city: json["city"],
      suburb: json["suburb"],
    );
  }
}
