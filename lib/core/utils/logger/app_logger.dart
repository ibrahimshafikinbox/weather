import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 5,
      lineLength: 90,
      colors: true,
      printEmojis: true,
      // ignore: deprecated_member_use
      printTime: true,
    ),
    // ignore: deprecated_member_use
    level: kDebugMode ? Level.debug : Level.nothing,
  );

  static void i(String message) {
    if (kDebugMode) _logger.i(message);
  }

  static void d(String message) {
    if (kDebugMode) _logger.d(message);
  }

  static void w(String message) {
    if (kDebugMode) _logger.w(message);
  }

  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) _logger.e(message, error: error, stackTrace: stackTrace);
    log(message, error: error, stackTrace: stackTrace);
  }
}
