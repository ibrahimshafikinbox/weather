import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final int? id;
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String url;

  const LocationModel({
    this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] is int
          ? map['id'] as int
          : (map['id'] == null ? null : int.tryParse(map['id'].toString())),
      name: map['name'] ?? '',
      region: map['region'] ?? '',
      country: map['country'] ?? '',
      lat: (map['lat'] is num)
          ? (map['lat'] as num).toDouble()
          : double.tryParse('${map['lat']}') ?? 0.0,
      lon: (map['lon'] is num)
          ? (map['lon'] as num).toDouble()
          : double.tryParse('${map['lon']}') ?? 0.0,
      url: map['url'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'region': region,
    'country': country,
    'lat': lat,
    'lon': lon,
    'url': url,
  };

  @override
  List<Object?> get props => [id, name, region, country, lat, lon, url];
}
