import 'package:equatable/equatable.dart';
import 'package:weather_app/feature/home/data/model/weather_condition_model.dart';

class HourlyWeatherModel extends Equatable {
  final DateTime time;
  final double temperatureCelsius;
  final double temperatureFahrenheit;
  final bool isDay;
  final WeatherConditionModel condition;
  final double windSpeedMph;
  final double windSpeedKph;
  final int windDegree;
  final String windDirection;
  final int humidity;
  final int cloudCoverage;
  final double feelsLikeCelsius;
  final int chanceOfRain;
  final int chanceOfSnow;
  final double visibilityKm;
  final double gustMph;
  final double gustKph;
  final double uvIndex;

  const HourlyWeatherModel({
    required this.time,
    required this.temperatureCelsius,
    required this.temperatureFahrenheit,
    required this.isDay,
    required this.condition,
    required this.windSpeedMph,
    required this.windSpeedKph,
    required this.windDegree,
    required this.windDirection,
    required this.humidity,
    required this.cloudCoverage,
    required this.feelsLikeCelsius,
    required this.chanceOfRain,
    required this.chanceOfSnow,
    required this.visibilityKm,
    required this.gustMph,
    required this.gustKph,
    required this.uvIndex,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      time: DateTime.fromMillisecondsSinceEpoch(
        (json['time_epoch'] as int) * 1000,
      ),
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
      humidity: json['humidity'] as int,
      cloudCoverage: json['cloud'] as int,
      feelsLikeCelsius: (json['feelslike_c'] as num).toDouble(),
      chanceOfRain: json['chance_of_rain'] as int,
      chanceOfSnow: json['chance_of_snow'] as int,
      visibilityKm: (json['vis_km'] as num).toDouble(),
      gustMph: (json['gust_mph'] as num).toDouble(),
      gustKph: (json['gust_kph'] as num).toDouble(),
      uvIndex: (json['uv'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [time, temperatureCelsius, condition];
}
