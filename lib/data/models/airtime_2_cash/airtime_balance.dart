import 'package:equatable/equatable.dart';

class AirtimeBalance extends Equatable {
  const AirtimeBalance({
    required this.amount,
    required this.networkLabel,
  });

  final double amount;

  /// e.g. "MTN BetaGist"
  final String networkLabel;

  @override
  List<Object?> get props => [amount, networkLabel];
}
