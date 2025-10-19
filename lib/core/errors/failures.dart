// lib/core/errors/failures.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

/// Network-related failures (connectivity, timeout, etc.)
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

/// Server-side failures (5xx errors)
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

/// Bad request failures (400 errors)
class BadRequestFailure extends Failure {
  const BadRequestFailure({required super.message});
}

/// Authentication failures (401, 403)
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({required super.message});
}

/// Not found failures (404)
class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message});
}

/// Location service failures
class LocationServiceFailure extends Failure {
  const LocationServiceFailure({required super.message});
}

/// Location permission failures
class LocationPermissionFailure extends Failure {
  const LocationPermissionFailure({required super.message});
}

/// Cache failures (if using local caching)
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}
