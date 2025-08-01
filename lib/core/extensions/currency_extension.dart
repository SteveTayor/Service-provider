import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:intl/intl.dart';

extension GlobalCurrencyExtension on dynamic {
  /// Call `.toCurrency()` on any dynamic value (num or string)
  String toCurrency() {
    return CurrencyFormatter.format(this);
  }
}

final formatter = NumberFormat.currency(
  locale: 'en_NG',
  symbol: '₦',
  decimalDigits: 0,
);

String formatAmount(num amount) {
  return formatter.format(amount);
}
