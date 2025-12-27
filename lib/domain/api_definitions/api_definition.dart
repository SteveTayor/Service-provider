import 'package:bundlegram/data/datasources/remote/endpoints.dart';
import 'package:bundlegram/data/models/auth/auth_model.dart';
import 'package:bundlegram/data/models/auth/forgot_password/change_password_respone.dart';
import 'package:bundlegram/data/models/auth/forgot_password/change_pin_response.dart';
import 'package:bundlegram/data/models/auth/forgot_password/create_pin_response.dart';
import 'package:bundlegram/data/models/auth/forgot_password/forgot_password_response.dart';
import 'package:bundlegram/data/models/auth/forgot_password/new_password_response.dart';
import 'package:bundlegram/data/models/auth/forgot_password/reset_pin_response.dart';
import 'package:bundlegram/data/models/auth/login/login_response.dart';
import 'package:bundlegram/data/models/auth/registeration/registeration_response.dart';
import 'package:bundlegram/data/models/auth/registeration/username/username_response.dart';
import 'package:bundlegram/data/models/auth/wallet/get_wallet_response.dart';
import 'package:bundlegram/data/models/banks/add_bank_request.dart';
import 'package:bundlegram/data/models/banks/add_bank_response.dart';
import 'package:bundlegram/data/models/banks/delete_bank_response.dart';
import 'package:bundlegram/data/models/banks/fetch_account_name_request.dart';
import 'package:bundlegram/data/models/banks/fetch_account_name_response.dart';
import 'package:bundlegram/data/models/banks/get_all_banks_response.dart';
import 'package:bundlegram/data/models/banks/get_all_users_banks_response.dart';
import 'package:bundlegram/data/models/banks/get_virtual_account_response.dart';
import 'package:bundlegram/data/models/banks/make_bank_default_response.dart';
import 'package:bundlegram/data/models/base/base_response.dart';
import 'package:bundlegram/data/models/become_a_merchant/become_a_merchant_request.dart';
import 'package:bundlegram/data/models/beneficiaries/get_all_beneficiaries.dart';
import 'package:bundlegram/data/models/bvn/link_bvn/link_bvn_request.dart';
import 'package:bundlegram/data/models/bvn/link_bvn/link_bvn_response.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_data_response.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_request.dart';
import 'package:bundlegram/data/models/notification/mark_notifications_asread_response.dart';
import 'package:bundlegram/data/models/notification/notification_response.dart';
import 'package:bundlegram/data/models/products/epin/epin_request_response.dart';
import 'package:bundlegram/data/models/products/epin/epin_response.dart';
import 'package:bundlegram/data/models/products/epin/epin_trannsactions.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:bundlegram/data/models/profile/profile_response.dart';
import 'package:bundlegram/data/models/profile/profile_setup_request.dart';
import 'package:bundlegram/data/models/profile/profile_setup_response.dart';
import 'package:bundlegram/data/models/promo/get_allpromo_response.dart';
import 'package:bundlegram/data/models/promo/redeem_promo_request.dart';
import 'package:bundlegram/data/models/transaction/initiate_transactcion_requests.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/data/models/transaction/validate_bill_request.dart';
import 'package:bundlegram/data/models/transaction/validate_bill_response.dart';
import 'package:bundlegram/data/models/transaction/withdraw_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_definition.g.dart';

