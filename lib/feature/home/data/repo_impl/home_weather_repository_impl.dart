import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/home/data/model/current_weather_model.dart';
import 'package:weather_app/feature/home/data/model/forecast_model.dart';
import 'package:weather_app/feature/home/data/model/location_model.dart';
import 'package:weather_app/feature/home/data/services/home_weather_service.dart';
import 'package:weather_app/feature/home/domain/repo/home_weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherService weatherService;

  WeatherRepositoryImpl({required this.weatherService});

  @override
  Future<Position> getCurrentLocation() async {
    return await weatherService.fetchCurrentLocation();
  }

  @override
  Future<CurrentWeatherModel> getCurrentWeatherByLocation() async {
    final position = await weatherService.fetchCurrentLocation();

    final weatherData = await weatherService.fetchCurrentWeatherByCoordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    return CurrentWeatherModel.fromJson(
      weatherData['current'] as Map<String, dynamic>,
    );
  }

  @override
  Future<CurrentWeatherModel> getCurrentWeatherByCity({
    required String cityName,
  }) async {
    final weatherData = await weatherService.fetchCurrentWeatherByCity(
      cityName: cityName,
    );

    return CurrentWeatherModel.fromJson(
      weatherData['current'] as Map<String, dynamic>,
    );
  }

  @override
  Future<ForecastModel> getForecastByLocation({int days = 5}) async {
    final position = await weatherService.fetchCurrentLocation();

    final forecastData = await weatherService.fetchForecastByCoordinates(
      latitude: position.latitude,
      longitude: position.longitude,
      days: days,
    );

    return ForecastModel.fromJson(forecastData);
  }

  @override
  Future<ForecastModel> getForecastByCity({
    required String cityName,
    int days = 5,
  }) async {
    final forecastData = await weatherService.fetchForecastByCity(
      cityName: cityName,
      days: days,
    );

    return ForecastModel.fromJson(forecastData);
  }

  @override
  Future<LocationModel> getLocationInfo() async {
    final position = await weatherService.fetchCurrentLocation();

    final weatherData = await weatherService.fetchCurrentWeatherByCoordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    return LocationModel.fromJson(
      weatherData['location'] as Map<String, dynamic>,
    );
  }
}
