// lib/feature/search/data/services/search_service.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:weather_app/core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/logger/app_logger.dart';
import '../models/location_model.dart';

class SearchService {
  final ApiClient apiClient;
  final String apiKey;
  final String basePath;

  SearchService({
    required this.apiClient,
    required this.apiKey,
    this.basePath = ApiConstants.baseUrl,
  });

  Future<List<LocationModel>> searchLocations(String query) async {
    final url = '$basePath${ApiConstants.searchEndpoint}';
    AppLogger.i('Searching locations for query: $query');

    try {
      final dioResponse = await apiClient.dio.get(
        url,
        queryParameters: {'q': query, 'key': apiKey},
      );

      final rawData = dioResponse.data;
      AppLogger.d('Response status: ${dioResponse.statusCode}');

      if (dioResponse.statusCode != 200) {
        AppLogger.w('Server returned status ${dioResponse.statusCode}');
        throw ServerFailure(
          message: 'Server returned status ${dioResponse.statusCode}: $rawData',
        );
      }

      if (rawData == null) {
        AppLogger.e('Response body is null');
        throw ServerFailure(message: 'Response body is null');
      }

      if (rawData is List) {
        final result = <LocationModel>[];

        for (var i = 0; i < rawData.length; i++) {
          final item = rawData[i];
          try {
            if (item is Map<String, dynamic>) {
              result.add(LocationModel.fromMap(item));
            } else if (item is Map) {
              final safeMap = Map<String, dynamic>.from(item);
              result.add(LocationModel.fromMap(safeMap));
            } else if (item is String) {
              final decoded = jsonDecode(item);
              if (decoded is Map<String, dynamic>) {
                result.add(LocationModel.fromMap(decoded));
              } else {
                AppLogger.w('Item $i is not a map after decode');
              }
            } else {
              AppLogger.w(
                'Unexpected item type at index $i: ${item.runtimeType}',
              );
            }
          } catch (e, st) {
            AppLogger.e('Error parsing item at index $i', e, st);
            rethrow;
          }
        }

        AppLogger.i('Parsed ${result.length} locations successfully');
        return result;
      }

      if (rawData is Map) {
        if (rawData.containsKey('results') && rawData['results'] is List) {
          final inner = rawData['results'] as List<dynamic>;
          AppLogger.i('Found ${inner.length} results in response map');
          return inner
              .map((e) => LocationModel.fromMap(Map<String, dynamic>.from(e)))
              .toList();
        }

        if (rawData.containsKey('error')) {
          AppLogger.e('API error: ${rawData['error']}');
          throw ServerFailure(message: 'API error: ${rawData['error']}');
        }

        AppLogger.w('Unexpected map format: keys=${rawData.keys}');
        throw ServerFailure(
          message: 'Unexpected response map format: keys=${rawData.keys}',
        );
      }

      if (rawData is String) {
        try {
          final decoded = jsonDecode(rawData);
          if (decoded is List) {
            AppLogger.i('Decoded string response as List');
            return decoded
                .map((e) => LocationModel.fromMap(Map<String, dynamic>.from(e)))
                .toList();
          } else if (decoded is Map && decoded.containsKey('results')) {
            final inner = decoded['results'] as List<dynamic>;
            AppLogger.i('Decoded string response with results key');
            return inner
                .map((e) => LocationModel.fromMap(Map<String, dynamic>.from(e)))
                .toList();
          } else {
            AppLogger.w('Decoded string is not in expected format');
            throw ServerFailure(
              message: 'Decoded string is not in expected format',
            );
          }
        } catch (e) {
          AppLogger.e('Failed to decode response string', e);
          throw ServerFailure(
            message:
                'Response is not JSON: ${rawData.substring(0, rawData.length > 200 ? 200 : rawData.length)}',
          );
        }
      }

      AppLogger.w('Unexpected response type: ${rawData.runtimeType}');
      throw ServerFailure(
        message: 'Unexpected response type: ${rawData.runtimeType}',
      );
    } on Failure {
      rethrow;
    } on DioException catch (e, st) {
      AppLogger.e('DioException occurred', e, st);
      throw ServerFailure(message: 'Network error: ${e.message}');
    } catch (e, st) {
      AppLogger.e('Unexpected exception occurred', e, st);
      throw ServerFailure(message: e.toString());
    }
  }
}
