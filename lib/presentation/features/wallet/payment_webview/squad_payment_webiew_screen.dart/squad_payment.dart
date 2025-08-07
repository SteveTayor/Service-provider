import 'dart:io';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/presentation/features/wallet/payment_webview/squad_payment_webiew_screen.dart/verification_payment_page.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class SquadWebViewPage extends StatefulWidget {
  final String paymentUrl;
  final String redirectUrlSubstring;
  final String transactionRef;

  const SquadWebViewPage(
      {super.key,
      required this.paymentUrl,
      required this.redirectUrlSubstring,
      required this.transactionRef});

  @override
  State<SquadWebViewPage> createState() => _SquadWebViewPageState();
}

class _SquadWebViewPageState extends State<SquadWebViewPage> {
  late final WebViewController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    final params = WebViewPlatform.instance is WebKitWebViewPlatform
        ? WebKitWebViewControllerCreationParams()
        : const PlatformWebViewControllerCreationParams();

    final controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _loading = true),
          onPageFinished: (_) => setState(() => _loading = false),
          onNavigationRequest: (request) {
            final url = request.url.toLowerCase();
            debugPrint("[WebView] Navigating to: $url");
            if (request.url.startsWith('https://www.google.com')) {
              // ✅ Transaction finished, go verify
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => VerifySquadPaymentPage(
                      transactionRef: widget.transactionRef),
                ),
              );
              return NavigationDecision.prevent;
            }
            // if (url.contains(widget.redirectUrlSubstring.toLowerCase())) {
            //   debugPrint("[WebView] Redirect URL matched: $url");

            //   // ✅ Route to dashboard and verify
            //   Navigator.of(context).push(
            //     MaterialPageRoute(
            //       builder: (_) => VerifySquadPaymentPage(
            //         transactionRef: widget.transactionRef,
            //       ),
            //     ),
            //   );

            //   return NavigationDecision.prevent;
            // }
            // if (url.contains(widget.redirectUrlSubstring.toLowerCase())) {
            //   context.pop(true); // success
            //   return NavigationDecision.prevent;
            // }

            if (url.contains('fail') ||
                url.contains('cancel') ||
                url.contains('close')) {
              context.pop(false); // failure
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pushReplacement(RouteConstants.dashboard);
        return false;
      },
      child: BundlegramScaffold(
        appBar: BundlegramAppbar(
          title: const Text('Complete Payment'),
          showBackButton: true,
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_loading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
