import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';

/// Returns 'MTN' | 'AIRTEL' | 'GLO' | '9MOBILE', or null if the prefix
/// isn't recognised. Accepts 080… or +23480… formats.
String? detectNetworkCode(String rawPhone) {
  var phone = rawPhone.replaceAll(RegExp(r'\s+'), '');
  if (phone.startsWith('+234')) phone = '0${phone.substring(4)}';
  if (phone.length < 4) return null;

  const mtn = [
    '0803',
    '0806',
    '0703',
    '0706',
    '0813',
    '0816',
    '0810',
    '0814',
    '0903',
    '0906',
    '0913',
    '0916',
  ];
  const airtel = [
    '0802',
    '0808',
    '0708',
    '0701',
    '0812',
    '0901',
    '0902',
    '0904',
    '0907',
    '0912',
  ];
  const glo = ['0705', '0805', '0807', '0815', '0811', '0905', '0915'];
  const nineMobile = ['0809', '0817', '0818', '0909', '0908'];

  final prefix = phone.substring(0, 4);
  if (mtn.contains(prefix)) return 'MTN';
  if (airtel.contains(prefix)) return 'AIRTEL';
  if (glo.contains(prefix)) return 'GLO';
  if (nineMobile.contains(prefix)) return 'T2';
  return null;
}

String resolveNetworkCode(UserTransactions txn) {
  final sub = txn.subProduct?.autoSubProdId?.trim() ?? '';
  if (sub.isNotEmpty && !sub.contains('_')) return sub;
  return txn.subProduct?.product?.autoProdId?.trim() ?? '';
}

String resolveAmount(UserTransactions txn) {
  final deduct = double.tryParse(txn.deductAmount?.toString() ?? '') ?? 0.0;
  return deduct != 0.0
      ? txn.deductAmount.toCurrency()
      : txn.amount.toCurrency();
}
