// class ApiConstants {
//   ApiConstants._();

//   static const String baseUrl = 'https://api.weatherapi.com/v1';
//   static final String apiKey = dotenv.env['API_KEY'] ?? '';

//   // Endpoints
//   static const String currentWeatherEndpoint = '/current.json';
//   static const String forecastEndpoint = '/forecast.json';
//   //search endpoint
//   // Default parameters
//   static const int defaultForecastDays = 5;
//   static const String enableAirQuality = 'yes';
//   static const String disableAlerts = 'no';
// }
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.weatherapi.com/v1';
  static final String apiKey = dotenv.env['API_KEY'] ?? '';

  // Endpoints
  static const String currentWeatherEndpoint = '/current.json';
  static const String forecastEndpoint = '/forecast.json';
  static const String searchEndpoint = '/search.json';

  // Default parameters
  static const int defaultForecastDays = 5;
  static const String enableAirQuality = 'yes';
  static const String disableAlerts = 'no';
}