@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiDefinition {
  factory ApiDefinition(Dio dio, {String baseUrl}) = _ApiDefinition;
  static const _authHeader = "Authorization";

  // Authentication
  @POST(Endpoints.register)
  Future<RegisterResponse> register(
    @Header('AccessToken') String accessToken,
    @Body() RegisterRequest body,
  );

  @POST(Endpoints.login)
  Future<LoginResponse> login(
    @Header('AccessToken') String accessToken,
    @Body() LoginRequest body,
  );

  @POST(Endpoints.logout)
  Future<BaseResponse> logout(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  // Username endpoints
  @POST(Endpoints.checkUsername)
  Future<UsernameResponse> checkUsername(
    @Header('AccessToken') String accessToken,
    @Body() CheckUsernameRequest body,
  );

  @POST(Endpoints.addUsername)
  Future<UsernameResponse> addUsername(
    @Header(_authHeader) String bearer,
    @Header('AccessToken') String accessToken,
    @Body() AddUsernameRequest body,
  );

  // Profile & Wallet (loaded before dashboard)
  @GET(Endpoints.userProfile)
  Future<ProfileResponse> getProfile(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  @GET(Endpoints.wallet)
  Future<GetWalletResponse> getWallet(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  //Banks
  @GET(Endpoints.getAllBanks)
  Future<GetAllBanksResponse> getBanks(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  @POST(Endpoints.forgetPassword)
  Future<ForgotPasswordResponse> forgetPassword(
    @Header('AccessToken') String accessToken,
    @Body() ForgotPasswordRequest body,
  );

  @POST(Endpoints.newPassword)
  Future<NewPasswordResponse> newPassword(
    @Header('AccessToken') String accessToken,
    @Body() NewPasswordRequest body,
  );

  @POST(Endpoints.changePassword)
  Future<ChangePasswordResponse> changePassword(
    @Header(_authHeader) String bearer,
    @Header('AccessToken') String accessToken,
    @Body() ChangePasswordRequest body,
  );

  @POST(Endpoints.changePin)
  Future<ChangePinResponse> changePin(
    @Header(_authHeader) String bearer,
    @Header('AccessToken') String accessToken,
    @Body() ChangePinRequest body,
  );

  @POST(Endpoints.resetPin)
  Future<ResetPinResponse> resetPin(
    @Header(_authHeader) String bearer,
    @Header('AccessToken') String accessToken,
    @Body() ResetPinRequest body,
  );

  @POST(Endpoints.createPin)
  Future<CreatePinResponse> createPin(
    @Header(_authHeader) String bearer,
    @Header('AccessToken') String accessToken,
    @Body() CreatePinRequest body,
  );

  @POST(Endpoints.verifyPin)
  Future<BaseResponse> verifyPin(
    @Header(_authHeader) String bearer,
    @Header('AccessToken') String accessToken,
    @Body() VerifyPinRequest body,
  );

  @POST(Endpoints.dashboardData)
  Future<DashboardDataResponse> getDashboardData(
    @Header(_authHeader) String bearer,
    @Header('AccessToken') String accessToken,
    @Body() DashboardDataRequest body,
  );

  ///Email verification & otp
  @POST(Endpoints.verifyOtp)
  Future<BaseResponse> verifyOtp(
    @Header('AccessToken') String accessToken,
    @Body() VerifyOtpRequest body,
  );

  @POST(Endpoints.verifyEmail)
  Future<BaseResponse> verifyEmail(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() VerifyEmailRequest body,
  );

  @POST(Endpoints.resendEmail)
  Future<BaseResponse> resendEmailVerification(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  ///Profile & Account management
  @POST(Endpoints.profileSetup)
  Future<ProfileSetupResponse> setupProfile(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() ProfileSetupRequest body,
  );

  @POST(Endpoints.linkBvn)
  Future<LinkBvnResponse> linkBvn(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() LinkBvnRequest body,
  );

  @GET(Endpoints.getVirtualAccount)
  Future<GetVirtualAccountsResponse> getVirtualAccount(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  @POST(Endpoints.deleteAccount)
  Future<BaseResponse> deleteAccount(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() DeleteAccountRequest body,
  );

  /// Bank Management
  @GET(Endpoints.getUserBank)
  Future<GetAllUserBanksResponse> getUserBanks(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  @POST(Endpoints.addBank)
  Future<AddBankResponse> addBank(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() AddBankRequest body,
  );

  @POST(Endpoints.fetchAccountName)
  Future<FetchAccountNameResponse> fetchAccountName(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() FetchAccountNameRequest body,
  );

  @POST(Endpoints.userWithdraw)
  Future<void> userWithdraw(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() WithdrawRequest body,
  );

  @DELETE('/delete-bank/{bankId}')
  Future<DeleteBankResponse> deleteBank(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Path("bankId") int bankId,
  );

  @PUT('/make-bank-default/{bankId}')
  Future<MakeBankDefaultResponse> makeBankDefault(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Path("bankId") int bankId,
  );

  ///Product services
  @GET('/getProductByService/{serviceId}')
  Future<GetAllProductsResponse> getProductByService(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Path("serviceId") String serviceId,
  );

  @GET('/getProductByType/{type}')
  Future<GetAllProductsResponse> getProductByType(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Path("type") String type,
  );

  @GET('/getSubProduct/{productId}')
  Future<GetAllSubProductsResponse> getSubProduct(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Path("productId") int productId,
  );

  @GET('/getSubProduct/{productId}/{category}')
  Future<GetAllSubProductsResponse> getSubProductByCategory(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Path("productId") int productId,
    @Path("category") String category,
  );

  @POST(Endpoints.validateBill)
  Future<ValidateBillResponse> validateBill(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() ValidateBillRequest body,
  );

  @POST(Endpoints.initiateBillTransaction)
  Future<BaseResponse> initiateBillTransaction(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() InitiateTransactionRequest body,
  );

  @POST(Endpoints.initiateDataAirtimeTransaction)
  Future<BaseResponse> initiateDataAirtimeTransaction(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() InitiateTransactionRequest body,
  );

  @GET('/userTransactions/{type}')
  Future<GetAllUserTransactionResponse> getTransactionsByType(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Path("type") String type,
  );

  @GET(Endpoints.allUserTransactions)
  Future<GetAllUserTransactionResponse> getAllTransactions(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  @POST(Endpoints.becomeAMerchant)
  Future<BaseResponse> becomeMerchant(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() BecomeAMerchantRequest body,
  );

  @GET(Endpoints.allNotifications)
  Future<AllNotificationResponse> getAllNotifications(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  @POST(Endpoints.markNotificationAsRead)
  Future<MarkNotificationAsReadResponse> markAllNotificationsAsRead(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  @GET(Endpoints.allPromos)
  Future<GetAllPromoResponse> getAllPromos(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  @POST(Endpoints.redeemPromo)
  Future<BaseResponse> redeemAPromo(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() RedeemAPromoRequest body,
  );

  @GET(Endpoints.getAllBeneficiaries)
  Future<GetAllBeneficiariesResponse> getAllBeneficiaries(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  @GET(Endpoints.getMinimalBeneficiaries)
  Future<GetAllBeneficiariesResponse> getMinimalBeneficiaries(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );

  @POST(Endpoints.initiateEpinPurchase)
  Future<EpinResponse> initiateEpinPurchase(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
    @Body() EpinRequest body,
  );

  @GET(Endpoints.epinTransactionRequests)
  Future<EpinTransactionRequestsResponse> getEpinTransactionRequests(
    @Header('AccessToken') String accessToken,
    @Header(_authHeader) String bearer,
  );
}
