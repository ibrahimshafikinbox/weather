import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/home/data/model/current_weather_model.dart';
import 'package:weather_app/feature/home/data/model/forecast_model.dart';
import 'package:weather_app/feature/home/data/model/location_model.dart';

abstract class WeatherRepository {
  /// Gets the current device location
  Future<Position> getCurrentLocation();

  /// Gets location information based on current coordinates
  Future<LocationModel> getLocationInfo();

  /// Gets current weather data using device location
  Future<CurrentWeatherModel> getCurrentWeatherByLocation();

  /// Gets current weather data for a specific city
  Future<CurrentWeatherModel> getCurrentWeatherByCity({
    required String cityName,
  });

  /// Gets weather forecast using device location
  Future<ForecastModel> getForecastByLocation({int days = 5});

  /// Gets weather forecast for a specific city
  Future<ForecastModel> getForecastByCity({
    required String cityName,
    int days = 5,
  });
}
