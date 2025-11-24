class ErrorMessageSanitizer {
  static const int _maxMessageLength = 100;
  static const List<String> _commonNetworkErrors = [
    'SocketException',
    'TimeoutException',
    'Connection failed',
    'Network error',
    'No internet',
  ];

  /// Sanitizes error message to be user-friendly
  static String sanitize(dynamic error) {
    if (error == null) return 'Something went wrong';

    String message = error.toString();

    // Handle custom NetworkFailure(...) or similar errors
    final networkFailureMatch =
        RegExp(r'NetworkFailure\((.*?)\)').firstMatch(message);
    if (networkFailureMatch != null) {
      return 'Network failure, please try again later';
    }

    // Remove any text inside parentheses for general errors
    final bracketMatch = RegExp(r'^[\w]+?\((.*?)\)$').firstMatch(message);
    if (bracketMatch != null) {
      message = message.split('(').first.trim();
    }

    // Handle common network errors
    if (_isNetworkError(message)) {
      return 'No internet connection. Please check your network.';
    }

    // Handle HTTP errors
    if (message.contains('HttpException') ||
        message.contains('400') ||
        message.contains('500')) {
      return 'Server error. Please try again later.';
    }

    // Handle timeout errors
    if (message.contains('timeout') || message.contains('Timeout')) {
      return 'Request timed out. Please try again.';
    }

    // Handle format exceptions
    if (message.contains('FormatException')) {
      return 'Invalid data format received.';
    }

    // Clean up common Flutter/Dart error prefixes
    message = message
        .replaceAll('Exception: ', '')
        .replaceAll('Error: ', '')
        .replaceAll('HttpException: ', '')
        .replaceAll('SocketException: ', '')
        .trim();

    // Truncate if too long
    if (message.length > _maxMessageLength) {
      message = '${message.substring(0, _maxMessageLength)}...';
    }

    // Return generic message if still too technical
    if (_isTechnicalError(message)) {
      return 'Something went wrong. Please try again.';
    }

    return message.isEmpty ? 'Something went wrong' : message;
  }

  static bool _isNetworkError(String message) {
    return _commonNetworkErrors
        .any((error) => message.toLowerCase().contains(error.toLowerCase()));
  }

  static bool _isTechnicalError(String message) {
    final technicalTerms = [
      'null',
      'undefined',
      'RangeError',
      'TypeError',
      'stack trace'
    ];
    return technicalTerms
        .any((term) => message.toLowerCase().contains(term.toLowerCase()));
  }
}
