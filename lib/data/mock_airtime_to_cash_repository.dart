// import 'package:bundlegram/core/error/failures.dart';
// import 'package:bundlegram/data/models/airtime_to_cash/airtime_to_cash_transaction.dart';
// import 'package:bundlegram/data/models/airtime_to_cash/network_config.dart';
// import 'package:bundlegram/domain/repositories/airtime_to_cash_failures.dart';
// import 'package:bundlegram/domain/repositories/airtime_to_cash_repository.dart';
// import 'package:bundlegram/gen/assets.gen.dart';
// import 'package:dartz/dartz.dart';

// /// Mock implementation of [IAirtimeToCashRepository], kept for tests,
// /// design/QA review, and local development. Not the default —
// /// `airtimeToCashRepositoryProvider` points at [ApiAirtimeToCashRepository].
// ///
// /// ── Deterministic test scenarios (no randomness) ──────────────────────
// /// OTP request  — controlled by the last digit of the phone number:
// ///   ends with '0'  → simulated NetworkFailure  ("Unable to send OTP")
// ///   ends with '9'  → simulated ServerFailure
// ///   anything else  → success
// ///
// /// OTP verification — the mock always "sends" the code 123456:
// ///   '123456'       → success, returns a fake sessionId
// ///   '000000'       → simulated ExpiredOtpFailure
// ///   '999999'       → simulated NetworkFailure
// ///   any other 6 digits → InvalidOtpFailure
// ///
// /// Quota check — controlled by the amount:
// ///   amount % 1000 == 900  → simulated quota failure
// ///   anything else         → success
// ///
// /// Conversion submission — controlled by the amount entered:
// ///   amount % 1000 == 300  → partial success (design/QA only — the real
// ///                           API has no partial-success response shape)
// ///   amount % 1000 == 400  → processing (mirrors real API's code 4000)
// ///   amount % 1000 == 500  → simulated ServerFailure
// ///   anything else         → success, credited at the network's rate
// class MockAirtimeToCashRepository implements IAirtimeToCashRepository {
//   final List<AirtimeToCashTransaction> _transactions = [
//     AirtimeToCashTransaction(
//       id: 'txn_seed_1',
//       reference: 'e1a3cb0823cf4ea29713f692c9293db3',
//       dateTime: DateTime(2026, 8, 17, 16, 49, 22),
//       amountSold: 1000,
//       amountReceived: 0,
//       networkId: 'MTN',
//       networkName: 'MTN',
//       phoneNumber: '09068988504',
//       type: AirtimeToCashTxnType.instant,
//       status: AirtimeToCashTxnStatus.failed,
//       conversionRatePercent: 83,
//       failureReason: 'Some transactions could not be completed.',
//     ),
//   ];

//   int _txnCounter = 1;

//   List<NetworkConfig> get _networks => [
//         NetworkConfig(
//           id: 'MTN',
//           name: 'MTN',
//           logoAsset: Assets.svgs.mtnnw,
//           isAvailable: true,
//           hasActiveConfig: true,
//           supportsInstantConversion: true,
//           conversionRatePercent: 83,
//           minAmount: 1000,
//           maxAmount: 100000,
//           dailyLimit: 100000,
//           shareCode: '*321#',
//         ),
//         NetworkConfig(
//           id: 'AIRTEL',
//           name: 'Airtel',
//           logoAsset: Assets.svgs.airtel,
//           isAvailable: true,
//           hasActiveConfig: true,
//           supportsInstantConversion: true,
//           conversionRatePercent: 80,
//           minAmount: 1000,
//           maxAmount: 100000,
//           dailyLimit: 100000,
//           shareCode: '*432#',
//         ),
//         NetworkConfig(
//           id: 'GLO',
//           name: 'Glo',
//           logoAsset: Assets.svgs.glo,
//           isAvailable: true,
//           hasActiveConfig: false,
//           supportsInstantConversion: false,
//           conversionRatePercent: 75,
//           minAmount: 1000,
//           maxAmount: 100000,
//           dailyLimit: 100000,
//           shareCode: '*131*PIN#',
//         ),
//         NetworkConfig(
//           id: '9MOBILE',
//           name: '9mobile',
//           logoAsset: Assets.svgs.a9mobile,
//           isAvailable: false,
//           hasActiveConfig: false,
//           supportsInstantConversion: false,
//           conversionRatePercent: 75,
//           minAmount: 1000,
//           maxAmount: 100000,
//           dailyLimit: 100000,
//           shareCode: '*223#',
//         ),
//       ];

//   @override
//   Future<Either<Failure, List<NetworkConfig>>> getNetworks() async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     return Right(_networks);
//   }

//   @override
//   Future<Either<Failure, Unit>> sendOtp({
//     required NetworkConfig network,
//     required String phoneNumber,
//   }) async {
//     await Future.delayed(const Duration(milliseconds: 1200));

//     final lastDigit = phoneNumber.isNotEmpty
//         ? phoneNumber.substring(phoneNumber.length - 1)
//         : '';

