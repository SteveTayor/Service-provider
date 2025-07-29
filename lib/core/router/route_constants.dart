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
  static const String transactionSuccess = '/transaction-success';
  // static const String resetPassword = '/resetPassword';

  /// Main app routes
  static const String dashboard = '/dashboard';
  static const String home = '/home';
  static const String profile = 'profile';
  static const String settings = 'settings';

  /// Marketplace routes
  static const String marketplace = '/marketplace';
  static const String productDetails = ':id';

  /// Wallet routes
  static const String wallet = '/wallet';
  static const String topUpResult = '/topUpResult';
  static const String withdrawFund = '/withdrawFund';
  static const String enterPin = '/enterPin';
////
  static const String platformProduct = '/platformProduct';

  //// User Account
  static const String setting = '/settings';
  static const String changePassword = '/changePassword';
  static const String changeAccountPin = '/changeAccountPin';
  static const String resetAccountPin = '/resetAccountPin';
  static const String notificationsetting = '/notificationsetting';
  static const String privacySecurity = '/privacySecurity';
  static const String accountSetup = '/accountSetup';
  static const String addbasicinformation = '/addBasicInformation';
  static const String updatebasicinformation = '/updateBasicInformation';
  static const String linkyourbvn = '/linkyourbvn';
  static const String addbankdetail = '/addbankdetail';
  static const String withdrawalAccount = '/withdrawalaccount';
  static const String helpSupport = '/helpSupport';
  static const String becomeagent = '/becomeagent';

  /// Agent routes
  static const String agent = '/agent';
  static const String commission = 'commission';
  static const String walletHistoryScreen = '/walletHistoryScreen';

  static const String notification = '/notification';
  static const String pinScreen = '/pinScreen';
}
