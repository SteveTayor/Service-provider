class Endpoints {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000/api',
  );

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String resetPassword = '/auth/reset-password';
  static const String me = '/auth/me';

  // User endpoints
  static const String users = '/users';
  static const String updateProfile = '/users/profile';
  static const String updatePassword = '/users/password';

  // Other endpoints can be added here as needed
} 