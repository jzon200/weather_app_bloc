import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

enum LocationType {
  @JsonValue('City')
  city,
  @JsonValue('Region')
  region,
  @JsonValue('State')
  state,
  @JsonValue('Province')
  province,
  @JsonValue('Country')
  country,
  @JsonValue('Continent')
  continent,
}

@JsonSerializable()
class Location {
  final String title;
  final LocationType locationType;
  @JsonKey(name: 'latt_long')
  @LatLngConverter()
  final LatLng latLng;
  final int woeid;

  const Location({
    required this.title,
    required this.locationType,
    required this.latLng,
    required this.woeid,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

class LatLng {
  final double latitude;
  final double longitude;

  const LatLng({required this.latitude, required this.longitude});
}

class LatLngConverter implements JsonConverter<LatLng, String> {
  const LatLngConverter();

  @override
  LatLng fromJson(String json) {
    final parts = json.split(',');
    return LatLng(
      latitude: double.tryParse(parts[0]) ?? 0,
      longitude: double.tryParse(parts[1]) ?? 0,
    );
  }

  @override
  String toJson(LatLng latLng) {
    return '${latLng.latitude},${latLng.longitude}';
  }
}
