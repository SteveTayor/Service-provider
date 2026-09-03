import 'dart:developer';
import 'package:bundlegram/core/config/interceptors/dio_interceptor.dart';
import 'package:bundlegram/core/config/interceptors/helper.dart';
import 'package:bundlegram/core/error/failures.dart';
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
import 'package:bundlegram/data/models/products/epin/epin_trannsactions.dart'
    as epin_models;
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
import 'package:bundlegram/domain/api_definitions/api_definition.dart';
import 'package:bundlegram/env.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  var apiDefinition = ApiDefinition(ref.read(dioProvider));
  return ApiService(apiDefinition);
});
String get _sterilizer =>
    String.fromEnvironment("STERILIZER_TOKEN", defaultValue: localSterilizer);

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
    String token,
    String username,
  ) {
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

  Future<Either<Failure, BaseResponse>> sendEmailOtp(String token) {
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
    String token,
    VerifyEmailRequest req,
  ) {
    return handleApi(() {
      return _api.verifyEmail('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, NewPasswordResponse>> newPassword(
    String email,
    String password,
    String passwordConfirm,
  ) {
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
    String token,
    String oldPassword,
    String newPassword,
  ) {
    return handleApi(() {
      final req = ChangePasswordRequest(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return _api.changePassword('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, ChangePinResponse>> changePin(
    String token,
    String oldPin,
    String newPin,
  ) {
    return handleApi(() {
      final req = ChangePinRequest(oldPin: oldPin, newPin: newPin);
      return _api.changePin('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, ResetPinResponse>> resetPin(
    String token,
    String password,
  ) {
    return handleApi(() {
      final req = ResetPinRequest(password: password);
      return _api.resetPin('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, CreatePinResponse>> createPin(
    String token,
    String pin,
    String pinConfirmation,
  ) {
    return handleApi(() {
      final req = CreatePinRequest(pin: pin, pinConfirmation: pinConfirmation);
      return _api.createPin('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, BaseResponse>> verifyPin(String token, String pin) {
    return handleApi(() {
      final req = VerifyPinRequest(pin: pin);
      return _api.verifyPin('Bearer $token', _sterilizer, req);
    });
  }

  Future<Either<Failure, DashboardDataResponse>> fetchDashboardData(
    String token,
    DashboardDataRequest req,
  ) {
    return handleApi(
      () => _api.getDashboardData('Bearer $token', _sterilizer, req),
    );
  }

  Future<Either<Failure, GetAllUserBanksResponse>> getUserBanks(String token) {
    return handleApi(() => _api.getUserBanks('Bearer $token', _sterilizer));
  }

  Future<Either<Failure, AddBankResponse>> addBank(
    String token,
    AddBankRequest req,
  ) {
    return handleApi(() => _api.addBank('Bearer $token', _sterilizer, req));
  }

  Future<Either<Failure, FetchAccountNameResponse>> fetchAccountName(
    String token,
    FetchAccountNameRequest req,
  ) {
    return handleApi(
      () => _api.fetchAccountName('Bearer $token', _sterilizer, req),
    );
  }

  Future<Either<Failure, BaseResponse>> closeAccount(
    String token,
    DeleteAccountRequest req,
  ) {
    return handleApi(
      () => _api.deleteAccount('Bearer $token', _sterilizer, req),
    );
  }

  Future<Either<Failure, DeleteBankResponse>> deleteBank(
    String token,
    int bankId,
  ) {
    return handleApi(
      () => _api.deleteBank('Bearer $token', _sterilizer, bankId),
    );
  }

  Future<Either<Failure, MakeBankDefaultResponse>> makeBankDefault(
    String token,
    int bankId,
  ) {
    return handleApi(
      () => _api.makeBankDefault('Bearer $token', _sterilizer, bankId),
    );
  }

  Future<Either<Failure, LinkBvnResponse>> linkBvn(
    String token,
    LinkBvnRequest req,
  ) {
    return handleApi(() => _api.linkBvn('Bearer $token', _sterilizer, req));
  }

  Future<Either<Failure, GetVirtualAccountsResponse>> getVirtualAccount(
    String token,
  ) {
    return handleApi(
      () => _api.getVirtualAccount('Bearer $token', _sterilizer),
    );
  }

  Future<Either<Failure, GetAllProductsResponse>> getProductByService(
    String token,
    String serviceId,
  ) {
    return handleApi(
      () => _api.getProductByService('Bearer $token', _sterilizer, serviceId),
    );
  }

  Future<Either<Failure, GetAllProductsResponse>> getProductByType(
    String token,
    String type,
  ) {
    return handleApi(
      () => _api.getProductByType('Bearer $token', _sterilizer, type),
    );
  }

  Future<Either<Failure, GetAllSubProductsResponse>> getSubProduct(
    String token,
    int productId,
  ) {
    return handleApi(
      () => _api.getSubProduct('Bearer $token', _sterilizer, productId),
    );
  }

  Future<Either<Failure, GetAllSubProductsResponse>> getSubProductByCategory(
    String token,
    int productId,
    String category,
  ) {
    return handleApi(
      () => _api.getSubProductByCategory(
        'Bearer $token',
        _sterilizer,
        productId,
        category,
      ),
    );
  }

  Future<Either<Failure, GetAllUserTransactionResponse>> getTransactionsByType(
    String token,
    String type,
  ) {
    return handleApi(
      () => _api.getTransactionsByType('Bearer $token', _sterilizer, type),
    );
  }

  Future<Either<Failure, GetAllUserTransactionResponse>> getAllTransactions(
    String token,
  ) {
    return handleApi(
      () => _api.getAllTransactions('Bearer $token', _sterilizer),
    );
  }

  Future<Either<Failure, ValidateBillResponse>> validateBill(
    String token,
    ValidateBillRequest req,
  ) {
    return handleApi(
      () => _api.validateBill('Bearer $token', _sterilizer, req),
    );
  }

  Future<Either<Failure, BaseResponse>> initiateBillTransaction(
    String token,
    InitiateTransactionRequest req,
  ) {
    return handleApi(
      () => _api.initiateBillTransaction('Bearer $token', _sterilizer, req),
    );
  }

  Future<Either<Failure, BaseResponse>> initiateDataAirtimeTransaction(
    String token,
    InitiateTransactionRequest req,
  ) {
    return handleApi(
      () => _api.initiateDataAirtimeTransaction(
        'Bearer $token',
        _sterilizer,
        req,
      ),
    );
  }

  Future<Either<Failure, BaseResponse>> becomeMerchant(
    String token,
    BecomeAMerchantRequest req,
  ) {
    return handleApi(
      () => _api.becomeMerchant('Bearer $token', _sterilizer, req),
    );
  }

  Future<Either<Failure, BaseResponse>> requestWithdraw(
    String token,
    WithdrawRequest req,
  ) {
    return handleApi(
      () => _api.userWithdraw('Bearer $token', _sterilizer, req),
    );
  }

  Future<Either<Failure, AllNotificationResponse>> getAllNotifications(
    String token,
  ) {
    return handleApi(
      () => _api.getAllNotifications('Bearer $token', _sterilizer),
    );
  }

  Future<Either<Failure, MarkNotificationAsReadResponse>>
  markAllNotificationsAsRead(String token) {
    return handleApi(
      () => _api.markAllNotificationsAsRead('Bearer $token', _sterilizer),
    );
  }

  Future<Either<Failure, GetAllPromoResponse>> getAllAvailablePromos(
    String token,
  ) {
    return handleApi(() => _api.getAllPromos('Bearer $token', _sterilizer));
  }

  Future<Either<Failure, BaseResponse>> redeemAPromo(
    String token,
    RedeemAPromoRequest req,
  ) {
    return handleApi(
      () => _api.redeemAPromo('Bearer $token', _sterilizer, req),
    );
  }

  Future<Either<Failure, GetAllBeneficiariesResponse>> getAllBeneficiaries(
    String token,
  ) {
    return handleApi(
      () => _api.getAllBeneficiaries('Bearer $token', _sterilizer),
    );
  }

  Future<Either<Failure, GetAllBeneficiariesResponse>> getMinimalBeneficiaries(
    String token,
  ) {
    return handleApi(
      () => _api.getMinimalBeneficiaries('Bearer $token', _sterilizer),
    );
  }

  Future<Either<Failure, EpinResponse>> purchaseEpin(
    String token,
    EpinRequest req,
  ) {
    return handleApi(
      () => _api.initiateEpinPurchase('Bearer $token', _sterilizer, req),
    );
  }

  Future<Either<Failure, epin_models.EpinTransactionRequestsResponse>>
  getEpinTransactionRequests(String token) {
    // We use handleApi to keep existing error handling behavior.
    return handleApi(() async {
      // inside handleApi block where you loop pages
      int page = 1;
      epin_models.EpinTransactionRequestsResponse? lastResp;
      final List<epin_models.Datum> allData = [];

      try {
        while (true) {
          // IMPORTANT: pass page explicitly
          final pageResp = await _api.getEpinTransactionRequests(
            'Bearer $token', // AccessToken header
            _sterilizer, // keep your existing header
            page, // page param
          );

          // Debug: page-level metadata
          log(
            'EPIN_DBG: fetched page=$page, status=${pageResp.status}, '
            'currentPage=${pageResp.data?.currentPage}, lastPage=${pageResp.data?.lastPage}, '
            'nextPageUrl=${pageResp.data?.nextPageUrl}',
          );

          final pageItems = pageResp.data?.data ?? [];
          log('EPIN_DBG: page=$page -> items=${pageItems.length}');

          if (pageItems.isNotEmpty) {
            // print up to 3 sample items for inspection
            for (var i = 0; i < pageItems.length && i < 3; i++) {
              final it = pageItems[i];
              log(
                'EPIN_DBG sample page=$page item$i -> id=${it.id}, ref=${it.reference}, '
                'agentPhone=${it.agentPhone}, createdAt=${it.createdAt}',
              );
            }
          }

          lastResp = pageResp;
          allData.addAll(pageItems);

          // decide whether to fetch next page
          final currentPage = pageResp.data?.currentPage;
          final lastPage = pageResp.data?.lastPage;
          final nextPageUrl = pageResp.data?.nextPageUrl;

          if (lastPage != null) {
            if (currentPage == null || currentPage >= lastPage) {
              log('EPIN_DBG: reached lastPage=$lastPage at page=$currentPage');
              break;
            } else {
              page++;
              continue;
            }
          } else {
            if (nextPageUrl == null) {
              log('EPIN_DBG: nextPageUrl null -> stopping at page=$page');
              break;
            }
            // try to extract page param from nextPageUrl (best effort)
            final uri = Uri.tryParse(nextPageUrl);
            final nextPageStr = uri?.queryParameters['page'];
            final nextPage = nextPageStr != null
                ? int.tryParse(nextPageStr)
                : null;
            if (nextPage != null && nextPage > page) {
              page = nextPage;
              continue;
            } else {
              // fallback: increment page (server might use simple page param)
              page++;
              continue;
            }
          }
        }
      } catch (e, st) {
        log('EPIN_DBG: exception while paging epin: $e\n$st');
      }

      // Build merged Data object preserving useful metadata from lastResp (you can choose another page's metadata if you prefer)
      final mergedData = epin_models.Data(
        currentPage: 1,
        data: allData,
        firstPageUrl: lastResp!.data?.firstPageUrl,
        from: lastResp.data?.from,
        lastPage: lastResp.data?.lastPage,
        lastPageUrl: lastResp.data?.lastPageUrl,
        links: lastResp.data?.links,
        nextPageUrl: lastResp.data?.nextPageUrl,
        path: lastResp.data?.path,
        perPage: lastResp.data?.perPage,
        prevPageUrl: lastResp.data?.prevPageUrl,
        to: lastResp.data?.to,
        total: lastResp.data?.total,
      );
      log('EPIN_DBG: total collected epin items = ${allData.length}');
      if (allData.isNotEmpty) {
        log(
          'EPIN_DBG: first collected sample -> id=${allData.first.id}, ref=${allData.first.reference}, createdAt=${allData.first.createdAt}',
        );
        log(
          'EPIN_DBG: last collected sample -> id=${allData.last.id}, ref=${allData.last.reference}, createdAt=${allData.last.createdAt}',
        );
      }

      return epin_models.EpinTransactionRequestsResponse(
        status: lastResp.status,
        data: mergedData,
      );
    });
  }

  // other endpoint …
}
