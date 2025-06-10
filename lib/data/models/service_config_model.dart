import 'package:bundlegram/core/utils/enums.dart';

class ServiceConfig {
  final String title;
  final PlatformProductType type;
  final List<Map<String, String>>? bundles;
  final String? inputHint;
  final String? secondaryInputHint;
  final String? dropdownHint;

  ServiceConfig({
    required this.title,
    required this.type,
    this.bundles,
    this.inputHint,
    this.secondaryInputHint,
    this.dropdownHint,
  });
}
