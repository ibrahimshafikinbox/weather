import 'package:equatable/equatable.dart';
import 'package:weather_app/feature/home/data/model/astro_model.dart';
import 'package:weather_app/feature/home/data/model/day_weather_model.dart';
import 'package:weather_app/feature/home/data/model/hourly_weather_model.dart';

class ForecastDayModel extends Equatable {
  final DateTime date;
  final DayWeatherModel day;
  final AstroModel astro;
  final List<HourlyWeatherModel> hourlyForecasts;

  const ForecastDayModel({
    required this.date,
    required this.day,
    required this.astro,
    required this.hourlyForecasts,
  });

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    return ForecastDayModel(
      date: DateTime.parse(json['date'] as String),
      day: DayWeatherModel.fromJson(json['day'] as Map<String, dynamic>),
      astro: AstroModel.fromJson(json['astro'] as Map<String, dynamic>),
      hourlyForecasts: (json['hour'] as List)
          .map(
            (hour) => HourlyWeatherModel.fromJson(hour as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  List<Object?> get props => [date, day, astro, hourlyForecasts];
}
