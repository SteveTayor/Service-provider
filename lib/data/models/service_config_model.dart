import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';

class ServiceConfig {
  final String title;
  final PlatformProductType type;
  final List<Map<String, String>>? bundles;
  final String? inputHint;
  final String? secondaryInputHint;
  final String? dropdownHint;
  final List<String>? dropdownOptions;
  final List<String>? tabs;

  ServiceConfig({
    required this.title,
    required this.type,
    this.bundles,
    this.inputHint,
    this.secondaryInputHint,
    this.dropdownHint,
    this.dropdownOptions,
    this.tabs,
  });
}
