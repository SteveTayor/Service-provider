import 'dart:convert';

import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/presentation/features/wallet/payment_webview/provider/verification_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class VerifySquadPaymentPage extends ConsumerStatefulWidget {
  final String transactionRef;

  const VerifySquadPaymentPage({super.key, required this.transactionRef});

  @override
  ConsumerState<VerifySquadPaymentPage> createState() =>
      _VerifySquadPaymentPageState();
}

class _VerifySquadPaymentPageState
    extends ConsumerState<VerifySquadPaymentPage> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _verifyTransaction();
  }

  Future<void> _verifyTransaction() async {
    final result = await ref
        .read(squadPaymentVerifierProvider.notifier)
        .verifyTransaction(widget.transactionRef);

    if (result?.success == true) {
      // ✅ Successful funding
      // Optionally refetch wallet balance here
      context.pushReplacement(RouteConstants.dashboard);
    } else {
      context.showErrorSnackBar("Transaction verification failed");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      body: Center(
        child: _loading
            ? const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Verifying payment..."),
                ],
              )
            : const Text("Finalizing..."),
      ),
    );
  }
}
