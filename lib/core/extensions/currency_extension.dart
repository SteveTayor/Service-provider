import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';

extension GlobalCurrencyExtension on dynamic {
  /// Call `.toCurrency()` on any dynamic value (num or string)
  String toCurrency() {
    return CurrencyFormatter.format(this);
  }
}
