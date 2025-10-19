import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/api_client.dart';
import 'package:weather_app/feature/home/data/services/home_weather_service.dart';

@GenerateMocks([ApiClient])
import 'weather_service_test.mocks.dart';

void main() {
  late MockApiClient mockApiClient;
  late WeatherService weatherService;

  setUp(() {
    mockApiClient = MockApiClient();
    weatherService = WeatherService(apiClient: mockApiClient);
  });

  test('should fetch weather data for a city successfully', () async {
    // Arrange
    when(
      mockApiClient.get(
        url: anyNamed('url'),
        queryParameters: anyNamed('queryParameters'),
      ),
    ).thenAnswer((_) async => {'temp': 30});

    // Act
    final result = await weatherService.fetchCurrentWeatherByCity(
      cityName: 'Cairo',
    );

    // Assert
    expect(result['temp'], 30);
    verify(
      mockApiClient.get(
        url: anyNamed('url'),
        queryParameters: anyNamed('queryParameters'),
      ),
    ).called(1);
  });
}
