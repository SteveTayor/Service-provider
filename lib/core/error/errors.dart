String sanitizeErrorMessage(dynamic rawMessage) {
  if (rawMessage == null) return 'Something went wrong. Please try again.';

  String message = rawMessage.toString();

  // Remove stack-like lines and file paths
  message = message.replaceAll(RegExp(r'[#\s]*\b(?:at|package:)[^\n]+'), ' ');

  // Replace Dart runtime type messages like "type 'String' is not a subtype of type 'int'"
  message = message.replaceAll(
      RegExp(r"type '([^']+)' is not a subtype of type '([^']+)'"),
      'A type mismatch occurred while processing the request.');

  // Remove 'Instance of 'ClassName''
  message = message.replaceAll(RegExp(r"Instance of '([^']+)'"), ' ');

  // Remove tracebacks or exceptions that look like HTML or stack
  if (message.toLowerCase().contains('traceback') ||
      message.toLowerCase().contains('exception:') && message.length > 200) {
    return 'Something went wrong. Please try again.';
  }

  // Strip HTML tags
  message = message.replaceAll(RegExp(r'<[^>]*>'), ' ');

  // Collapse whitespace
  message = message.replaceAll(RegExp(r'\s+'), ' ').trim();

  // Truncate lengthy messages
  if (message.length > 200) message = message.substring(0, 200) + '...';

  // Fallback
  if (message.isEmpty || RegExp(r'^[\W_]+$').hasMatch(message)) {
    return 'Something went wrong. Please try again.';
  }

  return message;
}
