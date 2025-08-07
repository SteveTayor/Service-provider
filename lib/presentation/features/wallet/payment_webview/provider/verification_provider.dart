import 'dart:convert';

import 'package:bundlegram/presentation/features/wallet/payment_webview/models/verify_payment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final squadPaymentVerifierProvider = StateNotifierProvider<SquadPaymentVerifier,
    AsyncValue<SquadPaymentVerificationResponse?>>(
  (ref) => SquadPaymentVerifier(ref),
);

class SquadPaymentVerifier
    extends StateNotifier<AsyncValue<SquadPaymentVerificationResponse?>> {
  final Ref ref;

  SquadPaymentVerifier(this.ref) : super(const AsyncValue.data(null));

  Future<SquadPaymentVerificationResponse?> verifyTransaction(
      String transactionRef) async {
    state = const AsyncValue.loading();

    try {
      final secretKey = dotenv.env['SQUAD_SECRET_KEY'];

      final response = await http.get(
        Uri.parse(
            'https://api-d.squadco.com/transaction/verify/$transactionRef'),
        headers: {
          'Authorization': 'Bearer $secretKey',
        },
      );

      final jsonBody = jsonDecode(response.body) as Map<String, dynamic>;

      final verification = SquadPaymentVerificationResponse.fromJson(jsonBody);

      state = AsyncValue.data(verification);
      return verification;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }
}
