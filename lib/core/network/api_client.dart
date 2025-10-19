import 'package:dio/dio.dart';
import '../errors/failures.dart';

/// API Client usin g Dio for network requests.
class ApiClient {
  final Dio dio;

  ApiClient({required this.dio}) {
    _configureDio();
  }

  /// Configure Dio with default settings
  void _configureDio() {
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (status) {
        // Accept all status codes to handle them manually
        return status != null && status < 500;
      },
    );

    // Add interceptors for logging (optional)
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
      ),
    );
  }

  /// Performs a GET request with query parameters
  Future<Map<String, dynamic>> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);

      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw NetworkFailure(message: 'Unexpected error: ${e.toString()}');
    }
  }

  /// Handles successful and error responses
  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      throw ServerFailure(message: 'Invalid response format');
    } else if (response.statusCode == 400) {
      throw BadRequestFailure(
        message: _extractErrorMessage(response) ?? 'Invalid request parameters',
      );
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      throw AuthenticationFailure(
        message:
            _extractErrorMessage(response) ??
            'Invalid API key or unauthorized access',
      );
    } else if (response.statusCode == 404) {
      throw NotFoundFailure(
        message: _extractErrorMessage(response) ?? 'Location not found',
      );
    } else if (response.statusCode! >= 500) {
      throw ServerFailure(message: 'Server error: ${response.statusCode}');
    } else {
      throw ServerFailure(message: 'Unexpected error: ${response.statusCode}');
    }
  }

  /// Handles Dio-specific errors
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(
          message: 'Connection timeout. Please check your internet connection.',
        );
      case DioExceptionType.connectionError:
        return NetworkFailure(
          message: 'No internet connection. Please check your network.',
        );
      case DioExceptionType.badResponse:
        if (error.response != null) {
          return _mapStatusCodeToFailure(error.response!);
        }
        return ServerFailure(message: 'Bad response from server');
      case DioExceptionType.cancel:
        return NetworkFailure(message: 'Request cancelled');
      case DioExceptionType.unknown:
        return NetworkFailure(
          message: 'Network error: ${error.message ?? "Unknown error"}',
        );
      default:
        return NetworkFailure(message: 'Network error occurred');
    }
  }

  /// Maps HTTP status codes to specific failures
  Failure _mapStatusCodeToFailure(Response response) {
    switch (response.statusCode) {
      case 400:
        return BadRequestFailure(
          message: _extractErrorMessage(response) ?? 'Invalid request',
        );
      case 401:
      case 403:
        return AuthenticationFailure(
          message: _extractErrorMessage(response) ?? 'Authentication failed',
        );
      case 404:
        return NotFoundFailure(
          message: _extractErrorMessage(response) ?? 'Resource not found',
        );
      case 500:
      case 502:
      case 503:
        return ServerFailure(
          message: _extractErrorMessage(response) ?? 'Server error occurred',
        );
      default:
        return ServerFailure(
          message: 'Unexpected error: ${response.statusCode}',
        );
    }
  }

  /// Extracts error message from response
  String? _extractErrorMessage(Response response) {
    try {
      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        return data['error']?['message'] ?? data['message'] ?? data['error'];
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
