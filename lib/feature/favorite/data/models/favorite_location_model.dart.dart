class FavoriteLocationModel {
  final int? id;
  final String name;
  final String country;
  final double latitude;
  final double longitude;
  final DateTime addedAt;

  const FavoriteLocationModel({
    this.id,
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.addedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'added_at': addedAt.toIso8601String(),
    };
  }

  factory FavoriteLocationModel.fromMap(Map<String, dynamic> map) {
    return FavoriteLocationModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      country: map['country'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      addedAt: DateTime.parse(map['added_at'] as String),
    );
  }

  FavoriteLocationModel copyWith({
    int? id,
    String? name,
    String? country,
    double? latitude,
    double? longitude,
    DateTime? addedAt,
  }) {
    return FavoriteLocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteLocationModel &&
        other.id == id &&
        other.name == name &&
        other.country == country &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        country.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
