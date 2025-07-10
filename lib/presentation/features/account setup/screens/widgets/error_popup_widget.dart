import 'package:flutter/material.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:go_router/go_router.dart';

class ErrorPopup extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onOkay;

  const ErrorPopup({
    super.key,
    required this.title,
    required this.message,
    required this.onOkay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.close,
          color: Colors.redAccent,
          size: 50,
        ),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.grey33,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.grey83,
              ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            onOkay();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.logOut,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            "Okay",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
