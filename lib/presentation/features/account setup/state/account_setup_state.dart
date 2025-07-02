import 'package:flutter/material.dart';

/// Model for each step in the account setup flow
class AccountSetupStep {
  final String asset;
  final String title;
  final String label;
  final bool done;
  final String? route;
  final bool isBottomSheet;
  final Widget? bottomSheet;

  AccountSetupStep({
    required this.asset,
    required this.title,
    required this.label,
    required this.done,
    this.route,
    this.isBottomSheet = false,
    this.bottomSheet,
  });
}
