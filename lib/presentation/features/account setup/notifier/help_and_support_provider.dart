import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final helpSupportProvider = ChangeNotifierProvider<HelpSupportProvider>((ref) {
  return HelpSupportProvider();
});

class HelpSupportProvider extends ChangeNotifier {
  Future<void> copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    context.showSuccessSnackBar('Copied to clipboard');
  }

  Future<void> launchEmail(BuildContext context, String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'CustomerSupport-Request',
      },
    );

    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri, mode: LaunchMode.externalApplication);
    // } else {
    //   context.showErrorSnackBar('Could not open email app for $uri');
    // }
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      context.showErrorSnackBar('Could not open email app');
    }
  }

  Future<void> launchPhoneCall(BuildContext context, String phoneNumber) async {
    final uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri, mode: LaunchMode.externalApplication);
    // } else {
    //   context
    //       .showErrorSnackBar('Could not initiate phone call to $phoneNumber');
    // }
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      context.showErrorSnackBar('Could not initiate phone call');
    }
  }
}
