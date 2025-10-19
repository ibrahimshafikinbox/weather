import 'package:equatable/equatable.dart' show Equatable;
import 'package:weather_app/feature/home/data/model/weather_condition_model.dart';

class DayWeatherModel extends Equatable {
  final double maxTempCelsius;
  final double maxTempFahrenheit;
  final double minTempCelsius;
  final double minTempFahrenheit;
  final double avgTempCelsius;
  final double avgTempFahrenheit;
  final double maxWindSpeedMph;
  final double maxWindSpeedKph;
  final double totalPrecipitationMm;
  final double avgVisibilityKm;
  final int avgHumidity;
  final int dailyChanceOfRain;
  final int dailyChanceOfSnow;
  final WeatherConditionModel condition;
  final double uvIndex;

  const DayWeatherModel({
    required this.maxTempCelsius,
    required this.maxTempFahrenheit,
    required this.minTempCelsius,
    required this.minTempFahrenheit,
    required this.avgTempCelsius,
    required this.avgTempFahrenheit,
    required this.maxWindSpeedMph,
    required this.maxWindSpeedKph,
    required this.totalPrecipitationMm,
    required this.avgVisibilityKm,
    required this.avgHumidity,
    required this.dailyChanceOfRain,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uvIndex,
  });

  factory DayWeatherModel.fromJson(Map<String, dynamic> json) {
    return DayWeatherModel(
      maxTempCelsius: (json['maxtemp_c'] as num).toDouble(),
      maxTempFahrenheit: (json['maxtemp_f'] as num).toDouble(),
      minTempCelsius: (json['mintemp_c'] as num).toDouble(),
      minTempFahrenheit: (json['mintemp_f'] as num).toDouble(),
      avgTempCelsius: (json['avgtemp_c'] as num).toDouble(),
      avgTempFahrenheit: (json['avgtemp_f'] as num).toDouble(),
      maxWindSpeedMph: (json['maxwind_mph'] as num).toDouble(),
      maxWindSpeedKph: (json['maxwind_kph'] as num).toDouble(),
      totalPrecipitationMm: (json['totalprecip_mm'] as num).toDouble(),
      avgVisibilityKm: (json['avgvis_km'] as num).toDouble(),
      avgHumidity: json['avghumidity'] as int,
      dailyChanceOfRain: json['daily_chance_of_rain'] as int,
      dailyChanceOfSnow: json['daily_chance_of_snow'] as int,
      condition: WeatherConditionModel.fromJson(
        json['condition'] as Map<String, dynamic>,
      ),
      uvIndex: (json['uv'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [maxTempCelsius, minTempCelsius, condition];
}
