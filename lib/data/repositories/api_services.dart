import 'dart:developer';
import 'package:bundlegram/core/config/interceptors/dio_interceptor.dart';
import 'package:bundlegram/core/config/interceptors/helper.dart';
import 'package:bundlegram/core/error/failures.dart';
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
import 'package:bundlegram/data/models/bvn/link_bvn/link_bvn_request.dart';
import 'package:bundlegram/data/models/bvn/link_bvn/link_bvn_response.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_data_response.dart';
import 'package:bundlegram/data/models/dashboard/dashboard_request.dart';
import 'package:bundlegram/data/models/notification/mark_notifications_asread_response.dart';
import 'package:bundlegram/data/models/notification/notification_response.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:bundlegram/data/models/profile/profile_response.dart';
import 'package:bundlegram/data/models/profile/profile_setup_request.dart';
import 'package:bundlegram/data/models/profile/profile_setup_response.dart';
import 'package:bundlegram/data/models/transaction/initiate_transactcion_requests.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/data/models/transaction/validate_bill_request.dart';
import 'package:bundlegram/data/models/transaction/validate_bill_response.dart';
import 'package:bundlegram/data/models/transaction/withdraw_request.dart';
import 'package:bundlegram/domain/api_definitions/api_definition.dart';
import 'package:bundlegram/env.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>(
  (ref) {
    var apiDefinition = ApiDefinition(ref.read(dioProvider));
    return ApiService(apiDefinition);
  },
);
String get _sterilizer => String.fromEnvironment(
      "STERILIZER_TOKEN",
      defaultValue: localSterilizer,
    );

class ApiService {
  final ApiDefinition _api;
  const ApiService(this._api);

  Future<Either<Failure, RegisterResponse>> register(RegisterRequest req) {
    return handleApi(() => _api.register(_sterilizer, req));
  }

  Future<Either<Failure, LoginResponse>> login(LoginRequest req) {
    return handleApi(() => _api.login(_sterilizer, req));
  }

  Future<Either<Failure, BaseResponse>> logout(String token) {
    return handleApi(() => _api.logout('Bearer $token', _sterilizer));
  }

  Future<Either<Failure, UsernameResponse>> checkUsername(String username) {
    return handleApi(() {
      final req = CheckUsernameRequest(username: username);
      return _api.checkUsername(_sterilizer, req);
    });
  }

