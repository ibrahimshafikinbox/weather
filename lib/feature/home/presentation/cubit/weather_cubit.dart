import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/home/domain/repo/home_weather_repository.dart';
import '../../../../core/errors/failures.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository})
    : super(const WeatherInitial());

  Future<void> loadCurrentWeather() async {
    try {
      emit(const WeatherLoadingState());

      final currentWeather = await weatherRepository
          .getCurrentWeatherByLocation();
      final location = await weatherRepository.getLocationInfo();

      emit(
        CurrentWeatherLoadedState(
          currentWeather: currentWeather,
          location: location,
        ),
      );
    } on Failure catch (failure) {
      emit(WeatherErrorState(errorMessage: failure.message));
    } catch (error) {
      emit(
        WeatherErrorState(
          errorMessage: 'Unexpected error: ${error.toString()}',
        ),
      );
    }
  }

  /// Loads weather forecast using device location
  Future<void> loadForecast({int days = 5}) async {
    try {
      emit(const WeatherLoadingState());

      final forecast = await weatherRepository.getForecastByLocation(
        days: days,
      );

      emit(ForecastLoadedState(forecast: forecast));
    } on Failure catch (failure) {
      emit(WeatherErrorState(errorMessage: failure.message));
    } catch (error) {
      emit(
        WeatherErrorState(
          errorMessage: 'Unexpected error: ${error.toString()}',
        ),
      );
    }
  }

  /// Loads both current weather and forecast using device location
  Future<void> loadCompleteWeatherData({int forecastDays = 5}) async {
    try {
      emit(const WeatherLoadingState());

      final forecast = await weatherRepository.getForecastByLocation(
        days: forecastDays,
      );

      emit(
        WeatherCompleteState(
          currentWeather: forecast.current,
          forecast: forecast,
          location: forecast.location,
        ),
      );
    } on Failure catch (failure) {
      emit(WeatherErrorState(errorMessage: failure.message));
    } catch (error) {
      emit(
        WeatherErrorState(
          errorMessage: 'Unexpected error: ${error.toString()}',
        ),
      );
    }
  }

  /// Loads weather data for a specific city
  Future<void> loadWeatherForCity({
    required String cityName,
    int forecastDays = 5,
  }) async {
    try {
      emit(const WeatherLoadingState());

      final forecast = await weatherRepository.getForecastByCity(
        cityName: cityName,
        days: forecastDays,
      );

      emit(
        WeatherCompleteState(
          currentWeather: forecast.current,
          forecast: forecast,
          location: forecast.location,
        ),
      );
    } on Failure catch (failure) {
      emit(WeatherErrorState(errorMessage: failure.message));
    } catch (error) {
      emit(
        WeatherErrorState(
          errorMessage: 'Unexpected error: ${error.toString()}',
        ),
      );
    }
  }

  /// Refreshes weather data
  Future<void> refreshWeather({int forecastDays = 5}) async {
    await loadCompleteWeatherData(forecastDays: forecastDays);
  }
}
