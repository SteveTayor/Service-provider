import 'package:bundlegram/presentation/features/wallet/screen/enterpin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PinAndPurchaseScreen extends ConsumerWidget {
  final String amount;
  final String beneficiary;
  final Future<void> Function(BuildContext context, String pin) onVerified;

  const PinAndPurchaseScreen({
    super.key,
    required this.amount,
    required this.beneficiary,
    required this.onVerified,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EnterPinScreen(
      onVerified: (pin) async {
        await onVerified(context, pin);
      },
    );
  }
}