//     if (lastDigit == '0') {
//       return const Left(
//         NetworkFailure(['Unable to send OTP. Check your connection.']),
//       );
//     }
//     if (lastDigit == '9') {
//       return const Left(ServerFailure(['Could not reach the OTP service.']));
//     }
//     return Right(unit);
//   }

//   @override
//   Future<Either<Failure, String>> verifyOtp({
//     required NetworkConfig network,
//     required String phoneNumber,
//     required String otp,
//   }) async {
//     await Future.delayed(const Duration(milliseconds: 1000));

//     if (otp == '000000') {
//       return const Left(ExpiredOtpFailure(['This OTP has expired.']));
//     }
//     if (otp == '999999') {
//       return const Left(NetworkFailure(['Could not verify OTP.']));
//     }
//     if (otp != '123456') {
//       return const Left(InvalidOtpFailure(['Incorrect OTP entered.']));
//     }

//     return Right('mock_session_${DateTime.now().millisecondsSinceEpoch}');
//   }

//   @override
//   Future<Either<Failure, Unit>> checkQuota({
//     required NetworkConfig network,
//     required double amount,
//   }) async {
//     await Future.delayed(const Duration(milliseconds: 600));

//     if (amount.toInt() % 1000 == 900) {
//       return const Left(
//         ServerFailure(['No available recipient for this amount right now.']),
//       );
//     }
//     return const Right(unit);
//   }

//   @override
//   Future<Either<Failure, AirtimeToCashTransaction>> convert({
//     required NetworkConfig network,
//     required String phoneNumber,
//     required double amount,
//     required String airtimeSharePin,
//     required String sessionId,
//   }) async {
//     await Future.delayed(const Duration(milliseconds: 1500));

//     _txnCounter++;
//     final ref = 'mock_txn_ref_$_txnCounter';
//     final now = DateTime.now();
//     final amountMod = amount.toInt() % 1000;

//     if (amountMod == 500) {
//       final txn = AirtimeToCashTransaction(
//         id: 'txn_$_txnCounter',
//         reference: ref,
//         dateTime: now,
//         amountSold: amount,
//         amountReceived: 0,
//         networkId: network.id,
//         networkName: network.name,
//         phoneNumber: phoneNumber,
//         type: AirtimeToCashTxnType.instant,
//         status: AirtimeToCashTxnStatus.failed,
//         conversionRatePercent: network.conversionRatePercent,
//         failureReason: 'Server error while processing conversion.',
//       );
//       _transactions.insert(0, txn);
//       return const Left(ServerFailure(['Conversion could not be completed.']));
//     }

//     if (amountMod == 400) {
//       final txn = AirtimeToCashTransaction(
//         id: 'txn_$_txnCounter',
//         reference: ref,
//         dateTime: now,
//         amountSold: amount,
//         amountReceived: amount * network.conversionRatePercent / 100,
//         networkId: network.id,
//         networkName: network.name,
//         phoneNumber: phoneNumber,
//         type: AirtimeToCashTxnType.instant,
//         status: AirtimeToCashTxnStatus.processing,
//         conversionRatePercent: network.conversionRatePercent,
//         failureReason: 'Your airtime conversion request is being processed. '
//             'You will be credited once confirmed.',
//       );
//       _transactions.insert(0, txn);
//       return Right(txn);
//     }

//     if (amountMod == 300) {
//       // Design/QA only — see class doc.
//       final partialReceived = (amount * network.conversionRatePercent / 100) * 0.8;
//       final txn = AirtimeToCashTransaction(
//         id: 'txn_$_txnCounter',
//         reference: ref,
//         dateTime: now,
//         amountSold: amount,
//         amountReceived: partialReceived,
//         networkId: network.id,
//         networkName: network.name,
//         phoneNumber: phoneNumber,
//         type: AirtimeToCashTxnType.instant,
//         status: AirtimeToCashTxnStatus.partial,
//         conversionRatePercent: network.conversionRatePercent,
//         failureReason: 'Some airtime could not be converted. '
//             'Please contact support if needed.',
//       );
//       _transactions.insert(0, txn);
//       return Right(txn);
//     }

//     final received = amount * network.conversionRatePercent / 100;
//     final txn = AirtimeToCashTransaction(
//       id: 'txn_$_txnCounter',
//       reference: ref,
//       dateTime: now,
//       amountSold: amount,
//       amountReceived: received,
//       networkId: network.id,
//       networkName: network.name,
//       phoneNumber: phoneNumber,
//       type: AirtimeToCashTxnType.instant,
//       status: AirtimeToCashTxnStatus.success,
//       conversionRatePercent: network.conversionRatePercent,
//     );
//     _transactions.insert(0, txn);
//     return Right(txn);
//   }

//   @override
//   Future<Either<Failure, List<AirtimeToCashTransaction>>> getTransactions({
//     String? query,
//   }) async {
//     await Future.delayed(const Duration(milliseconds: 600));

//     if (query == null || query.trim().isEmpty) {
//       return Right(List.unmodifiable(_transactions));
//     }

//     final q = query.trim().toLowerCase();
//     final filtered = _transactions.where((t) {
//       return t.networkName.toLowerCase().contains(q) ||
//           t.phoneNumber.contains(q);
//     }).toList();
//     return Right(filtered);
//   }
// }
