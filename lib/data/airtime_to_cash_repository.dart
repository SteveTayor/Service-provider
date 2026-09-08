import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_transaction.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:dartz/dartz.dart';

///Airtime-to-Cash data layer.
///
///   - There is no balance-check endpoint, so this interface has no
///
///   - [verifyOtp] returns a `sessionId` (String), the
///      /verify endpoint's only payload is `{sessionId}`. That
///     sessionId must be threaded through to [convert].
///   - [checkQuota] is a required step before [convert]
///     /check-quota endpoint needs the amount, so this can only
///     run once the user has entered how much they want to sell
///
abstract class IAirtimeToCashRepository {
  /// Returns the list of networks with their live conversion rates.
  Future<Either<Failure, List<NetworkConfig>>> getNetworks();

  /// Sends an OTP to [phoneNumber] for the given [network].
  Future<Either<Failure, Unit>> sendOtp({
    required NetworkConfig network,
    required String phoneNumber,
  });

  /// Verifies a submitted [otp] for [phoneNumber].
  /// On success, returns the `sessionId` required by [convert].
  Future<Either<Failure, String>> verifyOtp({
    required NetworkConfig network,
    required String phoneNumber,
    required String otp,
  });

  /// Checks whether [network] can currently accept a conversion of
  /// [amount]. Must be called after the user enters an amount and before
  /// [convert] — the real backend can reject amounts it has no quota for.
  Future<Either<Failure, Unit>> checkQuota({
    required NetworkConfig network,
    required double amount,
  });

  /// Submits the conversion request. [sessionId] must be the value
  /// returned by [verifyOtp] for this same phone/network/OTP flow.
  Future<Either<Failure, AirtimeToCashTransaction>> convert({
    required NetworkConfig network,
    required String phoneNumber,
    required double amount,
    required String airtimeSharePin,
    required String sessionId,
  });

  /// Fetches recent Airtime-to-Cash transactions, optionally filtered by a
  /// free-text [query] (matches network name or phone number).
  Future<Either<Failure, List<AirtimeToCashTransaction>>> getTransactions({
    String? query,
  });
}
