import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/utils/logger/app_logger.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';

class WeatherService {
  final ApiClient apiClient;

  WeatherService({required this.apiClient});

  /// Fetches the current location coordinates (latitude and longitude)
  Future<Position> fetchCurrentLocation() async {
    AppLogger.i('Starting location fetch...');
    try {
      final bool isServiceEnabled = await _checkLocationService();
      if (!isServiceEnabled) {
        AppLogger.w('Location services are disabled.');
        throw const LocationServiceFailure(
          message: 'Location services are disabled. Please enable them.',
        );
      }

      final LocationPermission permission = await _checkLocationPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        AppLogger.w('Location permission denied.');
        throw const LocationPermissionFailure(
          message: 'Location permission is required to fetch weather data.',
        );
      }

      final position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );

      AppLogger.d(
        'Current position: (${position.latitude}, ${position.longitude})',
      );
      return position;
    } catch (e, s) {
      AppLogger.e('Failed to get current location', e, s);
      if (e is Failure) rethrow;
      throw LocationServiceFailure(
        message: 'Failed to get location: ${e.toString()}',
      );
    }
  }

  /// Fetches current weather data for given coordinates
  Future<Map<String, dynamic>> fetchCurrentWeatherByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    final queryParams = _buildCurrentWeatherQueryParams(
      query: '$latitude,$longitude',
    );

    AppLogger.i(
      'Fetching current weather for coordinates: ($latitude, $longitude)',
    );
    try {
      final response = await apiClient.get(
        url: '${ApiConstants.baseUrl}${ApiConstants.currentWeatherEndpoint}',
        queryParameters: queryParams,
      );
      AppLogger.d('Weather data received successfully');
      return response;
    } catch (e, s) {
      AppLogger.e('Error fetching current weather by coordinates', e, s);
      rethrow;
    }
  }

  /// Fetches current weather data for a city name
  Future<Map<String, dynamic>> fetchCurrentWeatherByCity({
    required String cityName,
  }) async {
    AppLogger.i('Fetching current weather for city: $cityName');
    final queryParams = _buildCurrentWeatherQueryParams(query: cityName);

    try {
      final response = await apiClient.get(
        url: '${ApiConstants.baseUrl}${ApiConstants.currentWeatherEndpoint}',
        queryParameters: queryParams,
      );
      AppLogger.d('Weather data fetched successfully for $cityName');
      return response;
    } catch (e, s) {
      AppLogger.e('Error fetching weather for $cityName', e, s);
      rethrow;
    }
  }

  /// Fetches weather forecast data for given coordinates
  Future<Map<String, dynamic>> fetchForecastByCoordinates({
    required double latitude,
    required double longitude,
    int days = 5,
  }) async {
    AppLogger.i(
      'Fetching forecast for coordinates: ($latitude, $longitude), days: $days',
    );
    final queryParams = _buildForecastQueryParams(
      query: '$latitude,$longitude',
      days: days,
    );

    try {
      final response = await apiClient.get(
        url: '${ApiConstants.baseUrl}${ApiConstants.forecastEndpoint}',
        queryParameters: queryParams,
      );
      AppLogger.d('Forecast data received successfully');
      return response;
    } catch (e, s) {
      AppLogger.e('Error fetching forecast by coordinates', e, s);
      rethrow;
    }
  }

  /// Fetches weather forecast data for a city name
  Future<Map<String, dynamic>> fetchForecastByCity({
    required String cityName,
    int days = 5,
  }) async {
    AppLogger.i('Fetching forecast for city: $cityName, days: $days');
    final queryParams = _buildForecastQueryParams(query: cityName, days: days);

    try {
      final response = await apiClient.get(
        url: '${ApiConstants.baseUrl}${ApiConstants.forecastEndpoint}',
        queryParameters: queryParams,
      );
      AppLogger.d('Forecast data fetched successfully for $cityName');
      return response;
    } catch (e, s) {
      AppLogger.e('Error fetching forecast for $cityName', e, s);
      rethrow;
    }
  }

  // 🔹 Private helper methods

  Future<bool> _checkLocationService() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<LocationPermission> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      AppLogger.w('Requesting location permission...');
      permission = await Geolocator.requestPermission();
    }

    return permission;
  }

  Map<String, String> _buildCurrentWeatherQueryParams({required String query}) {
    return {
      'key': ApiConstants.apiKey,
      'q': query,
      'aqi': ApiConstants.enableAirQuality,
    };
  }

  Map<String, String> _buildForecastQueryParams({
    required String query,
    required int days,
  }) {
    return {
      'key': ApiConstants.apiKey,
      'q': query,
      'days': days.toString(),
      'aqi': ApiConstants.enableAirQuality,
      'alerts': ApiConstants.disableAlerts,
    };
  }
}
