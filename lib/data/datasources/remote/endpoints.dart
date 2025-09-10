class Endpoints {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://apiv2.bundlegram.com/api',
  );

  // ====================
  // Authentication
  // ====================
  static const String register = '/register';
  static const String login = '/login';
  static const String logout = '/logout';
  static const String addUsername = '/add_username';
  static const String checkUsername = '/check-username';

  // ====================
  // Forget Password
  // ====================
  static const String forgetPassword = '/forget-password';
  static const String verifyOtp = '/verify-otp';
  static const String newPassword = '/new-password';

  // ====================
  // Email Verification
  // ====================
  static const String verifyEmail = '/verify-email';
  static const String resendEmail = '/email-verification';

  // ====================
  // User & Profile
  // ====================
  static const String userProfile = '/user';
  static const String profileSetup = '/profile-setup';
  static const String changePassword = '/change-password';
  static const String changePin = '/change-pin';
  static const String createPin = '/create-pin';
  static const String resetPin = '/reset-pin';
  static const String linkBvn = '/link-bvn';
  static const String getVirtualAccount = '/get-virtual-account';
  static const String deleteAccount = '/delete-account';

  // Bank management
  static const String getAllBanks = '/get-banks';
  static const String getUserBank = '/get-user-bank';
  static const String addBank = '/add-bank';
  static const String fetchAccountName = '/fetch-account-name';
  static const String userWithdraw = '/user-withdraw';

  /// Deletes a user bank by its [bankId].
  static String deleteBank(int bankId) => '/delete-bank/$bankId';

  /// Marks a user bank as default by its [bankId].
  static String makeBankDefault(int bankId) => '/make-bank-default/$bankId';

  // ====================
  // Wallet & Dashboard
  // ====================
  static const String wallet = '/wallet';
  static const String dashboardData = '/dashboard-data';

  // ====================
  // Products (Airtime, Data, Sub‑Products)
  // ====================
  /// Fetches all products for a given [serviceId].
  static String getProductByService(String serviceId) =>
      '/getProductByService/$serviceId';

  /// Fetches all products of a given [type], e.g. 'data', 'airtime'.
  static String getProductByType(String type) => '/getProductByType/$type';

  /// Fetches the sub‑products under [productId].
  static String getSubProduct(int productId) => '/getSubProduct/$productId';

  /// Fetches a more specific sub‑product, e.g. SME plans under [productId].
  static String getSubProductCategory(int productId, String category) =>
      '/getSubProduct/$productId/$category';

  // ====================
  // Transactions & Payments
  // ====================
  /// Validates a bill before payment.
  static const String validateBill = '/validateBill';

  /// Initiates a bill payment transaction.
  static const String initiateBillTransaction = '/initiateBillTransaction';

  /// Initiates an airtime/data transaction.
  static const String initiateDataAirtimeTransaction =
      '/initiateDataAirtimeTransaction';

  /// Lists transactions, [type], e.g. 'data', 'airtime'.......
  static String userTransactionsByServiceType(String type) =>
      '/userTransactions/$type';

  /// Lists all users transactions
  static const String allUserTransactions = '/userTransactions';

  ///Initiates a single transaction details
  static const String webhook =
      'https://api.bundlegram.com/squad/payment/notification/webhook';

  // ====================
  // Merchant / Agent
  // ====================
  static const String becomeAMerchant = '/become-a-merchant';
  static const String initiateEpinPurchase = "/epin/purchase";

  // ====================
  // Misc
  // ====================
  static const String walletBalance = '/wallet';
}
