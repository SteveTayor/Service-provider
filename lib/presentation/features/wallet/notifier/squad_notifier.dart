import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

final squadPaymentProvider = StateNotifierProvider<SquadPaymentNotifier,
    AsyncValue<SquadPaymentResponse?>>((ref) => SquadPaymentNotifier(ref));

class SquadPaymentNotifier
    extends StateNotifier<AsyncValue<SquadPaymentResponse?>> {
  final Ref ref;
  SquadPaymentNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<SquadPaymentResponse?> initializeCardPayment({
    required int amount,
    required String email,
  }) async {
    state = const AsyncValue.loading();
    try {
      final transactionRef = "BNG-${DateTime.now().millisecondsSinceEpoch}";
      final secretKey = dotenv.env['SQUAD_SECRET_KEY'] ?? "";

      final response = await http.post(
        Uri.parse("https://api-d.squadco.com/transaction/initiate"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer sk_0c74e1b0f577868d11288a27a306eba56823b231',
        },
        body: jsonEncode({
          "amount": amount,
          "email": email,
          "currency": "NGN",
          "transaction_ref": transactionRef,
          "callback_url": "https://www.google.com",
          "initiate_type": "inline",
        }),
      );

      final decoded = jsonDecode(response.body);
      print("🔍 Squad init response: $decoded");

      if (response.statusCode == 200 && decoded['status'] == true) {
        final checkoutUrl = decoded['data']?['checkout_url']?.toString();
        final result = SquadPaymentResponse(
          transactionRef: transactionRef,
          checkoutUrl: checkoutUrl,
        );

        await launchUrl(
          Uri.parse(checkoutUrl!),
          mode: LaunchMode.externalApplication,
        );

        // context.pop();
        // context.showErrorSnackBar("Failed to initialize payment.");
        // }
        state = AsyncValue.data(result);
        return result;
      } else {
        state = AsyncValue.error(
            decoded['message']?.toString() ?? 'Failed to initialize payment',
            StackTrace.current);
        return null;
      }
    } catch (e, st) {
      state = AsyncValue.error("Exception: $e", st);
      return null;
    }
  }
}

class SquadPaymentResponse {
  final String transactionRef;
  final String? checkoutUrl;

  SquadPaymentResponse({
    required this.transactionRef,
    this.checkoutUrl,
  });
}
