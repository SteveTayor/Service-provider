import 'package:bundlegram/core/utils/enums.dart';

class ServiceConfig {
  final String title;
  final PlatformProductType type;
  final List<Map<String, String>> bundles;
  final String? inputHint;
  final String? secondaryInputHint;
  final String? dropdownHint;
  final List<String>? imagePaths; // List of provider image paths

  ServiceConfig({
    required this.title,
    required this.type,
    this.bundles = const [],
    this.inputHint,
    this.secondaryInputHint,
    this.dropdownHint,
    this.imagePaths,
  });
}
