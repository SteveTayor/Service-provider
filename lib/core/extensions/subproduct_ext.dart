import 'package:bundlegram/data/models/products/get_sub_products_response.dart';

extension SubProductUiExtension on SubProduct {
  /// Cleans weird API formatting like \n, \r, \t and repeated spaces.
  String get cleanedSubName {
    return (subName ?? '')
        .replaceAll(RegExp(r'[\r\n\t]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  /// Returns the title exactly in the format you want:
  /// - 1.5GB Binge
  /// - 3GB Binge
  /// - 75MB Daily
  /// - 12GB Flexi
  ///
  /// Rules:
  /// - start from the bundle size token (MB/GB/TB)
  /// - remove trailing numeric code like 600, 1000, 5000
  /// - remove the word "Plan"
  /// - normalize spaces
  String get displayName {
    final text = cleanedSubName;
    if (text.isEmpty) return 'Bundle';

    final match = RegExp(
      r'(\d+(?:\.\d+)?\s*(?:TB|GB|MB).*)',
      caseSensitive: false,
    ).firstMatch(text);

    // If no size is found, return the cleaned raw name.
    if (match == null) return text;

    String result = match.group(1)!;

    // Remove trailing numeric package code, e.g. "600", "1000", "5000"
    result = result.replaceFirst(
      RegExp(r'\s+\d+\s*$'),
      '',
    );

    // Remove the word "Plan" anywhere in the result
    result = result.replaceAll(
      RegExp(r'\bPlan\b', caseSensitive: false),
      '',
    );

    // Normalize repeated spaces after cleanup
    result = result.replaceAll(RegExp(r'\s+'), ' ').trim();

    return result;
  }

  /// Used only for sorting bundles by size.
  /// Converts MB / GB / TB into MB so sorting is consistent.
  double get sortSizeInMb {
    final text = cleanedSubName;

    final match = RegExp(
      r'(\d+(?:\.\d+)?)\s*(TB|GB|MB)\b',
      caseSensitive: false,
    ).firstMatch(text);

    if (match == null) {
      return 0;
    }

    final value = double.tryParse(match.group(1)!) ?? 0;
    final unit = match.group(2)!.toUpperCase();

    switch (unit) {
      case 'TB':
        return value * 1024 * 1024;
      case 'GB':
        return value * 1024;
      default:
        return value;
    }
  }
}
