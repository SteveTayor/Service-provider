/// Global constants for the application
class AppConstants {
  /// Private constructor to prevent direct instantiation
  AppConstants._();

  /// App name
  static const String appName = 'Bundlegram';

  /// App version
  static const String appVersion = '1.1.0';

  /// App build number
  static const String appBuildNumber = '1';

  /// Default animation duration
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  /// Default page size for paginated requests
  static const int defaultPageSize = 20;

  /// Maximum file upload size in bytes (10MB)
  static const int maxFileUploadSize = 10 * 1024 * 1024;

  /// Supported image file extensions
  static const List<String> supportedImageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
  ];

  /// Supported video file extensions
  static const List<String> supportedVideoExtensions = [
    'mp4',
    'mov',
    'avi',
    'mkv',
  ];

  /// Supported document file extensions
  static const List<String> supportedDocumentExtensions = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'ppt',
    'pptx',
  ];

  /// Regular expressions
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp phoneRegex = RegExp(
    r'^\+?[1-9]\d{1,14}$',
  );
  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  /// Shared preferences keys
  static const String tokenKey = 'token';
  static const String userIdKey = 'userId';
  static const String themeKey = 'theme';
  static const String localeKey = 'locale';
  static const String onboardingKey = 'onboarding';
  static String get authTokenKey => 'auth_token';
  static String get usernameKey => 'username';
  static String get phoneKey => 'phone';

  /// Error messages
  static const String networkErrorMessage = 'Network error. Please try again.';
  static const String serverErrorMessage =
      'Server error. Please try again later.';
  static const String unknownErrorMessage = 'An unknown error occurred.';
  static const String invalidEmailMessage =
      'Please enter a valid email address.';
  static const String invalidPhoneMessage =
      'Please enter a valid phone number.';
  static const String invalidPasswordMessage =
      'Password must be at least 8 characters long and contain at least one letter and one number.';
  static const String fieldRequiredMessage = 'This field is required.';

  /// Success messages
  static const String loginSuccessMessage = 'Login successful.';
  static const String registerSuccessMessage = 'Registration successful.';
  static const String logoutSuccessMessage = 'Logout successful.';
  static const String updateSuccessMessage = 'Update successful.';
  static const String deleteSuccessMessage = 'Delete successful.';
}