  Future<Either<Failure, UsernameResponse>> addUsername(
      String token, String username) {
    return handleApi(() {
      final req = AddUsernameRequest(username: username);
      return _api.addUsername('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, ProfileSetupResponse>> updateProfileInformation(
    String token,
    ProfileSetupRequest req,
  ) {
    return handleApi(() {
      return _api.setupProfile('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, ProfileResponse>> getProfile(String token) {
    return handleApi(() => _api.getProfile('Bearer $token', _sterilizer));
  }

  Future<Either<Failure, GetWalletResponse>> getWallet(String token) {
    return handleApi(() => _api.getWallet('Bearer $token', _sterilizer));
  }

  Future<Either<Failure, GetAllBanksResponse>> getAllBanks(String token) {
    return handleApi(() => _api.getBanks('Bearer $token', _sterilizer));
  }

  Future<Either<Failure, ForgotPasswordResponse>> forgetPassword(String email) {
    return handleApi(() {
      final req = ForgotPasswordRequest(email: email);
      return _api.forgetPassword(_sterilizer, req);
    });
  }

  Future<Either<Failure, BaseResponse>> sendEmailOtp(
    String token,
  ) {
    return handleApi(() {
      return _api.resendEmailVerification('Bearer $token', _sterilizer);
    });
  }

  Future<Either<Failure, BaseResponse>> verifyOtp(
    String token,
    VerifyOtpRequest req,
  ) {
    return handleApi(() {
      return _api.verifyOtp('Bearer $token', req);
    });
  }

  Future<Either<Failure, BaseResponse>> verifyEmail(
      String token, VerifyEmailRequest req) {
    return handleApi(() {
      return _api.verifyEmail('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, NewPasswordResponse>> newPassword(
      String email, String password, String passwordConfirm) {
    return handleApi(() {
      final req = NewPasswordRequest(
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
      );
      return _api.newPassword(_sterilizer, req);
    });
  }

  Future<Either<Failure, ChangePasswordResponse>> changePassword(
      String token, String oldPassword, String newPassword) {
    return handleApi(() {
      final req = ChangePasswordRequest(
          oldPassword: oldPassword, newPassword: newPassword);
      return _api.changePassword('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, ChangePinResponse>> changePin(
      String token, String oldPin, String newPin) {
    return handleApi(() {
      final req = ChangePinRequest(oldPin: oldPin, newPin: newPin);
      return _api.changePin('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, ResetPinResponse>> resetPin(
      String token, String password) {
    return handleApi(() {
      final req = ResetPinRequest(password: password);
      return _api.resetPin('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, CreatePinResponse>> createPin(
      String token, String pin, String pinConfirmation) {
    return handleApi(() {
      final req = CreatePinRequest(pin: pin, pinConfirmation: pinConfirmation);
      return _api.createPin('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, DashboardDataResponse>> fetchDashboardData(
    String token,
    DashboardDataRequest req,
  ) {
    return handleApi(
        () => _api.getDashboardData('Bearer $token', _sterilizer, req));
  }

  Future<Either<Failure, GetAllUserBanksResponse>> getUserBanks(String token) {
    return handleApi(() => _api.getUserBanks('Bearer $token', _sterilizer));
  }

  Future<Either<Failure, AddBankResponse>> addBank(
      String token, AddBankRequest req) {
    return handleApi(() => _api.addBank('Bearer $token', _sterilizer, req));
  }

  Future<Either<Failure, FetchAccountNameResponse>> fetchAccountName(
      String token, FetchAccountNameRequest req) {
    return handleApi(
        () => _api.fetchAccountName('Bearer $token', _sterilizer, req));
  }

  Future<Either<Failure, BaseResponse>> closeAccount(
      String token, DeleteAccountRequest req) {
    return handleApi(
        () => _api.deleteAccount('Bearer $token', _sterilizer, req));
  }

  Future<Either<Failure, DeleteBankResponse>> deleteBank(
      String token, int bankId) {
    return handleApi(
        () => _api.deleteBank('Bearer $token', _sterilizer, bankId));
  }

  Future<Either<Failure, MakeBankDefaultResponse>> makeBankDefault(
      String token, int bankId) {
    return handleApi(
        () => _api.makeBankDefault('Bearer $token', _sterilizer, bankId));
  }

  Future<Either<Failure, LinkBvnResponse>> linkBvn(
      String token, LinkBvnRequest req) {
    return handleApi(() => _api.linkBvn('Bearer $token', _sterilizer, req));
  }

  Future<Either<Failure, GetVirtualAccountsResponse>> getVirtualAccount(
      String token) {
    return handleApi(
        () => _api.getVirtualAccount('Bearer $token', _sterilizer));
  }

  Future<Either<Failure, GetAllProductsResponse>> getProductByService(
      String token, String serviceId) {
    return handleApi(() =>
        _api.getProductByService('Bearer $token', _sterilizer, serviceId));
  }

  Future<Either<Failure, GetAllProductsResponse>> getProductByType(
      String token, String type) {
    return handleApi(
        () => _api.getProductByType('Bearer $token', _sterilizer, type));
  }

  Future<Either<Failure, GetAllSubProductsResponse>> getSubProduct(
      String token, int productId) {
    return handleApi(
        () => _api.getSubProduct('Bearer $token', _sterilizer, productId));
  }

  Future<Either<Failure, GetAllSubProductsResponse>> getSubProductByCategory(
      String token, int productId, String category) {
    return handleApi(() => _api.getSubProductByCategory(
        'Bearer $token', _sterilizer, productId, category));
  }

  Future<Either<Failure, GetAllUserTransactionResponse>> getTransactionsByType(
      String token, String type) {
    return handleApi(
        () => _api.getTransactionsByType('Bearer $token', _sterilizer, type));
  }

  Future<Either<Failure, GetAllUserTransactionResponse>> getAllTransactions(
      String token) {
    return handleApi(
        () => _api.getAllTransactions('Bearer $token', _sterilizer));
  }

  Future<Either<Failure, ValidateBillResponse>> validateBill(
      String token, ValidateBillRequest req) {
    return handleApi(
        () => _api.validateBill('Bearer $token', _sterilizer, req));
  }

  Future<Either<Failure, BaseResponse>> initiateBillTransaction(
      String token, InitiateTransactionRequest req) {
    return handleApi(
        () => _api.initiateBillTransaction('Bearer $token', _sterilizer, req));
  }

  Future<Either<Failure, BaseResponse>> initiateDataAirtimeTransaction(
      String token, InitiateTransactionRequest req) {
    return handleApi(() =>
        _api.initiateDataAirtimeTransaction('Bearer $token', _sterilizer, req));
  }

  Future<Either<Failure, BaseResponse>> becomeMerchant(
      String token, BecomeAMerchantRequest req) {
    return handleApi(
        () => _api.becomeMerchant('Bearer $token', _sterilizer, req));
  }

  Future<Either<Failure, void>> requestWithdraw(
      String token, WithdrawRequest req) {
    return handleApi(
        () => _api.userWithdraw('Bearer $token', _sterilizer, req));
  }

  Future<Either<Failure, AllNotificationResponse>> getAllNotifications(
      String token) {
    return handleApi(
        () => _api.getAllNotifications('Bearer $token', _sterilizer));
  }

  Future<Either<Failure, MarkNotificationAsReadResponse>>
      markAllNotificationsAsRead(String token) {
    return handleApi(
        () => _api.markAllNotificationsAsRead('Bearer $token', _sterilizer));
  }

  // other endpoint …
}
