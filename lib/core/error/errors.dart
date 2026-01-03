String sanitizeErrorMessage(dynamic rawMessage) {
  const fallback = 'Something went wrong. Please try again.';

  if (rawMessage == null) return fallback;

  String message = rawMessage.toString().trim();
  if (message.isEmpty) return fallback;

// Normalize comparison
  final fallbackLower = fallback.toLowerCase();

// If fallback already exists anywhere → return ONLY fallback
  if (message.toLowerCase().contains(fallbackLower)) {
    return fallback;
  }

  final lower = message.toLowerCase();
  // Reject messages that start with numbers or look like dumps
  final lines = message.split(RegExp(r'[\r\n]+'));
  if (lines.isNotEmpty) {
    final firstLine = lines.first.trim();
    if (firstLine.isNotEmpty && RegExp(r'^\d+$').hasMatch(firstLine)) {
      return fallback;
    }
  }

  const blockedPatterns = [
    'too many requests',
    'too much request',
    'too many request',
    'too many requests.',
    'too many requests error',
    'rate limit',
    'rate-limited',
    'rate limit exceeded',
    'throttle',
    'throttled',
    '429',
    'quota exceeded',
    'request throttled',
    'too many attempts',
    'null check',
    'null',
    'null check used on a null value',
  ];
  for (final p in blockedPatterns) {
    if (lower.contains(p)) {
      // Silently map to generic fallback (so UI never sees the raw phrase)
      return fallback;
    }
  }
  // Hard reject obvious stack traces / backend dumps
  if ((lower.contains('traceback') ||
          lower.contains('exception') ||
          lower.contains('stack')) &&
      message.length > 120) {
    return fallback;
  }

  // Remove stack lines & file paths
  message = message.replaceAll(
    RegExp(r'[#\s]*\b(?:at|package:)[^\n]+'),
    ' ',
  );

  // Replace Dart runtime type errors
  message = message.replaceAll(
    RegExp(r"type '([^']+)' is not a subtype of type '([^']+)'"),
    'A technical error occurred while processing your request.',
  );

  // Remove "Instance of 'Class'"
  message = message.replaceAll(
    RegExp(r"Instance of '([^']+)'"),
    ' ',
  );

  // Strip HTML
  message = message.replaceAll(RegExp(r'<[^>]*>'), ' ');

  // Normalize whitespace
  message = message.replaceAll(RegExp(r'\s+'), ' ').trim();

  // Reject useless short messages
  const useless = [
    'error',
    'bad state',
    'invalid argument',
    'exception',
    'unknown error',
  ];
  if (useless.any((u) => message.toLowerCase() == u)) {
    return fallback;
  }

  // Enforce length cap
  if (message.length > 160) {
    message = '${message.substring(0, 160)}...';
  }

  // Final sanity check
  if (message.isEmpty || RegExp(r'^[\W_]+$').hasMatch(message)) {
    return fallback;
  }

  return message;
}
