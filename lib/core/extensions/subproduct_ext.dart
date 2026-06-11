import 'package:bundlegram/data/models/products/get_sub_products_response.dart';

extension SubProductUiExtension on SubProduct {
  /// Cleans weird API formatting like \n, \r, \t and repeated spaces.
  String get cleanedSubName {
    return (subName ?? '')
        .replaceAll(RegExp(r'[\r\n\t]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  /// Keeps only the center/core aspect of the plan name.
  ///
  /// Examples:
  /// - Airtel GIFTING 1.5GB Binge 600        -> 1.5GB
  /// - Airtel GIFTING 400MB Flexi 500        -> 400MB
  /// - Airtel GIFTING 75MB Daily Plan        -> 75MB Daily
  /// - MTN GIFTING B1.5TB Broadband          -> B1.5TB
  /// - MTN GIFTING 50Mbps FibreX            -> 50Mbps
  /// - MTN GIFTING KMN1yr Keep My Number    -> KMN1yr
  /// - MTN GIFTING KMN2yrs Keep My Number   -> KMN2yrs
  String get displayName {
    final text = cleanedSubName;
    if (text.isEmpty) return 'Bundle';

    // Special handling for KMN plans.
    final kmnMatch = RegExp(
      r'\bKMN\s*\d+\s*(?:yr|yrs|year|years)\b',
      caseSensitive: false,
    ).firstMatch(text);

    if (kmnMatch != null) {
      // Remove spaces so it becomes KMN1yr, KMN2yrs, etc.
      return kmnMatch.group(0)!.replaceAll(RegExp(r'\s+'), '');
    }

    // Match the first meaningful token that contains a size/speed unit.
    // Supports:
    // 1.5GB, 100MB, B1.5TB, 50Mbps, 1Gbps
    final sizeMatch = RegExp(
      r'([A-Za-z]*\d+(?:\.\d+)?\s*(?:TB|GB|MB|Gbps|Mbps))',
      caseSensitive: false,
    ).firstMatch(text);

    if (sizeMatch == null) {
      return text;
    }

    // Keep the matched token exactly, but normalize any inner spaces.
    String result = sizeMatch.group(1)!;
    result = result.replaceAll(RegExp(r'\s+'), '');

    // Keep "Daily" only when it appears after the size token.
    final afterSize = text.substring(sizeMatch.end).trim();
    final hasDaily =
        RegExp(r'\bDaily\b', caseSensitive: false).hasMatch(afterSize);

    if (hasDaily) {
      return '$result Daily';
    }

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
