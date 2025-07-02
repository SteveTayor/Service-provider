import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _nairaFormat = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '₦',
    decimalDigits: 2,
  );

  static String format(dynamic value) {
    try {
      final amount = value is num
          ? value
          : double.tryParse(value.toString().replaceAll(',', '')) ?? 0;
      return _nairaFormat.format(amount);
    } catch (e) {
      return '₦0.00';
    }
  }
}
