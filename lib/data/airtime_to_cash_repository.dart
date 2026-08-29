import 'package:bundlegram/core/error/failures.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_balance.dart';
import 'package:bundlegram/data/models/airtime_2_cash/airtime_to_cash_transaction.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:dartz/dartz.dart';

/// Contract for the Airtime-to-Cash data layer.
///
/// The presentation layer and provider depend only on this interface, so a
/// [MockAirtimeToCashRepository] can later be swapped for a real API-backed
/// implementation without touching any UI or provider code. Only three
/// things change when the real API is introduced:
///   1. Create `ApiAirtimeToCashRepository implements IAirtimeToCashRepository`.
///   2. Map the API responses into the models used here.
///   3. Point [airtimeToCashRepositoryProvider] at the new implementation.
abstract class IAirtimeToCashRepository {
  /// Returns the list of networks with their current availability/config,
  /// used to populate the "Select Network" step.
  Future<Either<Failure, List<NetworkConfig>>> getNetworks();

  /// Sends an OTP to [phoneNumber] for the given [network].
  /// Returns nothing on success; a [Failure] describes what went wrong.
  Future<Either<Failure, Unit>> sendOtp({
    required NetworkConfig network,
    required String phoneNumber,
  });

  /// Verifies a submitted [otp] for [phoneNumber].
  /// On success, returns the caller's current airtime balance for the
  /// selected network (fetched as part of verification, matching the flow
  /// shown in the reference screenshots).
  Future<Either<Failure, AirtimeBalance>> verifyOtp({
    required NetworkConfig network,
    required String phoneNumber,
    required String otp,
  });

  /// Submits the conversion request after the user confirms.
  Future<Either<Failure, AirtimeToCashTransaction>> convert({
    required NetworkConfig network,
    required String phoneNumber,
    required double amount,
    required String airtimeSharePin,
  });

  /// Fetches recent Airtime-to-Cash transactions, optionally filtered by a
  /// free-text [query] (matches network name or phone number, mirroring the
  /// "Search transactions..." field in the reference screenshots).
  Future<Either<Failure, List<AirtimeToCashTransaction>>> getTransactions({
    String? query,
  });
}
