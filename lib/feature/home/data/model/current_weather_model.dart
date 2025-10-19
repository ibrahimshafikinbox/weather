import 'package:equatable/equatable.dart';
import 'air_quality_model.dart';
import 'weather_condition_model.dart';

class CurrentWeatherModel extends Equatable {
  final DateTime lastUpdated;
  final double temperatureCelsius;
  final double temperatureFahrenheit;
  final bool isDay;
  final WeatherConditionModel condition;
  final double windSpeedMph;
  final double windSpeedKph;
  final int windDegree;
  final String windDirection;
  final double pressureMb;
  final double pressureIn;
  final double precipitationMm;
  final double precipitationIn;
  final int humidity;
  final int cloudCoverage;
  final double feelsLikeCelsius;
  final double feelsLikeFahrenheit;
  final double visibilityKm;
  final double visibilityMiles;
  final double uvIndex;
  final double gustMph;
  final double gustKph;
  final AirQualityModel? airQuality;

  const CurrentWeatherModel({
    required this.lastUpdated,
    required this.temperatureCelsius,
    required this.temperatureFahrenheit,
    required this.isDay,
    required this.condition,
    required this.windSpeedMph,
    required this.windSpeedKph,
    required this.windDegree,
    required this.windDirection,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipitationMm,
    required this.precipitationIn,
    required this.humidity,
    required this.cloudCoverage,
    required this.feelsLikeCelsius,
    required this.feelsLikeFahrenheit,
    required this.visibilityKm,
    required this.visibilityMiles,
    required this.uvIndex,
    required this.gustMph,
    required this.gustKph,
    this.airQuality,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      lastUpdated: DateTime.parse(json['last_updated'] as String),
      temperatureCelsius: (json['temp_c'] as num).toDouble(),
      temperatureFahrenheit: (json['temp_f'] as num).toDouble(),
      isDay: json['is_day'] == 1,
      condition: WeatherConditionModel.fromJson(
        json['condition'] as Map<String, dynamic>,
      ),
      windSpeedMph: (json['wind_mph'] as num).toDouble(),
      windSpeedKph: (json['wind_kph'] as num).toDouble(),
      windDegree: json['wind_degree'] as int,
      windDirection: json['wind_dir'] as String,
      pressureMb: (json['pressure_mb'] as num).toDouble(),
      pressureIn: (json['pressure_in'] as num).toDouble(),
      precipitationMm: (json['precip_mm'] as num).toDouble(),
      precipitationIn: (json['precip_in'] as num).toDouble(),
      humidity: json['humidity'] as int,
      cloudCoverage: json['cloud'] as int,
      feelsLikeCelsius: (json['feelslike_c'] as num).toDouble(),
      feelsLikeFahrenheit: (json['feelslike_f'] as num).toDouble(),
      visibilityKm: (json['vis_km'] as num).toDouble(),
      visibilityMiles: (json['vis_miles'] as num).toDouble(),
      uvIndex: (json['uv'] as num).toDouble(),
      gustMph: (json['gust_mph'] as num).toDouble(),
      gustKph: (json['gust_kph'] as num).toDouble(),
      airQuality: json['air_quality'] != null
          ? AirQualityModel.fromJson(
              json['air_quality'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  @override
  List<Object?> get props => [
    lastUpdated,
    temperatureCelsius,
    isDay,
    condition,
    windSpeedKph,
    humidity,
    airQuality,
  ];
}
