/// Route path constants for the application
class RouteConstants {
  /// Private constructor to prevent direct instantiation
  RouteConstants._();

  /// Splash screen route
  static const String splash = '/';

  static const String walkThrough = '/walkThrough';

  /// Authentication routes
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forgetPassword';
  static const String termsCondition = '/termsCondition';
  static const String privacyPolicy = '/privacyPolicy';
  static const String chooseUsername = '/chooseUsername';
  static const String onboardResult = '/onboardResult';


  /// Main app routes
  static const String home = '/home';
  static const String profile = 'profile';
  static const String settings = 'settings';

  /// Marketplace routes
  static const String marketplace = '/marketplace';
  static const String productDetails = ':id';

  /// Wallet routes
  static const String wallet = '/wallet';
  static const String transactions = 'transactions';

  /// Agent routes
  static const String agent = '/agent';
  static const String commission = 'commission';
} 