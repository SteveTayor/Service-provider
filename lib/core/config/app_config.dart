import 'package:flutter/foundation.dart';

/// Configuration class for the application
class AppConfig {
  /// Private constructor to prevent direct instantiation
  AppConfig._();

  /// Singleton instance
  static final AppConfig instance = AppConfig._();

  /// Whether the app is running in debug mode
  static bool get isDebug => kDebugMode;

  /// Whether the app is running in release mode
  static bool get isRelease => kReleaseMode;

  /// Whether the app is running in profile mode
  static bool get isProfile => kProfileMode;

  /// Base URL for the API
  String get baseUrl {
    if (isDebug) {
      return 'http://localhost:3000';
    } else if (isProfile) {
      return 'https://staging-api.bundlegram.com';
    } else {
      return 'https://api.bundlegram.com';
    }
  }

  /// API version
  String get apiVersion => 'v1';

  /// Full API URL including version
  String get apiUrl => '$baseUrl/api/$apiVersion';

  /// Timeout duration for API requests
  Duration get timeout => const Duration(seconds: 30);

  /// Maximum retries for failed API requests
  int get maxRetries => 3;

  /// Cache duration for API responses
  Duration get cacheDuration => const Duration(hours: 1);
} 