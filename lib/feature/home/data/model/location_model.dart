import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String name;
  final String region;
  final String country;
  final double latitude;
  final double longitude;
  final String timezone;
  final String localtime;

  const LocationModel({
    required this.name,
    required this.region,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.localtime,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] as String,
      region: json['region'] as String,
      country: json['country'] as String,
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lon'] as num).toDouble(),
      timezone: json['tz_id'] as String,
      localtime: json['localtime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'lat': latitude,
      'lon': longitude,
      'tz_id': timezone,
      'localtime': localtime,
    };
  }

  @override
  List<Object?> get props => [
    name,
    region,
    country,
    latitude,
    longitude,
    timezone,
    localtime,
  ];
}
