import 'package:equatable/equatable.dart';

enum AirtimeToCashTxnStatus { success, failed, processing, partial, pending }

extension AirtimeToCashTxnStatusX on AirtimeToCashTxnStatus {
  String get label {
    switch (this) {
      case AirtimeToCashTxnStatus.success:
        return 'SUCCESS';
      case AirtimeToCashTxnStatus.failed:
        return 'FAILED';
      case AirtimeToCashTxnStatus.processing:
        return 'PROCESSING';
      case AirtimeToCashTxnStatus.partial:
        return 'PARTIAL';
      case AirtimeToCashTxnStatus.pending:
        return 'PENDING';
    }
  }
}

enum AirtimeToCashTxnType { instant, manual }

extension AirtimeToCashTxnTypeX on AirtimeToCashTxnType {
  String get label =>
      this == AirtimeToCashTxnType.instant ? 'INSTANT' : 'MANUAL';
}

/// A single Airtime-to-Cash conversion record.
class AirtimeToCashTransaction extends Equatable {
  const AirtimeToCashTransaction({
    required this.id,
    required this.reference,
    required this.dateTime,
    required this.amountSold,
    required this.amountReceived,
    required this.networkId,
    required this.networkName,
    required this.phoneNumber,
    required this.type,
    required this.status,
    required this.conversionRatePercent,
    this.failureReason,
  });

  final String id;
  final String reference;
  final DateTime dateTime;

  /// Airtime amount the user attempted to sell.
  final double amountSold;

  /// Cash amount credited (or, for [AirtimeToCashTxnStatus.partial], the
  /// successfully-converted portion). For [AirtimeToCashTxnStatus.processing]
  /// this is the *expected* amount, computed client-side from the
  /// network's rate — the real transfer response has no numeric credited-
  /// amount field, only a free-text `message` and `reference`.
  final double amountReceived;

  final String networkId;
  final String networkName;
  final String phoneNumber;
  final AirtimeToCashTxnType type;
  final AirtimeToCashTxnStatus status;
  final int conversionRatePercent;
  final String? failureReason;

  @override
  List<Object?> get props => [
    id,
    reference,
    dateTime,
    amountSold,
    amountReceived,
    networkId,
    networkName,
    phoneNumber,
    type,
    status,
    conversionRatePercent,
    failureReason,
  ];
}
