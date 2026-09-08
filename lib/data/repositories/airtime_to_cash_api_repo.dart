import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/data/airtime_to_cash_repository.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_api_model.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_transaction.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:bundlegram/data/repositories/api_services.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final airtimeToCashRepositoryProvider = Provider<IAirtimeToCashRepository>(
  (ref) => ApiAirtimeToCashRepository(
    ref.read(apiServiceProvider),
    ref.read(secureStorageHelperProvider),
  ),
);

class _NetworkDisplayConfig {
  const _NetworkDisplayConfig({
    required this.logoAsset,
    required this.minAmount,
    required this.maxAmount,
    required this.dailyLimit,
    required this.shareCode,
  });

  final String logoAsset;
  final double minAmount;
  final double maxAmount;
  final double dailyLimit;
  final String shareCode;
}

final Map<String, _NetworkDisplayConfig> _networkDisplayConfigs = {
  'MTN': _NetworkDisplayConfig(
    logoAsset: Assets.svgs.mtnnw,
    minAmount: 1000,
    maxAmount: 100000,
    dailyLimit: 100000,
    shareCode: '*321#',
  ),
  'AIRTEL': _NetworkDisplayConfig(
    logoAsset: Assets.svgs.airtel,
    minAmount: 1000,
    maxAmount: 100000,
    dailyLimit: 100000,
    shareCode: '*432#',
  ),
  'GLO': _NetworkDisplayConfig(
    logoAsset: Assets.svgs.glo,
    minAmount: 1000,
    maxAmount: 100000,
    dailyLimit: 100000,
    shareCode: '*131*PIN#',
  ),
  '9MOBILE': _NetworkDisplayConfig(
    logoAsset: Assets.svgs.a9mobile,
    minAmount: 1000,
    maxAmount: 100000,
    dailyLimit: 100000,
    shareCode: '*223#',
  ),
};

class ApiAirtimeToCashRepository implements IAirtimeToCashRepository {
  ApiAirtimeToCashRepository(this._api, this._storage);

  final ApiService _api;
  final SecureStorageHelper _storage;

  Future<Either<Failure, String>> _requireToken() async {
    final token = await _storage.getAuthToken();
    if (token == null || token.isEmpty) {
      return const Left(
        AuthenticationFailure(['Authentication token missing']),
      );
    }
    return Right(token);
  }

  @override
  Future<Either<Failure, List<NetworkConfig>>> getNetworks() async {
    final tokenResult = await _requireToken();
    return tokenResult.fold(Left.new, (token) async {
      final result = await _api.getAirtimeToCashNetworks(token);
      return result.fold(Left.new, (response) {
        final dtos = response.data ?? [];
        final networks = dtos.map((dto) {
          final code = (dto.code ?? '').toUpperCase();
          final display = _networkDisplayConfigs[code];

          return NetworkConfig(
            // Stored uppercase to match exactly what the API expects back
            // in request bodies (`"network": "MTN"`), avoiding a
            // case-mismatch bug when this id round-trips into a request.
            id: code,
            name: dto.name ?? code,
            logoAsset: display?.logoAsset ?? Assets.svgs.simcard2,
            // The  /networks response has no availability flags — it
            // appears to simply omit unsupported networks rather than
            // include-and-flag them. Every network returned here is
            // therefore treated as available.
            isAvailable: true,
            hasActiveConfig: true,
            supportsInstantConversion: true,
            conversionRatePercent: dto.rate ?? dto.userPercentage ?? 0,
            minAmount: display?.minAmount ?? 1000,
            maxAmount: display?.maxAmount ?? 100000,
            dailyLimit: display?.dailyLimit ?? 100000,
            shareCode: display?.shareCode ?? '',
          );
        }).toList();
        return Right(networks);
      });
    });
  }

  @override
  Future<Either<Failure, Unit>> sendOtp({
    required NetworkConfig network,
    required String phoneNumber,
  }) async {
    final tokenResult = await _requireToken();
    return tokenResult.fold(Left.new, (token) async {
      final result = await _api.generateAirtimeToCashOtp(
        token,
        AirtimeGenerateOtpRequest(network: network.id, phone: phoneNumber),
      );
      return result.fold(Left.new, (_) => const Right(unit));
    });
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required NetworkConfig network,
    required String phoneNumber,
    required String otp,
  }) async {
    final tokenResult = await _requireToken();
    return tokenResult.fold(Left.new, (token) async {
      final result = await _api.verifyAirtimeToCashOtp(
        token,
        AirtimeVerifyOtpRequest(
          network: network.id,
          phone: phoneNumber,
          otp: otp,
        ),
      );
      return result.fold(Left.new, (response) {
        final sessionId = response.data?.sessionId;
        if (sessionId == null || sessionId.isEmpty) {
          return const Left(
            UnknownFailure(['OTP verified but no session was returned.']),
          );
        }
        return Right(sessionId);
      });
    });
  }

  @override
  Future<Either<Failure, Unit>> checkQuota({
    required NetworkConfig network,
    required double amount,
  }) async {
    final tokenResult = await _requireToken();
    return tokenResult.fold(Left.new, (token) async {
      final result = await _api.checkAirtimeToCashQuota(
        token,
        AirtimeCheckQuotaRequest(network: network.id, amount: amount),
      );
      return result.fold(Left.new, (_) => const Right(unit));
    });
  }

  @override
  Future<Either<Failure, AirtimeToCashTransaction>> convert({
    required NetworkConfig network,
    required String phoneNumber,
    required double amount,
    required String airtimeSharePin,
    required String sessionId,
  }) async {
    final tokenResult = await _requireToken();
    return tokenResult.fold(Left.new, (token) async {
      final result = await _api.transferAirtimeToCash(
        token,
        AirtimeTransferRequest(
          network: network.id,
          phone: phoneNumber,
          amount: amount,
          pin: airtimeSharePin,
          sessionId: sessionId,
        ),
      );

      return result.fold(Left.new, (response) {
        final data = response.data;
        final code = data?.code;

        // This API reports business-logic outcomes via `code` inside a
        // 200 response body, not just HTTP status — a request that HTTP-
        // succeeds can still represent a failed transfer.
        if (code != 2000 && code != 4000) {
          return Left(
            ServerFailure([
              data?.message ?? response.message ?? 'Airtime transfer failed',
            ]),
          );
        }

        final status = code == 4000
            ? AirtimeToCashTxnStatus.processing
            : AirtimeToCashTxnStatus.success;

        // The transfer response has no numeric credited amount — only
        // `message`/`reference`. amountReceived is computed from the
        // network's rate; the authoritative confirmation text is
        // response.message, which the UI should prefer to display.
        final computedReceived = amount * network.conversionRatePercent / 100;

        return Right(
          AirtimeToCashTransaction(
            id:
                data?.reference ??
                DateTime.now().millisecondsSinceEpoch.toString(),
            reference: data?.reference ?? '',
            dateTime: DateTime.now(),
            amountSold: amount,
            amountReceived: computedReceived,
            networkId: network.id,
            networkName: network.name,
            phoneNumber: phoneNumber,
            type: AirtimeToCashTxnType.instant,
            status: status,
            conversionRatePercent: network.conversionRatePercent,
            failureReason: response.message,
          ),
        );
      });
    });
  }

  @override
  Future<Either<Failure, List<AirtimeToCashTransaction>>> getTransactions({
    String? query,
  }) async {
    // TODO(airtime-to-cash)
    return const Right([]);
  }
}
