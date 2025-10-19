import 'package:equatable/equatable.dart';
import 'current_weather_model.dart';
import 'forecast_day_model.dart';
import 'location_model.dart';

class ForecastModel extends Equatable {
  final LocationModel location;
  final CurrentWeatherModel current;
  final List<ForecastDayModel> forecastDays;

  const ForecastModel({
    required this.location,
    required this.current,
    required this.forecastDays,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      location: LocationModel.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      current: CurrentWeatherModel.fromJson(
        json['current'] as Map<String, dynamic>,
      ),
      forecastDays:
          ((json['forecast'] as Map<String, dynamic>)['forecastday'] as List)
              .map(
                (day) => ForecastDayModel.fromJson(day as Map<String, dynamic>),
              )
              .toList(),
    );
  }

  @override
  List<Object?> get props => [location, current, forecastDays];
}
