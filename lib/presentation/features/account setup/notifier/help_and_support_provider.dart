import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

final helpSupportProvider = ChangeNotifierProvider<HelpSupportProvider>((ref) {
  return HelpSupportProvider();
});

class HelpSupportProvider extends ChangeNotifier {
  // Future<void> copyToClipboard(BuildContext context, String text) async {
  //   await Clipboard.setData(ClipboardData(text: text));
  //   context.showSuccessSnackBar('Copied to clipboard');
  // }

  // Future<void> launchEmail(BuildContext context, String email) async {
  //   final uri = Uri(
  //     scheme: 'mailto',
  //     path: email,
  //     queryParameters: {
  //       'subject': 'CustomerSupport-Request',
  //     },
  //   );

  //   // if (await canLaunchUrl(uri)) {
  //   //   await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   // } else {
  //   //   context.showErrorSnackBar('Could not open email app for $uri');
  //   // }
  //   try {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   } catch (_) {
  //     context.showErrorSnackBar('Could not open email app');
  //   }
  // }

  // Future<void> launchPhoneCall(BuildContext context, String phoneNumber) async {
  //   final uri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );

  //   // if (await canLaunchUrl(uri)) {
  //   //   await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   // } else {
  //   //   context
  //   //       .showErrorSnackBar('Could not initiate phone call to $phoneNumber');
  //   // }
  //   try {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   } catch (_) {
  //     context.showErrorSnackBar('Could not initiate phone call');
  //   }
  // }

  // Future<void> launchSocial(String url) async {
  //   final uri = Uri.parse(url);
  //   await _launchUri(uri, "Could not open $url");
  // }
  Future<void> copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));

    context.showSuccessSnackBar('Copied to clipboard');
  }

  Future<void> launchEmail(String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'CustomerSupport-Request',
      },
    );

    await _launchUri(uri, "Could not open email app");
  }

  Future<void> launchPhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    await _launchUri(uri, "Could not initiate phone call");
  }

  Future<void> launchSocial(String url) async {
    final uri = Uri.parse(url);
    await _launchUri(uri, "Could not open $url");
  }

  // Convenience wrappers for readability
  Future<void> openTwitter() =>
      launchSocial("https://twitter.com/BundlegramNG");
  Future<void> openFacebook() =>
      launchSocial("https://www.facebook.com/BundlegramNG");
  Future<void> openInstagram() =>
      launchSocial("https://www.instagram.com/bundlegramng/");
  Future<void> openLinkedIn() =>
      launchSocial("https://www.linkedin.com/company/bundlegram");
  Future<void> openTelegram() => launchSocial("https://t.me/bundlegram");
  Future<void> openTikTok() =>
      launchSocial("https://www.tiktok.com/@bundlegram");
  Future<void> openWhatsapp() => launchSocial("https://wa.me/2348133434566");

  Future<void> _launchUri(Uri uri, String errorMsg) async {
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      Fluttertoast.showToast(
        msg: errorMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.error,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
  }
}
