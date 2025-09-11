import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BvnDisclaimerBottomSheet extends StatefulWidget {
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final VoidCallback? onViewPrivacyPolicy;

  /// If true, shows the "Don't show again" checkbox (persistence not implemented here).
  final bool showDontShowAgain;

  const BvnDisclaimerBottomSheet({
    Key? key,
    this.onConfirm,
    this.onCancel,
    this.onViewPrivacyPolicy,
    this.showDontShowAgain = true,
  }) : super(key: key);

  @override
  State<BvnDisclaimerBottomSheet> createState() =>
      _BvnDisclaimerBottomSheetState();
}

class _BvnDisclaimerBottomSheetState extends State<BvnDisclaimerBottomSheet> {
  bool _agreed = false;
  bool _dontShowAgain = false;

  @override
  Widget build(BuildContext context) {
    // Use your design tokens if you have them (AppColors, screenutil, etc).
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        // Padding accounts for keyboard / bottom inset because the provided showBottomSheet handles viewInsets.
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            // Center(
            //   child: Container(
            //     width: 48,
            //     height: 4,
            //     margin: const EdgeInsets.only(bottom: 16),
            //     decoration: BoxDecoration(
            //       color: Colors.grey.shade300,
            //       borderRadius: BorderRadius.circular(4),
            //     ),
            //   ),
            // ),

            Center(
              child: Text(
                'Disclaimer',
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your information is confidential',
                    style: textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Body text
            Text(
              'We only use the details you provide (BVN, account number and date of birth) to verify your identity and linked bank account. We take your privacy seriously.',
              style: textTheme.bodyMedium,
            ),

            const SizedBox(height: 12),

            // Bullets
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet(context, 'Data is encrypted in transit and at rest.'),
                _bullet(context,
                    'Information is used only for verification and not shared with third parties except as required by law.'),
                _bullet(context,
                    'You can contact support if you have privacy concerns.'),
              ],
            ),

            const SizedBox(height: 12),

            // Optional link to privacy policy
            Row(
              children: [
                TextButton(
                  onPressed: widget.onViewPrivacyPolicy,
                  child: const Text('View privacy policy'),
                ),
                const Spacer(),
              ],
            ),

            if (widget.showDontShowAgain) ...[
              Row(
                children: [
                  Checkbox(
                    value: _dontShowAgain,
                    onChanged: (v) {
                      setState(() => _dontShowAgain = v ?? false);
                      // If you want persistence:
                      // if (_dontShowAgain) save to SharedPreferences: prefs.setBool('hide_bvn_disclaimer', true)
                      // and check that flag before showing the sheet in the future.
                    },
                  ),
                  const SizedBox(width: 4),
                  Expanded(child: Text('Don\'t show this again')),
                ],
              ),
            ],

            const SizedBox(height: 8),

            // Agreement checkbox
            Row(
              children: [
                Checkbox(
                  value: _agreed,
                  onChanged: (v) => setState(() => _agreed = v ?? false),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'I understand and consent to this verification.',
                    style: textTheme.bodyMedium,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onCancel?.call();
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      // shape: RoundedRectangleBorder(
                      //     // borderRadius: BorderRadius.circular(8.r),
                      //     ),
                      elevation: 0,
                    ),
                    onPressed: _agreed
                        ? () {
                            Navigator.of(context).pop();
                            // If you want to persist "don't show again", do it here using SharedPreferences.
                            widget.onConfirm?.call();
                          }
                        : null,
                    child: Text(
                      'Continue',
                      style: context.textTheme.bodySmall
                          ?.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _bullet(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(fontSize: 18)),
          Expanded(
              child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
