import 'package:equatable/equatable.dart';
import 'package:weather_app/feature/home/data/model/current_weather_model.dart';
import 'package:weather_app/feature/home/data/model/forecast_model.dart';
import 'package:weather_app/feature/home/data/model/location_model.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

class CurrentWeatherLoadedState extends WeatherState {
  final CurrentWeatherModel currentWeather;
  final LocationModel location;

  const CurrentWeatherLoadedState({
    required this.currentWeather,
    required this.location,
  });

  @override
  List<Object?> get props => [currentWeather, location];
}

class ForecastLoadedState extends WeatherState {
  final ForecastModel forecast;

  const ForecastLoadedState({required this.forecast});

  @override
  List<Object?> get props => [forecast];
}

class WeatherCompleteState extends WeatherState {
  final CurrentWeatherModel currentWeather;
  final ForecastModel forecast;
  final LocationModel location;

  const WeatherCompleteState({
    required this.currentWeather,
    required this.forecast,
    required this.location,
  });

  @override
  List<Object?> get props => [currentWeather, forecast, location];
}

class WeatherErrorState extends WeatherState {
  final String errorMessage;

  const WeatherErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
